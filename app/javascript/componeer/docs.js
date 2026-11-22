import { Application, Controller } from "@hotwired/stimulus"
import { registerComponeer } from "componeer"

// Documentation-only: copies an icon's helper call from the gallery.
class DocsIconsController extends Controller {
  static targets = ["status"]

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
