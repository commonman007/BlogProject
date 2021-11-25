# frozen_string_literal: true

class Blog < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true,
                    length: { minimum: 5 }

  has_one_attached :image
end
