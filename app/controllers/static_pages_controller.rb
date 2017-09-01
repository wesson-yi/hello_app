class StaticPagesController < ApplicationController
  p '*' * 99
  p self.to_s
  def position
    @hidden = true
    p '*' * 99
    p self.to_s
  end

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
