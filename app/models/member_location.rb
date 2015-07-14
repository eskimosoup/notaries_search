class MemberLocation < ActiveRecord::Base
  belongs_to :member
  has_one :membership_detail, through: :member
  geocoded_by :address_fields
  after_validation :geocode, if: ->(obj) { obj.longitude.blank? or ( obj.address.present? and obj.address_changed? ) }

  def address_fields
    [address, postcode].compact.join(', ')
  end

  # x = MemberLocation.find_by(member_id: 1857)
  # latlng = Geocoder.coordinates("#{x.address.gsub(/\n/, '')}+#{x.postcode}")
  # x.update_attributes(latitude: latlng[0], longitude: latlng[1])
  # x.save!
  def self.batch_geocode
    #where('latitude is null').find_in_batches(batch_size: 100) do |group|
    # sleep(10)
    # group.each { |x| x.save! }
    #end
    where("latitude is null and postcode != '' and town != ''").find_in_batches(batch_size: 100) do |group|
      sleep(10)
      group.each do |x|
        latlng = Geocoder.coordinates("#{x.address.gsub(/\n/, '')}+#{x.postcode}")
        latlng = Geocoder.coordinates("#{x.county}+#{x.postcode}") unless latlng.present? || ( x.county.blank? && x.postcode.blank? )
        if latlng.present?
          x.update_attributes(latitude: latlng[0], longitude: latlng[1])
          x.save!
        end
      end
    end
  end
end
