class HomeController < ApplicationController
  include Devise::Controllers::Helpers
  def index
    render :index
  end
end