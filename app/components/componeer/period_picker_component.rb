module Componeer
  # A date range from presets or two date fields, submitted as from_name / to_name.
  class PeriodPickerComponent < Component
    Preset = Data.define(:label, :from, :to)

    def initialize(from_name: :from, to_name: :to, from: nil, to: nil, presets: [], title: "Período",
      any_label: "Qualquer data", label: "Período", **html)
      @from_name, @to_name, @title, @any_label, @label, @html = from_name, to_name, title, any_label, label, html
      @from, @to = from&.to_date, to&.to_date
      @presets = presets.map { |preset| Preset.new(label: preset[:label], from: preset[:from]&.to_date, to: preset[:to]&.to_date) }
    end

    def summary
      preset = @presets.find { |p| current?(p) }
      return preset.label if preset
      return "#{l(@from)} – #{l(@to)}" if @from && @to
      return "Desde #{l(@from)}" if @from
      return "Até #{l(@to)}" if @to

      @any_label
    end

    def current?(preset)
      preset.from == @from && preset.to == @to
    end

    private
      def l(date)
        date.strftime("%d/%m/%Y")
      end
  end
end
