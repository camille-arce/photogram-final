# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many(:comments, { :class_name => "Comment", :foreign_key => "author_id" })

 # has_many(:sent_follow_requests, { :class_name => "FollowRequest", :foreign_key => "recipient_id" })

 # has_many(:received_follow_requests, { :class_name => "FollowRequest", :foreign_key => "sender_id" })

  has_many(:own_photos, { :class_name => "Photo", :foreign_key => "owner_id" })

  # Created so that an indirect association from User to Photos can be made - through "user_likes" / :through - should be in the same model as the first table were are coming from
  has_many(:user_likes, { :class_name => "Like", :foreign_key => "fan_id" })

  has_many(:liked_photos, { :through => :user_likes, :source => :like_to_photos})

end
