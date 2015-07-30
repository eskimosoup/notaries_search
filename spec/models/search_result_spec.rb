require 'rails_helper'

RSpec.describe SearchResult, type: :model do
  describe "associations", :association do
    it { should belong_to(:search).counter_cache(true) }
    it { should belong_to(:member_location) }
  end
end
