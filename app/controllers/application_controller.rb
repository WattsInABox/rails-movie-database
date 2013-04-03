class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def current_object_params
    @current_object_params ||= params[current_object_name]
  end
end
