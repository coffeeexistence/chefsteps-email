class Comparisons
  attr_accessor :amount, :time_taken

  def initialize(amount:, time_taken:)
    @amount = amount
    @time_taken = time_taken
  end
  
  def per_second
    (self.amount / time_taken).to_i
  end
  
  def per_minute
    self.per_second * 60
  end
  
  def per_hour
    (self.per_second * 60) * 60
  end
  
  def per_day
    self.per_hour * 24
  end
  
  def per_month
    self.per_day * 30
  end
  
  def per_year
    self.per_day * 365
  end
  
  def per_million_years
    self.per_year * 1000000
  end
  
  def per_billion_years
    self.per_million_years * 1000
  end
  
  def until_sun_engulfs_earth
    self.per_billion_years * 5.4
  end
  
  def engulfs_needed_to_generate_atoms_in_carat
    1 / ( self.until_sun_engulfs_earth / self.atoms_in_one_carat_diamond )
  end
  
  def atoms_in_one_carat_diamond
    10e23
  end

end