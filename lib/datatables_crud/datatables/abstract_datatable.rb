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
          :limit => params[:iDisplayLength] || 10,
          :offset => params[:iDisplayStart] || 0,
          :order => sort_options
      )
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: count,
        iTotalDisplayRecords: count,
        aaData: data
      }
    end

    private

      def columns
        self.class.columns
      end

      def page
        params[:iDisplayStart].to_i / per_page + 1
      end

      def per_page
        params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
      end

      def sort_columns
        columns
      end

      def sort_options
        {}.tap do |opts|
          columns.size.times.each do |i|
            iSortColSym = "iSortCol_#{i}".to_sym
            break unless params[iSortColSym]

            sSortDirSym = "sSortDir_#{i}".to_sym

            sort_col = sort_columns[(params[iSortColSym].to_i rescue 0)]
            opts[sort_col] = params[sSortDirSym]
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
