class CreateRequests < ActiveRecord::Migration
  def up
    create_table :requests do |t|
      t.string :type
      t.string :artist
      t.string :album
      t.string :title

      t.timestamps
    end
  end

  def down
    drop_table :requests
  end
end
