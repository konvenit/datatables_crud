module DatatablesCRUD
  class AbstractDatatable
    delegate :params, :link_to, :object_action_links, :to => :@view

    def self.columns(cols = nil)
      @columns = cols.map(&:to_s) unless cols.nil?
      @columns
    end

    def self.column(column)
      @columns ||= []
      @columns << column.to_s unless @columns.include?(column.to_s)
    end

    def initialize(view, options = nil)
      @view = view

      @options = (options || {}).merge(
          :limit => params[:length] || 10,
          :offset => params[:start] || 0,
          :order => sort_options
      )
    end

    def as_json(options = {})
      {
        draw: params[:draw].to_i,
        recordsTotal: total_count,
        recordsFiltered: count,
        data: data
      }
    end

    private

      def columns
        self.class.columns
      end

      def page
        params[:start].to_i / per_page + 1
      end

      def per_page
        params[:length].to_i > 0 ? params[:length].to_i : 10
      end

      def sort_columns
        columns
      end

      def sort_options
        {}.tap do |opts|
          params[:order].each do |k, order|
            sort_col = sort_columns[order[:column].to_i]
            opts[sort_col] = order[:dir]
          end
        end
      end

      def data
        records.map do |record|
          [].tap do |result_row|
            columns.each do |column|
              result_row << column_data(record, column, column_value(record, column))
            end
          end
        end
      end

      # records has to be defined in the subclass
      # count has to be defined in the subclass
      # column_value has to be defined in the subclass
      # sort_options has to be redefined in the subclass for specific transformation of sorting options
  end
end
