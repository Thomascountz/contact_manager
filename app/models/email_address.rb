class EmailAddress < ActiveRecord::Base
  belongs_to :person
  
  validates :address, :contact_id, presence: true
end
