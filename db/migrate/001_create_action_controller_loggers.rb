class CreateActionControllerLoggers < ActiveRecord::Migration
  def change
    create_table :action_controller_loggers do |t|
      t.string   :transaction_id
      t.string   :controller
      t.string   :action
      t.integer  :status,       limit: 2, default: 0
      t.text     :payload
      t.datetime :start_time
      t.datetime :end_time
      t.column   :view_runtime, 'FLOAT UNSIGNED'
      t.column   :db_runtime,   'FLOAT UNSIGNED'
      t.column   :duration,     'FLOAT UNSIGNED'
    end
    add_index :action_controller_loggers, [:transaction_id]    
  end

  def self.down
    drop_table :action_controller_loggers
  end
end
