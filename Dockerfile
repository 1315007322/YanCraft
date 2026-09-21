# Runtime image only. Build jar + admin dist + blog .output on the host first.
FROM eclipse-temurin:8-jre-jammy
RUN apt-get update \
  && apt-get install -y --no-install-recommends nginx ca-certificates \
  && rm -rf /var/lib/apt/lists/*
COPY --from=node:20-bookworm-slim /usr/local/bin/node /usr/local/bin/node
COPY ruoyi-admin/target/ruoyi-admin.jar /app/ruoyi-admin.jar
COPY ruoyi-blog-admin-ui/dist /usr/share/nginx/html/admin
COPY ruoyi-blog-web/.output /app/blog/.output
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/entrypoint.sh /app/entrypoint.sh
COPY docker/application-druid.yml /app/config/application-druid.yml
COPY docker/application-docker.yml /app/config/application-docker.yml
RUN sed -i 's/\r$//' /app/entrypoint.sh \
  && chmod +x /app/entrypoint.sh \
  && mkdir -p /data/upload /var/log/nginx /app/blog \
  && rm -f /etc/nginx/sites-enabled/default
ENV TZ=Asia/Shanghai \
    NODE_ENV=production
WORKDIR /app
EXPOSE 3000 3001
VOLUME ["/data/upload"]
ENTRYPOINT ["/app/entrypoint.sh"]
