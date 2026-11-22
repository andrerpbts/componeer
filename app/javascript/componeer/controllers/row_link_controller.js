import { Controller } from "@hotwired/stimulus"

// Whole table row as a link, without stealing clicks from links, buttons and inputs inside it.
export default class extends Controller {
  static values = { href: String }

  visit(event) {
    if (event.target.closest("a, button, input, label, select, textarea")) return
    if (window.Turbo) window.Turbo.visit(this.hrefValue)
    else window.location.href = this.hrefValue
  }
}
