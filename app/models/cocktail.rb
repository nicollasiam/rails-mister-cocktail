class Cocktail < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  mount_uploader :photo_url, PhotoUploader

  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  validates :name, uniqueness: true, presence: true

  validate :photo_xor_photo_url
  validates :remote_photo_url, format: { with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,
                                         message: "Invlid URL" }

  private

  def photo_xor_photo_url
    unless photo.blank? ^ photo_url.blank?
      errors.add(:cocktail, "Specify a picture or a URL, not both")
    end
  end
end
