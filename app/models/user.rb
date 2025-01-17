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

  # Direct associations
  has_many(:comments, { :class_name => "Comment", :foreign_key => "author_id", :dependent => :destroy })
  has_many(:own_photos, { :class_name => "Photo", :foreign_key => "owner_id" })
  has_many(:sent_follow_requests, { :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy })
  has_many(:accepted_sent_follow_requests, -> { where(status: "accepted") }, { :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy })
  has_many(:received_follow_requests, { :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy })
  # Created so that an indirect association from User to Photos can be made - through "user_likes" / :through - should be in the same model as the first table were are coming from
  has_many(:user_likes, { :class_name => "Like", :foreign_key => "fan_id", :dependent => :destroy })

  
  #Indirect associations
  has_many(:following, { :through => :accepted_sent_follow_requests, :source => :recipient })
  has_many(:followers, { :through => :received_follow_requests, :source => :sender })
  has_many(:liked_photos, { :through => :user_likes, :source => :like_to_photos })

  has_many(:feed, { :through => :following, :source => :own_photos })
  has_many(:activity, { :through => :following, :source => :liked_photos })

  def follow_request_for(other_user)
    FollowRequest.find_by({ :recipient_id => other_user.id, :sender_id => self.id })
  end
end
