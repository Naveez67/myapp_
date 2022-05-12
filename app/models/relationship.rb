# frozen_string_literal: true

class Relationship < ApplicationRecord
  validates :follower_id, uniqueness: { scope: :followee_id }
  validates :followee_id, uniqueness: { scope: :follower_id }

  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'

  belongs_to :followed_user, foreign_key: :followee_id, class_name: 'User'
end
