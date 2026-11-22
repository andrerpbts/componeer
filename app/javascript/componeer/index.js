import PopoverController from "componeer/controllers/popover_controller"
import MultiSelectController from "componeer/controllers/multi_select_controller"
import PeriodPickerController from "componeer/controllers/period_picker_controller"
import DismissableController from "componeer/controllers/dismissable_controller"
import RowLinkController from "componeer/controllers/row_link_controller"

export function registerComponeer(application) {
  application.register("componeer--popover", PopoverController)
  application.register("componeer--multi-select", MultiSelectController)
  application.register("componeer--period-picker", PeriodPickerController)
  application.register("componeer--dismissable", DismissableController)
  application.register("componeer--row-link", RowLinkController)
}
