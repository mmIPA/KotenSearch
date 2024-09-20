class Post < ApplicationRecord
  belongs_to :user
  
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :place, presence: true
end
