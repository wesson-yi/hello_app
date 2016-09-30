class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def hello
    render text: "hello,mundo!"
  end
  
  def goodbye
    render text: "good bye!"
  end
end

