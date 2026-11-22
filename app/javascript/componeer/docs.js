import { Application, Controller } from "@hotwired/stimulus"
import { registerComponeer } from "componeer"

// Documentation-only: filters the icon gallery and copies an icon's helper call.
class DocsIconsController extends Controller {
  static targets = ["query", "grid", "status", "none"]

  filter() {
    const query = this.queryTarget.value.trim().toLowerCase()
    const grid = this.gridTargets.find((g) => !g.hidden)
    let shown = 0
    grid.querySelectorAll(".doc-icon").forEach((tile) => {
      const match = !query || tile.dataset.name.includes(query)
      tile.hidden = !match
      if (match) shown++
    })
    this.noneTarget.hidden = shown > 0
    this.statusTarget.textContent = query ? `${shown} ícones` : "Clique num ícone para copiar o código."
  }

  show({ currentTarget }) {
    this.element.querySelectorAll("[data-variant][aria-pressed]").forEach((b) => b.setAttribute("aria-pressed", String(b === currentTarget)))
    this.gridTargets.forEach((grid) => { grid.hidden = grid.dataset.variant !== currentTarget.dataset.variant })
    this.filter()
  }

  async copy({ currentTarget }) {
    const code = currentTarget.dataset.code
    try {
      await navigator.clipboard.writeText(code)
      this.statusTarget.textContent = `Copiado: ${code}`
    } catch {
      this.statusTarget.textContent = code
    }
  }
}

const application = Application.start()
registerComponeer(application)
application.register("docs-icons", DocsIconsController)
