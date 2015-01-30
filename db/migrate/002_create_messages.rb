class CreateMessage < ActiveRecord::Migration
	def self.up 
		create_table :messages do |t|
			t.integer :sender_id
			t.integer :receiver_id
			t.integer :message_id, uniqueness: true
			t.string :message_body
			t.boolean :message_status, default: false
			t.timestamps null: true
		end
	end

	def self.down
		drop_table :messages
	end
end
