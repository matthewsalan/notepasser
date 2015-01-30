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
	class MessageController < R '/messages/(\d+)'
		def get(message_id)
			message = Notepasser::Models::Message.find(message_id)
			message.to_json
		rescue ActiveRecord::RecordNotFound
			@status = 404
			"404 - Message Not Found"
		end

		def delete(message_id)
			message = Notepasser::Models::Message.find(message_id)
			message.destroy
			@status = 204
		rescue ActiveRecord::RecordNotFound
			@status = 404
			"No Message To Delete"
		end

	class MessagesController < R '/messages'
    def post 
		end

		def read_unread 
		end

		def get 
		end
	end

	class UsersController < R '/users'
		def post
			@input.symbolize_keys!
			new_user = Notepasser::Models::User.new
			[:user_name, :user_id].each do |x|
				new_user[x] = @input[x]
			end
		end
	end

	class UserController < R '/users/(\d+)'
    def delete(user_id) 
    	user = Notepasser::Models::User.find(user_id)
    	user.destroy
    	@status = 204
    rescue ActiveRecord::RecordNotFound
    	@status = 404
    	"No User To Delete"
		end

		def get(user_id) 
			user = Notepasser::Models::User.find(user_id)
		rescue ActiveRecord::RecordNotFound
			@status = 404
			"404 - No User Found"
		end
	end
end
