# == Schema Information
#
# Table name: patents
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  agency     :string(255)
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Patent < ActiveRecord::Base
  belongs_to :user

  attr_accessible :agency, :status, :title
end
