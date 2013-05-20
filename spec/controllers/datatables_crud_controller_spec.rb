require File.expand_path(File.dirname(__FILE__)) + '/../spec_helper'

# testing of the DatatablesCRUDController using PeopleController
describe PeopleController do
  before :each do
  end

  describe "ping tests" do
    xit "should succeed on index" do
      get :index
      response.should be_success
    end
  end

  describe "functional tests" do

  end
end
