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

  has_many(:photo_comments, { :class_name => "Comment", :foreign_key => "photo_id"})

  belongs_to(:poster, { :class_name => "User", :foreign_key => "owner_id" })

  has_many(:photo_to_likes, { :class_name => "Like", :foreign_key => "photo_id" })

  has_many(:fans, { :through => "photo_to_likes", :source => "like_to_user" })
end
