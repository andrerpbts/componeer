import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "panel"]

  connect() {
    this.closeOnOutsideClick = (event) => { if (!this.element.contains(event.target)) this.close() }
    this.closeOnEscape = (event) => { if (event.key === "Escape") this.close() }
  }

  disconnect() {
    this.#unlisten()
  }

  toggle() {
    this.panelTarget.hidden ? this.open() : this.close()
  }

  open() {
    this.panelTarget.hidden = false
    this.#button()?.setAttribute("aria-expanded", "true")
    document.addEventListener("mousedown", this.closeOnOutsideClick)
    document.addEventListener("keydown", this.closeOnEscape)
    this.panelTarget.querySelector("input[type=search]")?.focus()
  }

  close() {
    if (this.panelTarget.hidden) return
    this.panelTarget.hidden = true
    this.#button()?.setAttribute("aria-expanded", "false")
    this.#unlisten()
    this.dispatch("closed")
  }

  #button() {
    return this.triggerTarget.querySelector("button, a")
  }

  #unlisten() {
    document.removeEventListener("mousedown", this.closeOnOutsideClick)
    document.removeEventListener("keydown", this.closeOnEscape)
  }
}
