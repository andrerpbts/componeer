module Componeer
  BUILTINS = {
    icon: "Componeer::IconComponent",
    button: "Componeer::ButtonComponent",
    icon_button: "Componeer::IconButtonComponent",
    status_dot: "Componeer::StatusDotComponent",
    status_pill: "Componeer::StatusPillComponent",
    counter: "Componeer::CounterComponent",
    badge: "Componeer::BadgeComponent",
    callout: "Componeer::CalloutComponent",
    empty_state: "Componeer::EmptyStateComponent",
    stack: "Componeer::StackComponent",
    cluster: "Componeer::ClusterComponent",
    field: "Componeer::FieldComponent",
    search_input: "Componeer::SearchInputComponent",
    toggle_switch: "Componeer::ToggleSwitchComponent",
    segmented: "Componeer::SegmentedComponent",
    card: "Componeer::CardComponent",
    env_banner: "Componeer::EnvBannerComponent",
    nav_item: "Componeer::NavItemComponent",
    sidebar: "Componeer::SidebarComponent",
    app_shell: "Componeer::AppShellComponent",
    tabs: "Componeer::TabsComponent",
    tab_panel: "Componeer::TabPanelComponent",
    page_header: "Componeer::PageHeaderComponent",
    popover: "Componeer::PopoverComponent",
    multi_select: "Componeer::MultiSelectComponent",
    period_picker: "Componeer::PeriodPickerComponent",
    table: "Componeer::TableComponent",
    code_block: "Componeer::CodeBlockComponent",
    pagination: "Componeer::PaginationComponent",
    drawer: "Componeer::DrawerComponent",
    modal: "Componeer::ModalComponent",
    toast: "Componeer::ToastComponent",
    toasts: "Componeer::ToastsComponent"
  }.freeze

  BUILTINS.each { |name, component| register(name, component) }
end
