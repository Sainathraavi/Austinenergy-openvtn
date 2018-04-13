class ChangeVenMessagesOadrMessage < ActiveRecord::Migration
  def up
    change_column :ven_messages, :oadr_message, :mediumtext
  end

  def down
    change_column :ven_messages, :oadr_message, :text
  end
end
