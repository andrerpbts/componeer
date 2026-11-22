# AGENTS.md

Instructions for AI coding agents (Claude Code, Codex, Cursor…) working in this repository.
Read this file completely before making any change.

## 1. What this is

**Componeer** is a private Rails engine (gem) that renders the **Trail UI** design system with
[ViewComponent](https://viewcomponent.org). Every component is exposed as a view helper that takes a
block, so screens are written by nesting helpers:

```erb
<%= card(title: "Quests ativas", flush: true) do %>
  <%= table(rows: @quests) do |t| %>
    <% t.column("Quest") { |quest| quest.title } %>
  <% end %>
<% end %>
```

It is consumed by the owner's own apps (first: Workflows). It is **private**: never publish it to
RubyGems.org (the gemspec blocks pushes) and never make the repository public.

## 2. The design system is the source of truth

**Trail UI design system artifact: https://claude.ai/artifact/1ZRWxLZqGKBZe9boXjcu7J**

- Read its `project/README.md` (brand book: tone, colours, type, density, layout rules) and the
  relevant `project/components/<Name>/README.md` before building or changing a component. With the
  Artifact tool: `read` that URL with `path` set to the file.
- Look and tokens change **there first**, then here. `app/assets/stylesheets/componeer/tokens.css` and
  `components.css` are copies of the artifact's `project/tokens.css` and
  `project/components/bundle.css`:
  - `components.css` must stay byte-identical to the artifact's `bundle.css`.
  - `tokens.css` is the artifact's `tokens.css` **without** the type-style classes at its end
    (`.title`, `.section`, `.body`…): global class names like those would collide with host apps.
- A component that does not exist in Trail UI yet (Card was one) is added to the artifact as an
  "Intentional addition" with a preview and README, in the same change.
- Icons are the Tabler outline set, pinned to `@tabler/icons@3.19.0`, vendored in
  `vendor/tabler/outline` (MIT, see `vendor/tabler/LICENSE`). Never mix in another icon set.

## 3. Stack

| Concern    | Choice |
|------------|--------|
| Ruby       | 3.4 (`.tool-versions`, asdf) |
| Framework  | Rails engine (`isolate_namespace Componeer`), Rails ≥ 8.0, ViewComponent ~> 4.0 |
| JS         | Stimulus controllers in `app/javascript/componeer`, pinned for importmap hosts |
| CSS        | Plain CSS from Trail UI, classes prefixed `tr-` (no Tailwind, no build step) |
| Tests      | RSpec + ViewComponent test helpers + Capybara matchers; dummy app in `spec/dummy` |
| Lint       | RuboCop (rails-omakase + rubocop-rspec) |

Do not add runtime dependencies (Tailwind, Node build tooling, React…) without the owner's approval.

## 4. Layout of the code

- `lib/componeer.rb` – configuration, `Componeer.register`, requires.
- `lib/componeer/registry.rb`, `helpers.rb` – registering a component defines a helper on
  `Componeer::Helpers`, which the engine includes in every view. Names that would override an Action
  View helper (`select`, `label`, `search_field`…) are refused.
- `lib/componeer/builtins.rb` – the list of built-in helpers. Keep it in sync with the components.
- `lib/componeer/icons.rb` – icon lookup (configured `icon_paths` first, then Tabler).
- `app/components/componeer/*_component.rb` (+ `.html.erb` when the markup is more than a line or two)
  – all inherit `Componeer::Component` (`html_attributes`, `icon_svg`).
- `app/javascript/componeer` – `index.js` (`registerComponeer(application)`) and controllers named
  `componeer--<name>`.
- Documentation app (mounted at `/componeer`): `config/docs.yml` (pages), 
  `app/views/componeer/docs/examples/_<name>.html.erb` (live examples, shown with their source),
  `app/controllers/componeer/docs_controller.rb`, `app/models/componeer/doc_page.rb`.

## 5. Adding or changing a component

1. Check the Trail UI artifact; add or update the component there first if needed (section 2).
2. Write the component in `app/components/componeer/`, inheriting `Componeer::Component`. Accept
   `**html` and merge it with `html_attributes` so callers can add classes, data and aria.
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
- Spec style: `describe`/`context` carry the description; examples have **no description** and
  **one expectation each** (`it { expect(page).to have_css(...) }`), setup in `before`/`let`.
- Never put real names, emails, tax IDs or amounts anywhere in this repository.

## 7. Workflow

- Work on a branch, small focused commits, imperative messages. Do not push or open PRs unless the
  owner asks.
- Keep `README.md`, `CHANGELOG.md` and this file up to date when setup or conventions change.
