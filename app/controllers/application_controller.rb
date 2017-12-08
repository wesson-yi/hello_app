class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "hello,mundo!"
  end

  def goodbye
    render html: "good bye!"
  end

  def send_offer
    AbandonedTrialQuery.new.find_each do |account|
      account.send_off_for_support
    end

    account = Account.where("created_at < ?", 1.month.ago)
    abandoned_trials = AbandonedTrialQuery.new(account)
  end
end

