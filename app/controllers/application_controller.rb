class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!, :unless =>  Proc.new {|a| a.request.format == :json}
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  def user_needed
    unless current_user
      render :json => {'error' => 'authentication error'}, :status => 401 
   
    end
  end
end
