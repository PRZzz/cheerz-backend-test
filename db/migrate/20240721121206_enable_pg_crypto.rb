class EnablePgCrypto < ActiveRecord::Migration[7.1]
  def up
    enable_extension('pgcrypto')
  end

  def down
    disable_extension('pgcrypto')
  end
end
