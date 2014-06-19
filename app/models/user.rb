# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  group_id               :integer
#  name                   :string(255)
#  identity               :integer
#  phone                  :string(255)
#

class User < ActiveRecord::Base
  has_many :papers
  has_many :patents
  has_many :projects
  has_many :dailies
  has_many :histories
  has_many :comments
  has_many :plans
  has_many :documents
  belongs_to :group

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :identity, :phone

  validates :name,      :presence => true,
                        :uniqueness => {:case_sensitive => false}
  validates :identity,  :presence => true,
                        :numericality => {:only_integer => true}
end
