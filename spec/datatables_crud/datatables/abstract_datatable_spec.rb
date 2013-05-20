require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe DatatablesCRUD::AbstractDatatable do
  after do
    DatatablesCRUD::AbstractDatatable.columns []
  end

  describe "self.columns" do
    before { @result = DatatablesCRUD::AbstractDatatable.columns %w(column_1 column_2) }

    it "should return columns that have been set" do
      @result.should == %w(column_1 column_2)
    end

    it "should return previously set columns if no columns are passed" do
      DatatablesCRUD::AbstractDatatable.columns.should == %w(column_1 column_2)
    end

    it "should overwrite columns that were set before" do
      DatatablesCRUD::AbstractDatatable.columns(%w(column_3)).should == %w(column_3)
      DatatablesCRUD::AbstractDatatable.columns.should == %w(column_3)
    end

    it "should change column names to string" do
      DatatablesCRUD::AbstractDatatable.columns([:column_1, 3, 2.1]).should == %w(column_1 3 2.1)
    end
  end

  describe "self.column" do
    it "should add a column to the columns list" do
      DatatablesCRUD::AbstractDatatable.column("column_1")
      DatatablesCRUD::AbstractDatatable.columns.should == %w(column_1)
    end

    it "should change column name to string" do
      DatatablesCRUD::AbstractDatatable.column(:column_1)
      DatatablesCRUD::AbstractDatatable.column(3)
      DatatablesCRUD::AbstractDatatable.column(2.1)
      DatatablesCRUD::AbstractDatatable.columns.should == %w(column_1 3 2.1)
    end
  end

  describe "initialize" do

  end

  describe "as_json" do

  end

  describe "columns" do

  end

  describe "page" do

  end

  describe "per_page" do

  end

  describe "sort_columns" do

  end

  describe "sort_options" do

  end

  describe "data" do

  end
end
