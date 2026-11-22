module Componeer
  BUILTINS = {
    icon: "Componeer::Icon::Component",
    button: "Componeer::Button::Component",
    icon_button: "Componeer::IconButton::Component",
    status_dot: "Componeer::StatusDot::Component",
    status_pill: "Componeer::StatusPill::Component",
    counter: "Componeer::Counter::Component",
    badge: "Componeer::Badge::Component",
    callout: "Componeer::Callout::Component",
    empty_state: "Componeer::EmptyState::Component",
    stack: "Componeer::Stack::Component",
    cluster: "Componeer::Cluster::Component",
    field: "Componeer::Field::Component",
    search_input: "Componeer::SearchInput::Component",
    toggle_switch: "Componeer::ToggleSwitch::Component",
    segmented: "Componeer::Segmented::Component",
    card: "Componeer::Card::Component",
    env_banner: "Componeer::EnvBanner::Component",
    nav_item: "Componeer::NavItem::Component",
    sidebar: "Componeer::Sidebar::Component",
    app_shell: "Componeer::AppShell::Component",
    tabs: "Componeer::Tabs::Component",
    tab_panel: "Componeer::TabPanel::Component",
    page_header: "Componeer::PageHeader::Component",
    popover: "Componeer::Popover::Component",
    multi_select: "Componeer::MultiSelect::Component",
    period_picker: "Componeer::PeriodPicker::Component",
    table: "Componeer::Table::Component",
    code_block: "Componeer::CodeBlock::Component",
    pagination: "Componeer::Pagination::Component",
    drawer: "Componeer::Drawer::Component",
    modal: "Componeer::Modal::Component",
    toast: "Componeer::Toast::Component",
    toasts: "Componeer::Toasts::Component"
  }.freeze

  BUILTINS.each { |name, component| register(name, component) }
end
