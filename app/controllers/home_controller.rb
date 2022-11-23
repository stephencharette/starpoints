class HomeController < ApplicationController
  def index
    @credit_cards = current_user.credit_cards.order(:created_at)
    @metrics = [['1-6', 1], ['7-13', 5], ['14-20', 6], ['21-27', 10], ['28-30', 12]]
  end
end
