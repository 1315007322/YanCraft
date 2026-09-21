#!/bin/bash
set -e

mkdir -p /data/upload /var/log/nginx /tmp

wait_tcp() {
  local host="$1"
  local port="$2"
  local name="$3"
  echo "waiting for ${name} ${host}:${port}"
  for _ in $(seq 1 60); do
    if (echo >/dev/tcp/"${host}"/"${port}") >/dev/null 2>&1; then
      echo "${name} is up"
      return 0
    fi
    sleep 2
  done
  echo "${name} not ready, continue anyway"
}

if [ -n "${MYSQL_HOST}" ]; then
  wait_tcp "${MYSQL_HOST}" "${MYSQL_PORT:-3306}" mysql
fi
if [ -n "${REDIS_HOST}" ]; then
  wait_tcp "${REDIS_HOST}" "${REDIS_PORT:-6379}" redis
fi

java -Dfile.encoding=UTF-8 \
  -Dspring.config.additional-location=file:/app/config/ \
  -Dspring.profiles.active=druid,docker \
  -jar /app/ruoyi-admin.jar &
JAVA_PID=$!

cd /app/blog
NITRO_HOST=0.0.0.0 NITRO_PORT=3000 HOST=0.0.0.0 PORT=3000 \
  node .output/server/index.mjs &
BLOG_PID=$!

nginx -g "daemon off;" &
NGINX_PID=$!

term() {
  kill -TERM "${JAVA_PID}" "${BLOG_PID}" "${NGINX_PID}" 2>/dev/null || true
  wait
}
trap term SIGINT SIGTERM

wait -n
term
exit 1
