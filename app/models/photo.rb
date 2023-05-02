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
  validates(:image, { :presence => true })

  #direct associations
  has_many(:photo_comments, { :class_name => "Comment", :foreign_key => "photo_id", :dependent => :destroy} )
  belongs_to(:poster, { :required => true, :class_name => "User", :foreign_key => "owner_id"}) # :counter_cache => true })
  has_many(:photo_to_likes, { :class_name => "Like", :foreign_key => "photo_id", :dependent => :destroy })

  #indirect associations
  has_many(:fans, { :through => "photo_to_likes", :source => "like_to_user" })
  #has_many(:followers, { :through => :poster, :source => :following })
  #has_many(:fan_followers, { :through => :fans, :source => :following })
  

end
