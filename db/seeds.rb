# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

top_level_domains = [:com, :co, :io, :biz, :org]

def random_string(length)
  [*('a'..'z'),*('0'..'9')].shuffle[0, length-1].join
end

def generate_random_email
  address_length = 3 + rand(10)
  domain_length = rand(5)
  domain = random_string(domain_length) + '.' + top_level_domains.sample
  address = random_string(address_length)
  "#{address}@#{domain}"
end

byebug
