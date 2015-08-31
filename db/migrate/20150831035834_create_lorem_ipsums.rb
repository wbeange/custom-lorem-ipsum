class CreateLoremIpsums < ActiveRecord::Migration
  def up
    create_table :lorem_ipsums do |t|
      t.references :user
      t.string :title
      t.text :keywords
      t.timestamps
    end
  end

  def down
    drop_table :lorem_ipsums
  end
end
