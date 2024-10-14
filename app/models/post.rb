class Post < ApplicationRecord
  belongs_to :user
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :comments, dependent: :destroy
  
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :place, presence: true
  validates :image, presence: true
  validate :image_size_validation
  
  private

  def image_size_validation
    if image.size > 5.megabytes
      errors.add(:image, "は5MB以下でアップロードしてください。")
    end
  end
  
end
