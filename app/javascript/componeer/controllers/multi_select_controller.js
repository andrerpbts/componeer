import { Controller } from "@hotwired/stimulus"

// Keeps the "all" box and the trigger summary in sync with the option boxes, and filters options by search.
export default class extends Controller {
  static targets = ["summary", "all", "checkbox", "option", "query", "none"]
  static values = { allLabel: String, noneLabel: String, manyLabel: String }

  connect() {
    this.#sync()
  }

  change() {
    this.#sync()
    this.dispatch("change", { detail: { values: this.#checked().map((box) => box.value) } })
  }

  toggleAll() {
    const on = this.allTarget.checked
    this.checkboxTargets.forEach((box) => { box.checked = on })
    this.change()
  }

  search() {
    const query = this.queryTarget.value.trim().toLowerCase()
    let shown = 0
    this.optionTargets.forEach((option) => {
      const match = !query || option.dataset.label.includes(query)
      option.hidden = !match
      if (match) shown++
    })
    this.noneTarget.hidden = shown > 0
  }

  #checked() {
    return this.checkboxTargets.filter((box) => box.checked)
  }

  #sync() {
    const checked = this.#checked()
    const total = this.checkboxTargets.length
    this.allTarget.checked = checked.length === total
    this.allTarget.indeterminate = checked.length > 0 && checked.length < total
    this.summaryTarget.textContent = this.#summary(checked, total)
  }

  #summary(checked, total) {
    if (checked.length === total) return this.allLabelValue
    if (checked.length === 0) return this.noneLabelValue
    if (checked.length === 1) return checked[0].dataset.optionLabel
    return this.manyLabelValue.replace("%{count}", checked.length)
  }
}
