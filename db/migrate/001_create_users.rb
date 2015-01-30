class CreateUser < ActiveRecord::Migration
	def self.up 
		create_table :users do |t|
			t.string :user_name
			t.integer :user_id
		end
	end

	def self.down
		drop_table :users
	end
end
