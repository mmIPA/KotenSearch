class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true, length: { maximum: 50 }

  def update_without_current_password(params, *options)
    params.delete(:password) if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?

    if params[:current_password].present?
      if valid_password?(params[:current_password])
        update(params, *options)
      else
        errors.add(:current_password, :invalid)
        false
      end
    else
      if params[:password].present? || params[:password_confirmation].present?
        if params[:password] == params[:password_confirmation]
          update(params, *options)
        else
          errors.add(:password_confirmation, "パスワード確認が一致しません")
          false
        end
      else
        update(params, *options)
      end
    end
  end
end
