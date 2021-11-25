# frozen_string_literal: true

class User < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { minimum: 3 }, on: :create
  validates :role, presence: true
  validates :password, confirmation: true, presence: true,
                       length: { minimum: 6 }, on: :create

  has_secure_password

  enum role: %w[admin customer]
end
