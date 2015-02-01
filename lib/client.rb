require 'httparty'
require 'json'
require 'pry'

class NoteClient
	include HTTParty
	base_uri "http://10.0.1.4:3301"

	def get_user(id)
		resp = self.class.get("/users/#{id}")
		JSON.parse(resp.body)
	end

	def get_all_users
		resp = self.class.get("/users")
		users = JSON.parse(resp.body)
		user_info = []
		users.each do |x|
			user_info << get_user(x['user_name'])
		end
		return user_info
	end

	def delete_user(id)
		self.class.delete("/users/#{id}")
	end

	def add_user(user_name)
		options = {:body => {:user_name => user_name}}
		self.class.post("/users/", :body => options)
	end

	def new_message
		options = {:sender_id => sender_id, :receiver_id => receiver_id, :message_body => message_body}
		resp = self.class.post("/messages", :body => options)
	end

	def delete_message(message_id)
		self.class.delete("/messages/#{message_id}")
	end

	def mark_read(message_id)
		options = {:message_status => message_status}
		self.class.put("/messages/#{message_id}", :body => options)
	end

	def mark_unread(message_id)
		options = {:message_status => message_status}
		self.class.delete("/messages/#{message_id}", :body => options)
	end

	def get_all_messages
		options = {:user_name => user_name}
		resp = self.class.get("/messages", :body => options)
		messages = JSON.parse(resp.body)
    all_messages = []
    messages.each do |x|
    	all_messages << get_message(x['message_id'])
    end
    return all_messages
	end

	def get_message(message_id)
		resp = self.class.get("/messages/#{message_id}")
		JSON.parse(resp.body)
	end
end


client = NoteClient.new

binding.pry