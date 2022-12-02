class HomeController < ApplicationController
  include TimeHelper

  before_action :authenticate_user!

  def index
    @current_datetime = params[:starting_date].present? ? Date.parse(params[:starting_date]) : DateTime.now
    @date_range = date_range(DateTime.now.to_date.beginning_of_week(:sunday), DateTime.now.to_date.end_of_week(:sunday))
    @credit_cards = current_user.credit_cards.order(:created_at)

    @metrics = nil
    @timeframe = case params[:timeframe]
                 when 'week'
                   @current_datetime.to_date.beginning_of_week(:sunday)..@current_datetime.to_date.end_of_week(:sunday)
                 when 'year'
                   @current_datetime.beginning_of_year..@current_datetime
                 else
                   @current_datetime.at_beginning_of_month..@current_datetime.end_of_month
                 end

    days = %w[Sun Mon Tue Wed Thu Fri Sat]
    months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
    transactions = current_user.transactions.where(transaction_date: @timeframe)

    unless transactions.empty?
      transactions_grouped = case params[:timeframe]
                             when 'week'
                               transactions.group_by_day(:transaction_date,
                                                         default_value: 0,
                                                         range: @timeframe)

                             when 'year'
                               transactions.group_by_month(:transaction_date,
                                                           default_value: 0,
                                                           range: @timeframe)
                             else
                               transactions.group_by_week(:transaction_date,
                                                          default_value: 0,
                                                          range: @timeframe)

                             end

      @metrics = transactions_grouped.sum(:amount).to_a.each_with_index
                                     .map do |u, index|
        [
          if params[:timeframe] == 'week'
            days[index].to_s
          elsif params[:timeframe] == 'year'
            months[index].to_s
          else
            "#{index.zero? ? 1 : index * 7}-#{index == 4 ? @current_datetime.end_of_month.day : ((index + 1) * 7 - 1)}"
          end, u.second
        ]
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: @metrics }
    end
  end
end
