class EmailsController < ApplicationController
  def index
    @emails = User.distinct.pluck(:email)
  end
end
