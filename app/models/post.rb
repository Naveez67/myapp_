# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_one_attached :avatar

  has_rich_text :content

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
end
