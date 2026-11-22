# Changelog

## 0.1.0 (unreleased)

- First version: Trail UI stylesheets, the Tabler outline icon set, 30 components exposed as nestable
  view helpers, Stimulus controllers for popover, multi-select, period picker, row links and
  dismissable overlays, and the documentation app mounted at `/componeer`.
- The whole Tabler set: filled icons (`icon "star", variant: :filled`) next to outline, and a
  searchable icon gallery in the docs.
- Example screens in the docs: list with detail, dashboard, settings form, list with confirmation,
  grouped on one page.
- `code_block`: syntax highlighting on the server with Rouge (200+ languages) and a copy button;
  the docs use it for every example, signature and snippet.
- `pagination`: page links for long lists; the icon gallery is paged by letter and by 240 icons.
- Docs use the full width; sidebar groups are divided by a line.
- Componeer logo; Theming guide with live themes and every Trail UI variable.
- Tabs and segmented controls switch on the page when they have no href (Stimulus);
  `tab_panel` shows the content of the selected tab; arrow keys move between tabs.
- `empty_state` redone: icon, title, description, actions, small and bordered variants;
  tables take `t.empty { … }` for a full empty state.
- Docs: more table and empty state examples; helper signatures shown one argument per line.
- Tables: collapsible groups (`collapsible: true`, `collapsed: [...]`); empty tables keep their header.
- Fields: read-only and disabled styles; search inputs are white.
