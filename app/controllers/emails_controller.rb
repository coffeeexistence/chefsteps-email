class EmailsController < ApplicationController
  def index
    before = Time.now
    @emails = User.distinct.pluck(:email)
    response_time_seconds = (Time.now - before)
    @comparisions = Comparisons.new(amount: @emails.count, time_taken: response_time_seconds)
    @response_time_ms = (response_time_seconds * 1000).to_i
  end
end
