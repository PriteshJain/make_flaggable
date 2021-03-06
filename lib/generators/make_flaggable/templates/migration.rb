class CreateMakeFlaggableTables < ActiveRecord::Migration
   def self.up
     create_table :flaggings do |t|
       t.string   :flaggable_type
       t.integer  :flaggable_id
       t.string   :flagger_type
       t.integer  :flagger_id
       t.string   :flag
       t.string   :message , :limit=> 500
       t.timestamps
    end

    add_index :flaggings, [:flaggable_type, :flaggable_id]
    add_index :flaggings, [:flag, :flaggable_type, :flaggable_id]
    add_index :flaggings, [:flagger_type, :flagger_id, :flaggable_type, :flaggable_id], :name => "access_flaggings"
    add_index :flaggings, [:flag, :flagger_type, :flagger_id, :flaggable_type, :flaggable_id], :name => "access_flag_flaggings"
  end

  def self.down
    remove_index :flaggings, :column => [:flaggable_type, :flaggable_id]
    remove_index :flaggings, :column => [:flag, :flaggable_type, :flaggable_id]
    remove_index :flaggings, :name => "access_flaggings"
    remove_index :flaggings, :name => "access_flag_flaggings"
    
    drop_table :flaggings
  end
end
