class CreateParties < ActiveRecord::Migration[5.0]
  def change
    create_table :parties do |t|
      t.string  :name,           null: false, default: "未登録"
      t.integer :status,         null: false, default: 1
      t.date    :established_on, null: false, default: Time.zone.now
      t.date    :dissolved_on,   null: true
      t.timestamps
    end
  end
end
