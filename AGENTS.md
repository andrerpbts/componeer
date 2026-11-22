# AGENTS.md

Instructions for AI coding agents (Claude Code, Codex, Cursor…) working in this repository.
Read this file completely before making any change.

## 1. What this is

**Componeer** is a Rails engine (gem) that renders the **Trail UI** design system with
[ViewComponent](https://viewcomponent.org). Every component is exposed as a view helper that takes a
block, so screens are written by nesting helpers:

```erb
<%= card(title: "Quests ativas", flush: true) do %>
  <%= table(rows: @quests) do |t| %>
    <% t.column("Quest") { |quest| quest.title } %>
  <% end %>
<% end %>
```

It is used by the owner's own apps (first: Workflows). The repository is **public**: never commit
personal data, real customer data, credentials, local paths or anything from the owner's private
projects. Examples use obviously fake data. It is not published to RubyGems.org yet (the gemspec
blocks pushes); install it from git.

## 2. The design system is the source of truth

**Trail UI design system artifact: https://claude.ai/artifact/1ZRWxLZqGKBZe9boXjcu7J**

- Read its `project/README.md` (brand book: tone, colours, type, density, layout rules) and the
  relevant `project/components/<Name>/README.md` before building or changing a component. With the
  Artifact tool: `read` that URL with `path` set to the file. Anyone can view it; only the owner
  edits it.
- Look and tokens change **there first**, then here. `app/assets/stylesheets/componeer/tokens.css` and
  `components.css` are copies of the artifact's `project/tokens.css` and
  `project/components/bundle.css`:
  - `components.css` must stay byte-identical to the artifact's `bundle.css`.
  - `tokens.css` is the artifact's `tokens.css` **without** the type-style classes at its end
    (`.title`, `.section`, `.body`…): global class names like those would collide with host apps.
  - `config/tokens.json` is a copy of the artifact's `project/tokens.json`; the Theming docs page
    reads the usage notes from it.
- A component that does not exist in Trail UI yet (Card was one) is added to the artifact as an
  "Intentional addition" with a preview and README, in the same change.
- Icons are the whole Tabler set (outline and filled), pinned to `@tabler/icons@3.19.0`, vendored in
  `vendor/tabler/outline` and `vendor/tabler/filled` (MIT, see `vendor/tabler/LICENSE`). Never mix in
  another icon set.

## 3. Stack

| Concern    | Choice |
|------------|--------|
| Ruby       | 3.4 (`.tool-versions`, asdf) |
| Framework  | Rails engine (`isolate_namespace Componeer`), Rails ≥ 8.0, ViewComponent ~> 4.0 |
| JS         | Stimulus controllers in `app/javascript/componeer`, pinned for importmap hosts |
| CSS        | Plain CSS from Trail UI, classes prefixed `tr-` (no Tailwind, no build step) |
| Tests      | RSpec + ViewComponent test helpers + Capybara matchers; dummy app in `spec/dummy` |
| Lint       | RuboCop (rails-omakase + rubocop-rspec) |

Runtime dependencies: Rails, ViewComponent and Rouge (syntax highlighting for `code_block`). Do not
add others (Tailwind, Node build tooling, React…) without the owner's approval.

## 4. Layout of the code

- `lib/componeer.rb` – configuration, `Componeer.register`, requires.
- `lib/componeer/registry.rb`, `helpers.rb` – registering a component defines a helper on
  `Componeer::Helpers`, which the engine includes in every view. Names that would override an Action
  View helper (`select`, `label`, `search_field`…) are refused.
- `lib/componeer/builtins.rb` – the list of built-in helpers. Keep it in sync with the components.
- `lib/componeer/icons.rb` – icon lookup (configured `icon_paths` first, then Tabler).
- `app/components/componeer/<name>/` – one folder per component:
  - `component.rb` defines `Componeer::<Name>::Component < Componeer::BaseComponent` (data and
    logic only: arguments, option checks, attribute hashes, small queries);
  - `component.html.erb` holds **all** its markup;
  - sub-components that render a slot (`tabs/tab.rb`, `segmented/item.rb`, `drawer/section.rb`,
    `sidebar/heading.rb`, `pagination/step.rb`) live in the same folder, each with its template.
- `app/components/componeer/base_component.rb` – `html_attributes` (merges caller classes, styles,
  data, aria), `icon_svg`, `option!` (validates enum-like options).
- `app/javascript/componeer` – `index.js` (`registerComponeer(application)`) and one Stimulus
  controller per behaviour, named `componeer--<name>` (`controllers/<name>_controller.js`). JS stays
  out of `app/components`: serving it from there would put that folder in the asset load path, and
  `assets:precompile` would then copy every `.rb` and `.erb` into the host app's `public/assets`.
- Documentation app (mounted at `/componeer`): `config/docs.yml` (pages), 
  `app/views/componeer/docs/examples/_<name>.html.erb` (live examples, shown with their source),
  `app/controllers/componeer/docs_controller.rb`, `app/models/componeer/doc_page.rb`.
- Example screens: `app/views/componeer/screens/_<name>.html.erb`, whole pages built only from
  helpers, listed in `config/docs.yml` (group "Screens", `screen:` key) and served at
  `/componeer/screens/<name>`. When a component changes, check the screens still read well.

## 5. Adding or changing a component

1. Check the Trail UI artifact; add or update the component there first if needed (section 2).
2. Create `app/components/componeer/<name>/component.rb` and `component.html.erb` (section 4).
   Accept `**html` and merge it with `html_attributes` so callers can add classes, data and aria.
3. Register its helper in `lib/componeer/builtins.rb`.
4. Document it: an entry in `config/docs.yml` (lead, helper signature, options/slots) and at least
   one example partial. Examples use obviously fake data (Empresa Exemplo, Fictícia Serviços ME).
5. Spec it in `spec/components/componeer/` (and the docs request spec covers the page).
6. Run `bin/rubocop` and `bundle exec rspec`; both must be green.

## 6. Conventions

- Code, comments, docs and commit messages in English. Example UI copy is pt-BR, sentence case,
  verb-first buttons, as Trail UI says.
- Comments only for the *why* the code can't say. No commented-out code.
- Accessibility is part of the component: real `<button>`/`<a>`, `aria-label` on icon-only
  controls, `aria-current`/`aria-selected`/`aria-pressed` for state, decorative icons hidden.
- Markup belongs in templates. A component's Ruby class never builds HTML (`tag.div`, `content_tag`…);
  it exposes data and attribute hashes the template uses. Same for helpers: markup goes in partials.
- In templates, refer to other components by their full name (`Componeer::Icon::Component`):
  templates are compiled outside the `module Componeer` nesting, so short names do not resolve.
- Lines are at most 100 characters (RuboCop `Layout/LineLength`). Break long calls by argument,
  prefer one assignment per line over `@a, @b = a, b`.
- Private methods sit at the same indentation as `private` (RuboCop
  `Layout/IndentationConsistency: normal`), not indented under it.
- Spec style: `describe`/`context` carry the description; examples have **no description** and
  **one expectation each** (`it { expect(page).to have_css(...) }`), setup in `before`/`let`. When
  a one-liner would pass 100 characters, use `it do … end` with the same single expectation.
- Specs mirror the component folders: `spec/components/componeer/<name>/component_spec.rb`.
- Never put real names, emails, tax IDs or amounts anywhere in this repository.

## 7. Workflow

- Work on a branch, small focused commits, imperative messages. Do not push or open PRs unless the
  owner asks.
- Keep `README.md`, `CHANGELOG.md` and this file up to date when setup or conventions change.
