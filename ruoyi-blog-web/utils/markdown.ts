import MarkdownIt from "markdown-it"
import hljs from "highlight.js"

const md = new MarkdownIt({
  html: false,
  linkify: true,
  breaks: true,
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

md.enable("table")

const renderTableOpen = md.renderer.rules.table_open
  || ((tokens, idx, options, env, self) => self.renderToken(tokens, idx, options))
const renderTableClose = md.renderer.rules.table_close
  || ((tokens, idx, options, env, self) => self.renderToken(tokens, idx, options))

md.renderer.rules.table_open = (tokens, idx, options, env, self) => {
  return `<div class="md-table">${renderTableOpen(tokens, idx, options, env, self)}`
}
md.renderer.rules.table_close = (tokens, idx, options, env, self) => {
  return `${renderTableClose(tokens, idx, options, env, self)}</div>`
}

export function renderMarkdown(source?: string) {
  return md.render(source || "")
}

export function formatDate(value?: string) {
  if (!value) {
    return ""
  }
  return value.replace("T", " ").slice(0, 16)
}
