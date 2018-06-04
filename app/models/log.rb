class Log < ApplicationRecord
	serialize :foods, Array

	belongs_to :user
end
