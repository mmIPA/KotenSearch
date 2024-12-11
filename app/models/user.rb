class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: { maximum: 50 }

  def update_without_current_password(params, *options)
    params = params.dup
    params.delete(:password) if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?
    current_password = params.delete(:current_password)

    if params[:password].present? || params[:password_confirmation].present?
      # 現在のパスワードが未入力の場合エラー
      if current_password.blank?
        errors.add(:current_password, "を入力してください")
        return false
      end
  
      # 現在のパスワードが間違っている場合エラー
      unless valid_password?(current_password)
        errors.add(:current_password, "が誤っています")
        return false
      end
  
      # 新しいパスワードと確認用パスワードが一致しない場合エラー
      unless params[:password] == params[:password_confirmation]
        errors.add(:password_confirmation, "パスワード確認が一致しません")
        return false
      end
    end
    update(params)
  end
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
end
