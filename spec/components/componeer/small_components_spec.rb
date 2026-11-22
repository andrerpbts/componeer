require "rails_helper"

RSpec.describe "Small components", type: :component do
  describe Componeer::IconComponent do
    context "when decorative" do
      before { render_inline(described_class.new("search", size: 20)) }

      it { expect(page).to have_css("svg.tr-icon[width='20'][aria-hidden=true]") }
    end

    context "when filled" do
      before { render_inline(described_class.new("star", variant: :filled)) }

      it { expect(page).to have_css("svg.tr-icon[fill=currentColor]:not([stroke])") }
    end

    context "with a label" do
      before { render_inline(described_class.new("alert-triangle", label: "Atenção")) }

      it { expect(page).to have_css("svg[role=img][aria-label='Atenção']") }
    end
  end

  describe Componeer::StatusDotComponent do
    before { render_inline(described_class.new(color: "#0d9488", style: "margin-right: 7px")) }

    it { expect(page).to have_css(".tr-dot[style='background: #0d9488; margin-right: 7px']", visible: :all) }
  end

  describe Componeer::StatusPillComponent do
    before { render_inline(described_class.new("Cancelada", status: :bad)) }

    it { expect(page).to have_css(".tr-pill.tr-pill--bad .tr-dot.tr-dot--bad") }
  end

  describe Componeer::CalloutComponent do
    before { render_inline(described_class.new("Vence em 30 dias.", variant: :warning)) }

    it { expect(page).to have_css(".tr-help[role=alert]", text: "Vence em 30 dias.") }
  end

  describe Componeer::ToggleSwitchComponent do
    before { render_inline(described_class.new("auto_sync", label: "Sincronizar", checked: true)) }

    it { expect(page).to have_css("label.tr-switch-field input[type=checkbox][role=switch][checked]", visible: :all) }
  end

  describe Componeer::SegmentedComponent do
    before do
      render_inline(described_class.new(label: "Visão")) do |views|
        views.with_item("Dia", href: "/dia", pressed: true)
        views.with_item("Mês")
      end
    end

    it { expect(page).to have_css(".tr-segmented[role=group] a[aria-current=page]", text: "Dia") }
    it { expect(page).to have_css(".tr-segmented button[aria-pressed=false]", text: "Mês") }
  end

  describe Componeer::AppShellComponent do
    before do
      with_request_url("/componeer/button") do
        render_inline(described_class.new) do |shell|
          shell.with_banner("DEVELOPMENT DATA")
          shell.with_sidebar(brand: "Workflows") do |sidebar|
            sidebar.with_item("Agenda", href: "/componeer/button", icon: "calendar")
            sidebar.with_heading("Negócios")
            sidebar.with_item("Quests", href: "/componeer/card")
          end
          "Página"
        end
      end
    end

    it { expect(page).to have_css(".tr-env", text: "DEVELOPMENT DATA") }
    it { expect(page).to have_css(".tr-nav-item[aria-current=page]", text: "Agenda") }
    it { expect(page).to have_css(".tr-sidebar__heading", text: "Negócios") }
    it { expect(page).to have_css("main.tr-main", text: "Página") }
  end

  describe Componeer::DrawerComponent do
    before do
      render_inline(described_class.new(title: "Nota 1235", close_href: "/notas")) do |drawer|
        drawer.with_section("Tomador") { "Empresa Exemplo" }
      end
    end

    it { expect(page).to have_css("aside.tr-drawer[aria-label='Nota 1235'] h2", text: "Nota 1235") }
    it { expect(page).to have_css("a[href='/notas'][aria-label=Fechar]") }
    it { expect(page).to have_css(".tr-drawer__section h2", text: "Tomador") }
  end

  describe Componeer::ToastsComponent do
    before { render_inline(described_class.new(flash: { "notice" => "Salvo.", "alert" => "Falhou." })) }

    it { expect(page).to have_css(".tr-toast[role=status]", text: "Salvo.") }
    it { expect(page).to have_css(".tr-toast.tr-toast--error[role=alert]", text: "Falhou.") }
  end
end
