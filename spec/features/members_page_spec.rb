require 'rails_helper'

RSpec.feature "Members page", type: :feature do

  subject(:member) { create(:member)}
  let!(:member_location) { create(:member_location, member: member) }
  let!(:membership_detail) { create(:practising_membership_detail, member: member)}

  before { @member_page_views = member.member_page_views_count }

  scenario "viewing a member page changes members page views" do
    visit member_path(notary: member.id)
    expect(current_url).to eq member_url(notary: member.id)
    expect(page).to have_content(member_location.contact_phone)
    expect(page).to have_content(member_location.contact_mobile)
    expect(page).to have_content(member_location.email)
    expect(page).to have_content(member_location.fax)
    expect(page).to have_content(member_location.website)
    expect(page).to have_content(member_location.postcode)
    expect(page).to have_content(member.firstname)
    expect(page).to have_content(member.lastname)
    expect(member.reload.member_page_views_count).to be > @member_page_views
  end
end
