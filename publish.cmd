@echo off
setlocal EnableExtensions
chcp 65001 >nul
cd /d "%~dp0"

set "SKIP_BUILD=0"
if /I "%~1"=="skip-build" set "SKIP_BUILD=1"
if /I "%~1"=="--skip-build" set "SKIP_BUILD=1"

if not exist "docker\deploy.env" (
  echo [ERROR] ??? docker\deploy.env
  echo ???? docker\deploy.env.example ? docker\deploy.env ????§Õ SSH / MySQL ????
  goto :fail
)

where java >nul 2>&1 || (echo [ERROR] ¦Ä??? java & goto :fail)
where mvn >nul 2>&1 || (echo [ERROR] ¦Ä??? mvn & goto :fail)
where npm >nul 2>&1 || (echo [ERROR] ¦Ä??? npm & goto :fail)
where docker >nul 2>&1 || (echo [ERROR] ¦Ä??? docker?????????? Docker Desktop & goto :fail)
where python >nul 2>&1 || (echo [ERROR] ¦Ä??? python & goto :fail)

python -c "import paramiko" 2>nul || (
  echo [INFO] ??? paramiko ...
  python -m pip install paramiko -q
)

if "%SKIP_BUILD%"=="1" goto :image

echo.
echo ========== 1/4 ??? Java JAR ==========
if exist "ruoyi-admin\target\ruoyi-admin.jar" del /f /q "ruoyi-admin\target\ruoyi-admin.jar"
call mvn -pl ruoyi-admin -am package -DskipTests
if errorlevel 1 goto :fail
if not exist "ruoyi-admin\target\ruoyi-admin.jar" (
  echo [ERROR] ¦Ä???? ruoyi-admin\target\ruoyi-admin.jar
  goto :fail
)

echo.
echo ========== 2/4 ?????????? dist ==========
pushd ruoyi-blog-admin-ui
if not exist node_modules call npm install
if errorlevel 1 (popd & goto :fail)
call npm run build:prod
if errorlevel 1 (popd & goto :fail)
popd
if not exist "ruoyi-blog-admin-ui\dist\index.html" (
  echo [ERROR] ¦Ä???? ruoyi-blog-admin-ui\dist
  goto :fail
)

echo.
echo ========== 3/4 ??????? .output ==========
pushd ruoyi-blog-web
if not exist node_modules call npm install
if errorlevel 1 (popd & goto :fail)
set "NUXT_BACKEND_URL=http://127.0.0.1:8080"
set "NUXT_IGNORE_LOCK=1"
call npm run build
if errorlevel 1 (popd & goto :fail)
popd
if not exist "ruoyi-blog-web\.output\server\index.mjs" (
  echo [ERROR] ¦Ä???? ruoyi-blog-web\.output
  goto :fail
)

:image
echo.
echo ========== 4/4 ??????????????????? ==========
python docker\materialize_blog_output.py
if errorlevel 1 goto :fail
python docker\ensure_docker_engine.py
if errorlevel 1 goto :fail
docker compose --env-file docker\deploy.env build app
if errorlevel 1 goto :fail

python docker\publish_upload.py
if errorlevel 1 goto :fail

echo.
echo ??????¨À???? 3001???? 3000?????????? Redis / MySQL ??????
goto :end

:fail
echo.
echo ????????
if /I not "%~1"=="nopause" pause
exit /b 1

:end
if /I not "%~1"=="nopause" if /I not "%~2"=="nopause" pause
exit /b 0
