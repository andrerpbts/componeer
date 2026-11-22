import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  select({ currentTarget }) {
    this.element.querySelectorAll("button[aria-pressed]").forEach((button) => {
      button.setAttribute("aria-pressed", String(button === currentTarget))
    })
    this.dispatch("change", { detail: { value: currentTarget.value } })
  }
}
