class MemberLocation < ActiveRecord::Base
  belongs_to :member
  has_one :membership_detail, through: :member
  
  geocoded_by :address
  
  after_validation :geocode, if: ->(obj){ obj.longitude.blank? or ( obj.address.present? and obj.address_changed? ) }
  
  def self.batch_geocode
    where("latitude is null").find_in_batches(batch_size: 100) do |group|
     sleep(10)
     group.each { |x| x.save! }
   end
  end
  
  def self.location_search(location, radius, show_all)
    if show_all.present?
      near(location, radius || 5)
    else
      near(location, radius || 5).joins(:membership_detail).where(membership_details: { in_practice: 'Y' })
    end
  end    
end
