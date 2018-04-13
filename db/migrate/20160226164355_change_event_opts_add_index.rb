class ChangeEventOptsAddIndex < ActiveRecord::Migration
  def change
     add_index :event_opts, ["created_at"], name: "index_event_opts_on_created_at", unique: false
  end
end
