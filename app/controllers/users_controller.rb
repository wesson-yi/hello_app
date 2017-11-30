class UsersController < ApplicationController

  def show
  end

  def write_off
    redirect_url = info_user_url
    redirect_to "#{Settings.weixin_oauth_url}?appid=#{Rails.application.secrets.base_weixin["app_id"]}&redirect_uri=#{redirect_url}&response_type=code&scope=snsapi_userinfo&state=#{22}#wechat_redirect"
  end

  def info
    binding.pry

  end
end
