import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "label"]

  async copy() {
    try {
      await navigator.clipboard.writeText(this.sourceTarget.textContent)
      this.#flash("Copiado")
    } catch {
      this.#flash("Selecione e copie")
      window.getSelection().selectAllChildren(this.sourceTarget)
    }
  }

  #flash(text) {
    if (!this.hasLabelTarget) return
    const original = this.labelTarget.dataset.original || this.labelTarget.textContent
    this.labelTarget.dataset.original = original
    this.labelTarget.textContent = text
    clearTimeout(this.timer)
    this.timer = setTimeout(() => { this.labelTarget.textContent = original }, 1800)
  }
}
