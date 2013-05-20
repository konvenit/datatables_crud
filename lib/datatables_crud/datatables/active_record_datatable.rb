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
      @clazz = clazz || self.class.name.gsub("Datatable", "").singularize.constantize
    end

    private

      def search_columns
        self.class.search_columns
      end

      def sort_options
        super.map { |k, v| "#{k} #{v == 'desc' ? 'desc' : 'asc'}" }.join(", ")
      end

      def count
        if params[:sSearch].present? and search_columns.present?
          @count ||= @clazz.where(@options[:conditions] || {}).where(search_columns.map { |v| "#{v} like :search" }.join(' OR '), search: "%#{params[:sSearch]}%").count
        else
          @count ||= @clazz.where(@options[:conditions] || {}).count
        end
      end

      def records
        if params[:sSearch].present? and search_columns.present?
          @records ||= @clazz.where(search_columns.map { |v| "#{v} like :search" }.join(' OR '), search: "%#{params[:sSearch]}%").all(@options)
        else
          @records ||= @clazz.all(@options)
        end
      end

      def column_value(object, column)
        if column == 'actions'
          object_action_links(object)
        else
          object.send(column) rescue nil
        end
      end

      def column_data(object, column, value)
        value
      end

      # column_data can be re-defined in the subclass for custom results
  end
end
