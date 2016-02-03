class Job < ActiveRecord::Base
validates :address, presence: true
geocoded_by :address   # can also be an IP address
after_validation :geocode          # auto-fetch coordinates
mount_uploaders :images, ImageUploader
	TYPES = %w( WorkingHoliday Internship Volunteering Bootcamp )
	belongs_to :host
  has_many :bookings
  searchkick autocomplete: ['country']
  self.per_page = 10
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
