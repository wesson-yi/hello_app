class StaticPagesController < ApplicationController
  def home

  end

  def help
  end

  def about
  end
  
  def contact
  end

  def faq
    @hidden = true
  end
end
