class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate

  protected

  def authenticate
    puts "Authenticate filter called"
    params[:username] = "Mukesh"
    if params[:username] == 'Mukesh'
      true
    else
      render :inline => "Not a valid user"
    end
  end

  def another_method
    puts "Protected method"
  end

  private
  def private_method
    puts "Private method"
  end
  def private_method2
    puts "Private method2"
  end
end
