require "spec_helper"

describe DailiesController do
  describe "routing" do

    it "routes to #index" do
      get("/dailies").should route_to("dailies#index")
    end

    #it "routes to #new" do
    #  get("/dailies/new").should route_to("dailies#new")
    #end

    it "routes to #show" do
      get("/dailies/1").should route_to("dailies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dailies/1/edit").should route_to("dailies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dailies").should route_to("dailies#create")
    end

    it "routes to #update" do
      put("/dailies/1").should route_to("dailies#update", :id => "1")
    end

    #it "routes to #destroy" do
    #  delete("/dailies/1").should route_to("dailies#destroy", :id => "1")
    #end

  end
end
