import { Controller } from "@hotwired/stimulus"

// Drawers, modals and toasts: follow the close link when there is one, else remove the element.
export default class extends Controller {
  static targets = ["close"]
  static values = { after: Number }

  connect() {
    if (this.afterValue > 0) this.timer = setTimeout(() => this.dismiss(), this.afterValue)
  }

  disconnect() {
    clearTimeout(this.timer)
  }

  dismiss(event) {
    if (this.hasCloseTarget && this.closeTarget.href) {
      event?.preventDefault()
      this.closeTarget.click()
    } else {
      this.element.remove()
    }
  }
}
