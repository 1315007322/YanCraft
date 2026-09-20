import MarkdownIt from "markdown-it"
import hljs from "highlight.js"

const md = new MarkdownIt({
  html: false,
  linkify: true,
  typographer: false,
  highlight(str, lang) {
    if (lang && hljs.getLanguage(lang)) {
      try {
        return `<pre class="hljs"><code>${hljs.highlight(str, { language: lang }).value}</code></pre>`
      } catch {
        // fall through
      }
    }
    return `<pre class="hljs"><code>${md.utils.escapeHtml(str)}</code></pre>`
  }
})

export function renderMarkdown(source?: string) {
  return md.render(source || "")
}

export function formatDate(value?: string) {
  if (!value) {
    return ""
  }
  return value.replace("T", " ").slice(0, 16)
}
