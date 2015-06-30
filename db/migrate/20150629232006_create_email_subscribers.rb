class CreateEmailSubscribers < ActiveRecord::Migration
  def change
    create_table :email_subscribers do |t|
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end
