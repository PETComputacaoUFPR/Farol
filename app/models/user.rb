class User < ApplicationRecord
  rolify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable

  has_many :documents, dependent: :destroy


  def admin?
    has_role?(:admin)
  end

  def client?
    has_role?(:client)
  end

end
