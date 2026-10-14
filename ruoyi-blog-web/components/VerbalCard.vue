<template>
  <div class="verbal-item" :class="'verbal-t' + type">
    <div
      class="verbal-card"
      :class="{ flipped }"
      role="button"
      tabindex="0"
      :aria-pressed="flipped"
      :aria-label="(flipped ? '收起 ' : '翻开 ') + (card.prompt || '')"
      @click="toggle"
      @keydown.enter.prevent="toggle"
      @keydown.space.prevent="toggle"
    >
      <div class="verbal-face verbal-front">
        <header class="verbal-head">
          <span class="verbal-type">{{ meta.label }}</span>
          <span v-if="card.missed === '1'" class="verbal-ribbon">明天再来</span>
          <span class="verbal-seal" aria-hidden="true">{{ meta.seal }}</span>
        </header>

        <div v-if="type === '0'" class="verbal-pair" :class="{ stacked: pairStacked }">
          <template v-for="(word, i) in parts" :key="i">
            <span v-if="i > 0" class="verbal-divider" aria-hidden="true" />
            <span v-if="word.length <= 4" class="verbal-word grid">
              <i v-for="(ch, j) in Array.from(word)" :key="j">{{ ch }}</i>
            </span>
            <span v-else class="verbal-word">{{ word }}</span>
          </template>
        </div>

        <div v-else-if="type === '1'" class="verbal-chains">
          <div v-for="(chain, i) in chains" :key="i" class="verbal-chain" :class="{ alt: i % 2 === 1 }">
            <template v-for="(link, j) in chain" :key="j">
              <span v-if="j > 0" class="verbal-link" aria-hidden="true" />
              <b>{{ link }}</b>
            </template>
          </div>
        </div>

        <blockquote v-else class="verbal-gist"><p><mark>{{ card.prompt }}</mark></p></blockquote>

        <footer class="verbal-foot">
          <span>{{ footText }}</span>
          <em>点一下翻开</em>
        </footer>
      </div>

      <div class="verbal-face verbal-back">
        <header class="verbal-head">
          <span class="verbal-type">{{ meta.answer }}</span>
          <span class="verbal-mini">{{ card.prompt }}</span>
        </header>
        <p class="verbal-diff">{{ card.difference }}</p>
        <dl v-if="card.collocation || card.confusion || card.ownSentence" class="verbal-notes">
          <div v-if="card.collocation">
            <dt>搭配</dt>
            <dd>{{ card.collocation }}</dd>
          </div>
          <div v-if="card.confusion" class="warn">
            <dt>易混</dt>
            <dd>{{ card.confusion }}</dd>
          </div>
          <div v-if="card.ownSentence" class="own">
            <dt>自己的一句</dt>
            <dd>{{ card.ownSentence }}</dd>
          </div>
        </dl>
        <footer class="verbal-foot">
          <span>{{ footText }}</span>
          <em>再点收起</em>
        </footer>
      </div>
    </div>
    <div v-if="$slots.default" class="verbal-actions"><slot /></div>
  </div>
</template>

<script setup lang="ts">
import type { ExamVerbalCard } from "~/types/cms"

const props = defineProps<{ card: ExamVerbalCard }>()
const emit = defineEmits<{ flip: [value: boolean] }>()

const TYPES: Record<string, { label: string; seal: string; answer: string }> = {
  "0": { label: "实词成语", seal: "辨", answer: "差别" },
  "1": { label: "关联词", seal: "联", answer: "逻辑" },
  "2": { label: "主旨句", seal: "旨", answer: "重点" }
}

const flipped = ref(false)
const type = computed(() => (TYPES[props.card.cardType || ""] ? props.card.cardType! : "0"))
const meta = computed(() => TYPES[type.value])

const parts = computed(() =>
  String(props.card.prompt || "")
    .split(/\s*(?:\/|／|\||｜|、|vs\.?|VS\.?)\s*/)
    .map((item) => item.trim())
    .filter(Boolean)
)

const pairStacked = computed(() => parts.value.length > 3 || parts.value.some((word) => Array.from(word).length > 2))

const chains = computed(() =>
  parts.value.map((part) =>
    part
      .split(/\s*(?:…+|\.{2,}|——|—|~|～|\+)\s*/)
      .map((item) => item.trim())
      .filter(Boolean)
  ).filter((chain) => chain.length)
)

const footText = computed(() => {
  if (props.card.missed === "1") return "明天再来"
  const count = props.card.reviewCount || 0
  const due = (props.card.dueDate || "").slice(5, 10)
  if (!count) return due ? `新卡 · ${due}` : "新卡"
  return due ? `第 ${count} 次 · 下次 ${due}` : `第 ${count} 次`
})

watch(() => props.card.cardId, () => {
  flipped.value = false
})

function toggle() {
  flipped.value = !flipped.value
  emit("flip", flipped.value)
}
</script>

<style scoped>
.verbal-item {
  --v: #b4432f;
  display: flex;
  flex-direction: column;
  gap: 8px;
  min-width: 0;
}

.verbal-t1 {
  --v: #1f6f78;
}

.verbal-t2 {
  --v: #9a6a12;
}

:global([data-theme="night"]) .verbal-t0 {
  --v: #e2836c;
}

:global([data-theme="night"]) .verbal-t1 {
  --v: #5fb3b9;
}

:global([data-theme="night"]) .verbal-t2 {
  --v: #d9a640;
}

.verbal-card {
  display: grid;
  perspective: 1400px;
  border-radius: 16px;
  cursor: pointer;
  outline: none;
  transition: transform 0.2s ease;
}

.verbal-card:hover {
  transform: translateY(-2px);
}

.verbal-card:focus-visible {
  box-shadow: 0 0 0 2px var(--v);
}

.verbal-face {
  grid-area: 1 / 1;
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 12px;
  min-height: 216px;
  padding: 14px 16px 12px;
  overflow: hidden;
  border: 1px solid color-mix(in srgb, var(--v) 24%, var(--line));
  border-radius: 16px;
  background-color: color-mix(in srgb, var(--v) 5%, var(--card));
  box-shadow:
    0 1px 0 rgba(28, 25, 21, 0.04),
    0 12px 26px color-mix(in srgb, var(--v) 9%, transparent);
  backface-visibility: hidden;
  -webkit-backface-visibility: hidden;
  transition: transform 0.55s cubic-bezier(0.2, 0.7, 0.2, 1);
}

.verbal-back {
  transform: rotateY(180deg);
  background-color: color-mix(in srgb, var(--v) 3%, var(--card));
  background-image: none;
}

.verbal-card.flipped .verbal-front {
  transform: rotateY(-180deg);
}

.verbal-card.flipped .verbal-back {
  transform: rotateY(0);
}

.verbal-head {
  display: flex;
  align-items: center;
  gap: 8px;
  min-width: 0;
}

.verbal-type {
  flex: 0 0 auto;
  padding: 1px 9px;
  border-radius: 999px;
  background: color-mix(in srgb, var(--v) 13%, transparent);
  color: var(--v);
  font-size: 12px;
  font-weight: 650;
  letter-spacing: 0.08em;
}

.verbal-ribbon {
  padding: 1px 8px;
  border-radius: 999px;
  border: 1px dashed color-mix(in srgb, var(--v) 55%, transparent);
  color: var(--v);
  font-size: 11px;
}

.verbal-seal {
  display: grid;
  place-items: center;
  width: 30px;
  height: 30px;
  margin-left: auto;
  border: 1.5px solid var(--v);
  color: var(--v);
  font-family: var(--serif);
  font-size: 16px;
  font-weight: 700;
  line-height: 1;
}

.verbal-mini {
  min-width: 0;
  overflow: hidden;
  color: var(--muted);
  font-size: 13px;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.verbal-foot {
  display: flex;
  justify-content: space-between;
  gap: 8px;
  margin-top: auto;
  color: var(--muted);
  font-size: 12px;
}

.verbal-foot em {
  color: var(--v);
  font-style: normal;
}

/* Word / idiom: copybook grid */
.verbal-t0 .verbal-front {
  background-image:
    linear-gradient(color-mix(in srgb, var(--v) 7%, transparent) 1px, transparent 1px),
    linear-gradient(90deg, color-mix(in srgb, var(--v) 7%, transparent) 1px, transparent 1px);
  background-size: 22px 22px;
}

.verbal-t0 .verbal-seal {
  border-radius: 4px;
  transform: rotate(-6deg);
  background: color-mix(in srgb, var(--v) 8%, var(--card));
}

.verbal-pair {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 14px;
  flex-wrap: wrap;
}

.verbal-pair.stacked {
  flex-direction: column;
  gap: 10px;
}

.verbal-divider {
  width: 1px;
  height: 46px;
  background: var(--v);
  position: relative;
}

.verbal-divider::after {
  content: "";
  position: absolute;
  top: 50%;
  left: 50%;
  width: 7px;
  height: 7px;
  background: var(--v);
  transform: translate(-50%, -50%) rotate(45deg);
}

.verbal-pair.stacked .verbal-divider {
  width: 56px;
  height: 1px;
}

.verbal-word {
  color: var(--ink);
  font-family: var(--serif);
  font-size: 22px;
  font-weight: 650;
  text-align: center;
}

.verbal-word.grid {
  display: inline-flex;
}

.verbal-word.grid i {
  --line-mark: color-mix(in srgb, var(--v) 24%, transparent);
  display: grid;
  place-items: center;
  width: 42px;
  height: 42px;
  margin-left: -1px;
  border: 1px solid color-mix(in srgb, var(--v) 42%, transparent);
  background-color: color-mix(in srgb, var(--card) 86%, transparent);
  background-image:
    linear-gradient(90deg, transparent calc(50% - 0.5px), var(--line-mark) calc(50% - 0.5px), var(--line-mark) calc(50% + 0.5px), transparent calc(50% + 0.5px)),
    linear-gradient(0deg, transparent calc(50% - 0.5px), var(--line-mark) calc(50% - 0.5px), var(--line-mark) calc(50% + 0.5px), transparent calc(50% + 0.5px));
  font-size: 24px;
  font-style: normal;
  line-height: 1;
}

.verbal-word.grid i:first-child {
  margin-left: 0;
}

/* Linker: logic chain */
.verbal-t1 .verbal-front {
  background-image: radial-gradient(color-mix(in srgb, var(--v) 17%, transparent) 1px, transparent 1.4px);
  background-size: 14px 14px;
}

.verbal-t1 .verbal-seal {
  border-radius: 50%;
}

.verbal-chains {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 12px;
}

.verbal-chain {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  justify-content: center;
  row-gap: 8px;
}

.verbal-chain b {
  padding: 5px 14px;
  border: 1.5px solid var(--v);
  border-radius: 999px;
  background: var(--v);
  color: #fff;
  font-size: 16px;
  font-weight: 650;
  letter-spacing: 0.04em;
  box-shadow: 0 4px 10px color-mix(in srgb, var(--v) 22%, transparent);
}

.verbal-chain.alt b {
  background: var(--card);
  color: var(--v);
  box-shadow: none;
}

.verbal-link {
  position: relative;
  width: 34px;
  height: 2px;
  margin-right: 6px;
  background: repeating-linear-gradient(90deg, var(--v) 0 5px, transparent 5px 9px);
}

.verbal-link::after {
  content: "";
  position: absolute;
  top: 50%;
  right: -6px;
  border-left: 6px solid var(--v);
  border-top: 4px solid transparent;
  border-bottom: 4px solid transparent;
  transform: translateY(-50%);
}

/* Gist: notebook and highlighter */
.verbal-t2 .verbal-front {
  border-left: 4px solid var(--v);
  background-image: repeating-linear-gradient(180deg, transparent 0 27px, color-mix(in srgb, var(--v) 12%, transparent) 27px 28px);
  background-position: 0 6px;
}

.verbal-t2 .verbal-front::before {
  content: "\201C";
  position: absolute;
  top: 44px;
  left: 8px;
  color: color-mix(in srgb, var(--v) 22%, transparent);
  font-family: var(--serif);
  font-size: 92px;
  line-height: 1;
  pointer-events: none;
}

.verbal-t2 .verbal-seal {
  border-radius: 4px 12px;
}

.verbal-gist {
  position: relative;
  flex: 1;
  display: flex;
  align-items: center;
  margin: 0;
  padding: 6px 4px 0 26px;
  border: 0;
  background: none;
  color: var(--ink);
  font-family: var(--serif);
  font-size: 18px;
  font-weight: 600;
  line-height: 28px;
}

.verbal-gist p {
  margin: 0;
}

.verbal-gist mark {
  padding: 0 2px;
  background: linear-gradient(transparent 58%, color-mix(in srgb, var(--v) 30%, transparent) 58%);
  color: inherit;
  -webkit-box-decoration-break: clone;
  box-decoration-break: clone;
}

/* Answer side */
.verbal-diff {
  margin: 0;
  color: var(--ink);
  font-size: 16px;
  line-height: 1.7;
}

.verbal-notes {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin: 0;
  padding-top: 10px;
  border-top: 1px dashed color-mix(in srgb, var(--v) 28%, var(--line));
}

.verbal-notes div {
  display: grid;
  grid-template-columns: 70px minmax(0, 1fr);
  gap: 8px;
  align-items: baseline;
}

.verbal-notes dt {
  color: var(--muted);
  font-size: 12px;
  letter-spacing: 0.06em;
}

.verbal-notes dd {
  margin: 0;
  color: var(--ink-soft);
  font-size: 14px;
  line-height: 1.6;
}

.verbal-notes .warn dd {
  color: var(--v);
}

.verbal-notes .own dd {
  padding-left: 8px;
  border-left: 2px solid var(--v);
  color: var(--ink);
  font-family: var(--serif);
}

.verbal-actions {
  display: flex;
  justify-content: flex-end;
}

@media (prefers-reduced-motion: reduce) {
  .verbal-face,
  .verbal-card {
    transition: none;
  }
}

@media (max-width: 800px) {
  .verbal-face {
    min-height: 188px;
    padding: 12px 13px 10px;
  }
  .verbal-word.grid i {
    width: 36px;
    height: 36px;
    font-size: 20px;
  }
  .verbal-gist {
    font-size: 16px;
  }
}
</style>
