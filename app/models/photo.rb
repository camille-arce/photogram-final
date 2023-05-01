# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string           not null
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer          not null
#
class Photo < ApplicationRecord
  validates(:owner_id, { :presence => true })

  belongs_to(:own_photos, { :class_name => "User", :foreign_key => "owner_id" })
end
