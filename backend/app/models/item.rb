# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :user
  before_save :set_default_image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :sellered_by, ->(username) { where(user: User.where(username: username)) }
  scope :favorited_by, ->(username) { joins(:favorites).where(favorites: { user: User.where(username: username) }) }

  acts_as_taggable

  validates :title, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :slug, uniqueness: true, exclusion: { in: ['feed'] }

  before_validation do
    self.slug ||= "#{title.to_s.parameterize}-#{rand(36**6).to_s(36)}"
  end

  private
  def set_default_image
    if self.image.empty?
      self.image = "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"
    end
  end
end
