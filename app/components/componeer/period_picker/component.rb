module Componeer
  module PeriodPicker
    # A date range from presets or two date fields, submitted as from_name / to_name.
    class Component < BaseComponent
      Preset = Data.define(:label, :from, :to)

      def initialize(from_name: :from, to_name: :to, from: nil, to: nil, presets: [],
        title: "Período", any_label: "Qualquer data", label: "Período", **html)
        @from_name = from_name
        @to_name = to_name
        @from = from&.to_date
        @to = to&.to_date
        @presets = presets.map { |preset| build_preset(preset) }
        @title = title
        @any_label = any_label
        @label = label
        @html = html
      end

      def summary
        preset = @presets.find { |p| current?(p) }
        return preset.label if preset
        return "#{format_date(@from)} – #{format_date(@to)}" if @from && @to
        return "Desde #{format_date(@from)}" if @from
        return "Até #{format_date(@to)}" if @to

        @any_label
      end

      def current?(preset)
        preset.from == @from && preset.to == @to
      end

      private
      def build_preset(preset)
        Preset.new(label: preset[:label], from: preset[:from]&.to_date, to: preset[:to]&.to_date)
      end

      def format_date(date)
        date.strftime("%d/%m/%Y")
      end
    end
  end
end
