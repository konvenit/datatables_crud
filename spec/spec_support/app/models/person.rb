# == Schema Information
#
# Table name: people
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  date_of_birth   :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Person < ActiveRecord::Base
  belongs_to :organization
end
