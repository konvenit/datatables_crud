require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe DatatablesCRUD::ActiveRecordDatatable do
  after do
    DatatablesCRUD::ActiveRecordDatatable.search_columns []
  end

  describe "self.search_columns" do
    before { @result = DatatablesCRUD::ActiveRecordDatatable.search_columns %w(column_1 column_2) }

    it "should return columns that have been set" do
      @result.should == %w(column_1 column_2)
    end

    it "should return previously set search columns if no columns are passed" do
      DatatablesCRUD::ActiveRecordDatatable.search_columns.should == %w(column_1 column_2)
    end

    it "should overwrite columns that were set before" do
      DatatablesCRUD::ActiveRecordDatatable.search_columns(%w(column_3)).should == %w(column_3)
      DatatablesCRUD::ActiveRecordDatatable.search_columns.should == %w(column_3)
    end

    it "should change column names to string" do
      DatatablesCRUD::ActiveRecordDatatable.search_columns([:column_1, 3, 2.1]).should == %w(column_1 3 2.1)
    end
  end

  describe "self.search_column" do
    it "should add a column to the search columns list" do
      DatatablesCRUD::ActiveRecordDatatable.search_column("column_1")
      DatatablesCRUD::ActiveRecordDatatable.search_columns.should == %w(column_1)
    end

    it "should change column name to string" do
      DatatablesCRUD::ActiveRecordDatatable.search_column(:column_1)
      DatatablesCRUD::ActiveRecordDatatable.search_column(3)
      DatatablesCRUD::ActiveRecordDatatable.search_column(2.1)
      DatatablesCRUD::ActiveRecordDatatable.search_columns.should == %w(column_1 3 2.1)
    end
  end

  describe "initialize" do

  end

  describe "search_columns" do

  end

  describe "sort_options" do

  end

  describe "count" do

  end

  describe "records" do

  end

  describe "column_value" do

  end

  describe "column_data" do

  end
end
