class EmailsController < ApplicationController
  def index
    before = Time.now
    @emails = User.order(:id).distinct.pluck(:email)
    response_time_seconds = (Time.now - before)
    @comparisions = Comparisons.new(amount: @emails.count, time_taken: response_time_seconds)
    @response_time_ms = (response_time_seconds * 1000).to_i
  end
  
  def api_index
    render json: User.all.pluck(:email)
  end
  
  def is_original_order
    emails = params[:emails]
    render json: User.correct_order_of_emails?(emails)
  end
  
end
