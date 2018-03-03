class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # devise 內建的驗證

  def admin? # 驗證是否是管理員
    self.role == "admin"
  end
  
end
