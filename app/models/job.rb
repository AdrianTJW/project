class Job < ActiveRecord::Base
geocoded_by :address   # can also be an IP address
after_validation :geocode          # auto-fetch coordinates
	TYPES = %w( WorkingHoliday Internship Volunteering Bootcamp )
	belongs_to :user
	belongs_to :host
  searchkick autocomplete: ['country']
end

class WorkingHoliday < Job
  def set_type
    self.type = 'WorkingHoliday'
  end
end

class Internship < Job
  def set_type
    self.type = 'Internship'
  end
end

class Volunteering < Job
  def set_type
    self.type = 'Volunteering'
  end
end

class Bootcamp < Job
  def set_type
    self.type = 'Bootcamp'
  end
end