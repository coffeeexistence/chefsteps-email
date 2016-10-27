require 'rails_helper'
require 'email_generator'

def correct_duplicate_ratio?(ratio)
  email_count = 200
  duplicate_ratio = ratio
  expected_duplicates = (email_count * (1 - duplicate_ratio)).to_i
  emails = EmailGenerator.get(email_count, duplicate_ratio)
  actual_duplicates = (emails.count - emails.uniq.count)
  expect(actual_duplicates).to equal(expected_duplicates)
end

RSpec.describe EmailGenerator, :type => :model do
  
  describe "Email Generation" do
    
    it "can generate a valid email" do
      email = EmailGenerator.generate_random_email
      valid_email = email.match(/.+@.+\..+/)
      expect(valid_email).to be_truthy
    end
    
    it "generates the correct amount of emails" do
       email_count = 200
       actual_email_count = EmailGenerator.generate_random_emails(email_count).count
       expect(actual_email_count).to eq(email_count)
    end
    
  end
  
  describe "Unique Email Generation" do
    
    it "generates all unique emails" do
      email_count = 200
      emails = EmailGenerator.generate_random_emails(email_count)
      unique_email_count = emails.uniq.count
      expect(unique_email_count).to eq(email_count)
    end
    
  end
  
  describe "Duplicate emails" do
    
    it "works with a duplicate_ratio of 0.2" do
      expect( correct_duplicate_ratio?(0.2) ).to be true
    end
    
    it "works with a duplicate_ratio of 0.5" do
      expect( correct_duplicate_ratio?(0.5) ).to be true
    end
    
    it "works with a duplicate_ratio of 0.8" do
      expect( correct_duplicate_ratio?(0.5) ).to be true
    end
    
  end
  
end