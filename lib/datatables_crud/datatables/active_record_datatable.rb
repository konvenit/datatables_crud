module DatatablesCRUD
  class ActiveRecordDatatable < AbstractDatatable
    def self.search_columns(columns = nil)
      @search_columns = columns.map(&:to_s) unless columns.nil?
      @search_columns
    end

    def self.search_column(column)
      @search_columns ||= []
      @search_columns << column.to_s unless @search_columns.include?(column.to_s)
    end

    def initialize(view, options = nil, clazz = nil)
      super(view, options)
      @clazz = clazz || self.class.name.gsub(/.*\:\:/, '').gsub("Datatable", "").singularize.constantize
    end

    private

      def prepared_clazz
        @options[:conditions] ? @clazz.where(@options[:conditions]) : @clazz
      end

      def search_columns
        self.class.search_columns
      end

      def sort_options
        super.map { |k, v| "#{k} #{v == 'desc' ? 'desc' : 'asc'}" }.join(", ")
      end

      def count_options
        (@options || {}).reject { |k, v| %w(limit offset).include? k.to_s }
      end

      def count
        if params[:search].try(:[], :value).present? and search_columns.present?
          @count ||= begin
            c = prepared_clazz.where(search_columns.map { |v| "#{v} like :search" }.join(' OR '), search: "%#{params[:search][:value]}%")
            c = c.where(count_options[:conditions]) if count_options[:conditions].present?
            c.count
          end
        else
          total_count
        end
      end

      def total_count
        @total_count ||= count_options[:conditions].present? ? prepared_clazz.where(count_options[:conditions]).count : prepared_clazz.count
      end

      def apply_options
        return unless @records
        @records = @records.limit(@options[:limit])   if @options.try(:[], :limit)
        @records = @records.offset(@options[:offset]) if @options.try(:[], :offset)
        @records = @records.order(@options[:order])   if @options.try(:[], :order)
        @records
      end

      def records
        if params[:search].try(:[], :value).present? and search_columns.present?
          @records ||= prepared_clazz.where(search_columns.map { |v| "#{v} like :search" }.join(' OR '), search: "%#{params[:search][:value]}%")
        else
          @records ||= prepared_clazz
        end

        apply_options
      end

      def column_value(object, column)
        if column == 'actions'
          object_action_links(object)
        else
          object.send(column) rescue nil
        end
      end

      def column_data(object, column, value)
        if value.is_a?(Time) or value.is_a?(Date)
          I18n.l value
        elsif !!value == value
          "<input type=\"checkbox\" #{'checked' if value} onclick=\"checked = !checked\"/>".html_safe
        else
          value
        end
      end

      # column_data can be re-defined in the subclass for custom results
  end
end
