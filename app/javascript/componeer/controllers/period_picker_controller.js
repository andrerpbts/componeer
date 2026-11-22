import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["summary", "from", "to"]

  pick({ currentTarget }) {
    this.fromTarget.value = currentTarget.dataset.from
    this.toTarget.value = currentTarget.dataset.to
    this.element.querySelectorAll("[aria-pressed]").forEach((button) => button.setAttribute("aria-pressed", String(button === currentTarget)))
    this.summaryTarget.textContent = currentTarget.textContent.trim()
    this.#changed()
    document.dispatchEvent(new MouseEvent("mousedown", { bubbles: true }))
  }

  change() {
    this.element.querySelectorAll("[aria-pressed]").forEach((button) => button.setAttribute("aria-pressed", "false"))
    const from = this.#br(this.fromTarget.value)
    const to = this.#br(this.toTarget.value)
    this.summaryTarget.textContent = from && to ? `${from} – ${to}` : from ? `Desde ${from}` : to ? `Até ${to}` : "Qualquer data"
    this.#changed()
  }

  #changed() {
    this.dispatch("change", { detail: { from: this.fromTarget.value, to: this.toTarget.value } })
  }

  #br(iso) {
    return iso ? iso.split("-").reverse().join("/") : ""
  }
}
