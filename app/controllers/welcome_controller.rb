class WelcomeController < ApplicationController
  skip_before_filter :authenticate
  def welcome
    puts "I am inside welcome action"
  end

  def home
    @username = "Mukesh"
  end
end
