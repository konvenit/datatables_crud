class PeopleDatatable < DatatablesCRUD::ActiveRecordDatatable
  column :first_name
  column :last_name
  column :date_of_birth
  column :actions

  search_column :first_name
  search_column :last_name
end
