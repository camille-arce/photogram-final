# == Schema Information
#
# Table name: follow_requests
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class FollowRequest < ApplicationRecord
  validates(:recipient_id, { :presence => true })
  validates(:sender_id, { :presence => true })

  belongs_to(:sent_follow_requests, { :class_name => "User", :foreign_key => "recipient_id"})
  belongs_to(:received_follow_requests, { :class_name => "User", :foreign_key => "sender_id" })
end
