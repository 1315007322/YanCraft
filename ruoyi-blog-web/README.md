# ruoyi-blog-web

YanCraft 博客前台，Nuxt 3 + Vue 3 + TypeScript。

## 启动

1. 后端 `ruoyi-admin` 跑在 `http://127.0.0.1:8080`
2. 复制 `.env.example` 为 `.env`
3. `npm install`
4. `npm run dev` → http://localhost:3000

`/portal/**` 与 `/profile/**` 会代理到后端。

## 路由

- `/` 文章列表
- `/post/{slug|id}` 正文
- `/category/{slug}` 分类
- `/tag/{slug}` 标签
- `/about` 关于
