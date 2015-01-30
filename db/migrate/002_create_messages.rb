class CreateMessage < ActiveRecord::Migration
	def self.up 
		create_table :messages do |t|
			t.integer :message_id
			t.integer :user_id
			t.string :message_body
			t.boolean :message_status, default: false
			t.timestamps
		end
	end

	def self.down
		drop_table :messages
	end
end
