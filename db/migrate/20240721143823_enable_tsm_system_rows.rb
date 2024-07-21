class EnableTsmSystemRows < ActiveRecord::Migration[7.1]
  def up
    enable_extension('tsm_system_rows')
  end

  def down
    disable_extension('tsm_system_rows')
  end
end
