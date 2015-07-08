class NotariesSocietyUpload < ActiveRecord::Base
  establish_connection :notaries_society_development if Rails.env.development?
  establish_connection :notaries_society_production if Rails.env.production?
  self.table_name = 'users'

  def self.import
    all.find_each do |user|
      new_member =  Member.create(user.member_attrs)
      new_member.create_membership_detail(user.membership_details_attrs)
      new_member.member_locations.create(user.location_attrs)  if user.address.present?
      new_member.member_locations.create(user.location2_attrs) if user.address2.present?
    end
    MemberLocation.batch_geocode
  end

  def member_attrs
    {
      contact_id: contact_id,
      status: status,
      role: role,
      email: email,
      title: title,
      firstname: firstname,
      lastname: lastname,
      username: username,
      password: password,
      notes: notes,
      forgotten_hash: forgotten_hash,
      lastlogin: lastlogin,
      created: created,
      modified: modified
    }
  end

  def membership_details_attrs
    {
      country_code: country_code,
      in_practice: in_practice,
      is_admin: is_admin,
      is_member: is_member,
      is_student: is_student,
      is_council_member: is_council_member,
      is_treasurer: is_treasurer,
      is_secretary: is_secretary,
      is_education_secretary: is_education_secretary,
      vice_president: vice_president,
      vice_president_date: vice_president_date,
      president: president,
      president_date: president_date,
      date_of_election: date_of_election,
      membership_class: membership_class,
      faculty_date: faculty_date,
      date_joined: date_joined,
      date_subscription_paid: date_subscription_paid,
      date_retired: date_retired,
      date_struck_off_membership: date_struck_off_membership,
      date_died: date_died
    }
  end

  def location_attrs
    {
      dx_number: dx_number,
      contact_phone: contact_phone,
      contact_mobile: contact_mobile,
      fax: fax,
      website: website,
      address: address,
      town: town,
      county: county,
      postcode: postcode
    }
  end

  def location2_attrs
    {
      dx_number: dx_number2,
      contact_phone: phone2,
      contact_mobile: mobile2,
      fax: fax2,
      website: website2,
      address: address2,
      town: town2,
      county: county2,
      postcode: postcode2,
      email: email2
    }
  end
  
  # def self.has_location2?(user)
  #  if user.address2.present?
  #   true
  #  else
  #    false
  #  end
  # end
end
