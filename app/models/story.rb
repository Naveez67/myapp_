# frozen_string_literal: true

class Story < ApplicationRecord
  validates :body, presence: true

  belongs_to :user

  has_one_attached :avatar
end
