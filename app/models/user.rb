class User < ActiveRecord::Base
  
  def self.generate_all_with_random_emails
    emails_needed = 100000
    duplicate_ratio = 0.5
    puts "Generating #{emails_needed} with a duplication ratio of #{duplicate_ratio}"
    generated_emails = EmailGenerator.get(emails_needed, duplicate_ratio)

    puts "Generated #{generated_emails.count} random emails!"

    puts "Persisting emails to db"

    generated_emails.map!{|email| [email]}

    User.transaction do
      User.import [:email], generated_emails, validate: false
    end

    puts "Emails persisted!"
  end
end
