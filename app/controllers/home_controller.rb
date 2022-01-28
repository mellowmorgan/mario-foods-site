class HomeController < ApplicationController
  include Devise::Controllers::Helpers
  skip_before_action :authenticate_user!, :only => :index
  def index
    render :index
  end
end