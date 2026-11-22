import { Controller } from "@hotwired/stimulus"

// A collapsible group of table rows: the tbody holds the group header and its rows.
export default class extends Controller {
  toggle({ currentTarget }) {
    const expand = this.element.hasAttribute("data-collapsed")
    this.element.toggleAttribute("data-collapsed", !expand)
    currentTarget.setAttribute("aria-expanded", String(expand))
  }
}
