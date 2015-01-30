class CreateMessage < ActiveRecord::Migration
	def self.up 
		create_table :messages do |t|
			t.integer :user_id
			t.string :message_body
			t.boolean :message_status, default: false
		end
	end

	def self.down
		drop_table :messages
	end
end
