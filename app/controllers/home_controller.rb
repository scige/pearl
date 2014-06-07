class HomeController < ApplicationController
  def index
    @groups = Group.roots
  end
end
