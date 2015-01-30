require "notepasser/version"
require "notepasser/init_db"
require "camping"
require "pry"

Camping.goes :Notepasser

module Notepasser
	module Notepasser::Models
		class User < Base
			has_many :messages
		end

		class Message < Base
			belongs_to :user
		end

		
	end
end

module Notepasser::Controllers
end
