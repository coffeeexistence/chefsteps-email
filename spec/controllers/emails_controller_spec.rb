require 'rails_helper'
require 'spec_helper'

RSpec.describe EmailsController do
  
  describe "GET index" do
    
    before(:all) do
      DatabaseCleaner.start
      User.generate_all_with_random_emails
    end
    
    after(:all) do
      DatabaseCleaner.clean
    end
    
    it "assigns @emails" do
      get :index
      expect(assigns(:emails)).to be_an(Array)
    end
    
    it "has exactly 50,000 unique emails" do
      get :index
      expected_unique_emails_count = 50000
      actual_unique_emails_count = assigns(:emails).uniq.count
      expect(actual_unique_emails_count).to eq(expected_unique_emails_count)
    end
    
    it "responds within 300ms" do
      before = Time.now
      get :index
      response_time_ms = (Time.now - before) * 1000
      puts "Response Time: #{response_time_ms}"
      expect(response_time_ms < 300).to be true
    end
    
  end
  
end