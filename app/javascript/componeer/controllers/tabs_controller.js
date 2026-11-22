import { Controller } from "@hotwired/stimulus"

// Tabs without href: switch on the page. Each tab may name its panel in aria-controls.
export default class extends Controller {
  select({ currentTarget }) {
    this.#activate(currentTarget)
  }

  navigate(event) {
    const step = { ArrowRight: 1, ArrowLeft: -1 }[event.key]
    if (!step) return
    event.preventDefault()
    const tabs = this.#tabs()
    const next = tabs[(tabs.indexOf(event.currentTarget) + step + tabs.length) % tabs.length]
    next.focus()
    this.#activate(next)
  }

  #tabs() {
    return [...this.element.querySelectorAll("button[role=tab]")]
  }

  #activate(selected) {
    this.#tabs().forEach((tab) => {
      const on = tab === selected
      tab.setAttribute("aria-selected", String(on))
      tab.tabIndex = on ? 0 : -1
      const panel = tab.getAttribute("aria-controls") && document.getElementById(tab.getAttribute("aria-controls"))
      if (panel) panel.hidden = !on
    })
    this.dispatch("change", { detail: { tab: selected } })
  }
}
