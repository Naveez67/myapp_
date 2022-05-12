# frozen_string_literal: true

class User < ApplicationRecord
  has_many :received_follows, foreign_key: :followee_id, class_name: 'Relationship'
  has_many :followers, through: :received_follows, source: :follower

  has_many :given_follows, foreign_key: :follower_id, class_name: 'Relationship'
  has_many :followings, through: :given_follows, source: :followed_user

  has_many :stories, dependent: :destroy

  has_many :posts, dependent: :destroy

  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable

  # def_index do
  #   indexes :name, sortable: true
  # end
  include PgSearch
  pg_search_scope :search, against: [:name],
                           using: { tsearch: { prefix: true } }

  validates_presence_of :name, :email, :password
  validates_confirmation_of :password
end
