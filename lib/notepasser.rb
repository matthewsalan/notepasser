require "notepasser/version"
require "notepasser/init_db"
require "camping"
require "pry"

Camping.goes :Notepasser

module Notepasser
	module Notepasser::Models
		class User < ActiveRecord::Base
			has_many :messages
		end

		class Message < ActiveRecord::Base
			belongs_to :user
		end	
	end
end

module Notepasser::Controllers 
	class Index < R '/'
		def get
			"Welcome To Notepasser!"
		end
	end
	
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
	end

	class MessageReadController < R '/messages/(\d+)'
  	def put 
  		message = Notepasser::Models::Message.find(message_id)
  		message.update_attribute(:message_status => true)
  		message.save
  	end
  end

  class MessageUnreadController < R '/messages/(\d+)'
  	def put
  	  message = Notepasser::Models::Message.find(message_id)
  	  message.update_attribute(:message_status => false)
  	  message.save
  	end
  end

  class MessagesController < R '/messages'
    def post 
      @input.symbolize_keys!
      new_message = Notepasser::Models::Message.new
      [:messgage_id, :sender_id, :receiver_id, :message_body].each do |x|
      	new_message[x] = @input[x]
      end
    	new_message.save
    	@status = 201
    	{:message => "Message #{new_message.id} has been created",
        :code => 201,
        :post => new_message}.to_json
    end

		def get 
			page = @input['page'].to_i || 1
			start = (page - 1) * 20
			finish = (page * 20) - 1
			Notepasser::Models::Message.where(:id)
		end
	end

	class UsersController < R '/users'
		def post
			@input.symbolize_keys!
			new_user = Notepasser::Models::User.new
			[:user_name].each do |x|
		    new_user[x] = @input[x]
		  end
			new_user.save
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




