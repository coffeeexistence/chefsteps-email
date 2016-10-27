class EmailGenerator

  @top_level_domains = ['com', 'co', 'io', 'biz', 'org']

  def self.random_string(length)
    [*('a'..'z'),*('0'..'9')].shuffle[0, length].join
  end

  def self.generate_random_email
    address_length = 3 + rand(10)
    domain_length = 1 + rand(5)
    domain = self.random_string(domain_length) + '.' + @top_level_domains.sample
    address = self.random_string(address_length)
    "#{address}@#{domain}"
  end

  def self.generate_random_emails(count)
    emails = []
    iterations = 0
    complete = false
    
    until complete do
     emails << self.generate_random_email
     if (iterations > count) && ((iterations % 10) == 0)
       complete = (emails.uniq.count > count)
     end
     iterations += 1
    end
    
    return emails.first(count)
  end

  def self.generate_random_emails_with_duplicates(amount_of_emails, duplicate_ratio)
    unique_emails_needed = (amount_of_emails * duplicate_ratio).to_i
    unique_emails = self.generate_random_emails(unique_emails_needed)
    duplicate_emails_needed = (amount_of_emails - unique_emails_needed)
    
    emails_with_random_duplications = unique_emails
    duplicate_emails_needed.times do
      random_index = rand(emails_with_random_duplications.length)
      emails_with_random_duplications.insert(random_index, unique_emails.sample)
    end
    emails_with_random_duplications
  end
  
  def self.get(amount_of_emails=50, duplicate_ratio=0.5)
    self.generate_random_emails_with_duplicates(amount_of_emails, duplicate_ratio)
  end

end