class CreateActionControllerLoggers < ActiveRecord::Migration
  def change
    create_table :action_controller_loggers do |t|
      t.string   :transaction_id
      t.text     :payload
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :view_runtime
      t.datetime :db_runtime
      t.column   :duration, 'FLOAT UNSIGNED'
    end
    add_index :action_controller_loggers, [:transaction_id]    
  end
end
