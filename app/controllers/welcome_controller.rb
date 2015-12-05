#This is controller to handle home pages
class WelcomeController < ApplicationController
  skip_before_filter :authenticate
  def welcome
    puts "I am inside welcome action"
  end

  def home
    @username = "Mukesh"
  end

  def new_action
    puts "demo"
  end
end
