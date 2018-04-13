class ChangeVensDistributeEventPayload < ActiveRecord::Migration
  def up
    change_column :vens, :distribute_event_payload, :mediumtext
  end

  def down
    change_column :vens, :distribute_event_payload, :text
  end
end
