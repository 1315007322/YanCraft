@echo off
setlocal EnableExtensions
chcp 65001 >nul
cd /d "%~dp0"

set "SKIP_BUILD=0"
if /I "%~1"=="skip-build" set "SKIP_BUILD=1"
if /I "%~1"=="--skip-build" set "SKIP_BUILD=1"

if not exist "docker\deploy.env" (
  echo [ERROR] 缺少 docker\deploy.env
  echo 请复制 docker\deploy.env.example 为 docker\deploy.env 并填写 SSH / MySQL 密码。
  goto :fail
)

where java >nul 2>&1 || (echo [ERROR] 未找到 java & goto :fail)
where mvn >nul 2>&1 || (echo [ERROR] 未找到 mvn & goto :fail)
where npm >nul 2>&1 || (echo [ERROR] 未找到 npm & goto :fail)
where docker >nul 2>&1 || (echo [ERROR] 未找到 docker，请先启动 Docker Desktop & goto :fail)
where python >nul 2>&1 || (echo [ERROR] 未找到 python & goto :fail)

python -c "import paramiko" 2>nul || (
  echo [INFO] 安装 paramiko ...
  python -m pip install paramiko -q
)

if "%SKIP_BUILD%"=="1" goto :image

echo.
echo ========== 1/4 打包 Java JAR ==========
call mvn -pl ruoyi-admin -am package -DskipTests
if errorlevel 1 goto :fail
if not exist "ruoyi-admin\target\ruoyi-admin.jar" (
  echo [ERROR] 未生成 ruoyi-admin\target\ruoyi-admin.jar
  goto :fail
)

echo.
echo ========== 2/4 打包管理后台 dist ==========
pushd ruoyi-blog-admin-ui
if not exist node_modules call npm install
if errorlevel 1 (popd & goto :fail)
call npm run build:prod
if errorlevel 1 (popd & goto :fail)
popd
if not exist "ruoyi-blog-admin-ui\dist\index.html" (
  echo [ERROR] 未生成 ruoyi-blog-admin-ui\dist
  goto :fail
)

echo.
echo ========== 3/4 打包博客 .output ==========
pushd ruoyi-blog-web
if not exist node_modules call npm install
if errorlevel 1 (popd & goto :fail)
set "NUXT_BACKEND_URL=http://127.0.0.1:8080"
set "NUXT_IGNORE_LOCK=1"
call npm run build
if errorlevel 1 (popd & goto :fail)
popd
if not exist "ruoyi-blog-web\.output\server\index.mjs" (
  echo [ERROR] 未生成 ruoyi-blog-web\.output
  goto :fail
)

:image
echo.
echo ========== 4/4 构建镜像并发布到服务器 ==========
docker compose build app
if errorlevel 1 goto :fail

python docker\publish_upload.py
if errorlevel 1 goto :fail

echo.
echo 发布完成。后台 3001，前台 3000。不会启动 Redis / MySQL 容器。
goto :end

:fail
echo.
echo 发布失败。
if /I not "%~1"=="nopause" pause
exit /b 1

:end
if /I not "%~1"=="nopause" if /I not "%~2"=="nopause" pause
exit /b 0
