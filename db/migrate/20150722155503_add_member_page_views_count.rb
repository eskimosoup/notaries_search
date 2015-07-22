class AddMemberPageViewsCount < ActiveRecord::Migration
  def change
    add_column :members, :member_page_views_count, :integer, default: 0
  end
end
