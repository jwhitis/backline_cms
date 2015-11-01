class RenamePagesStandaloneToBlankLayout < ActiveRecord::Migration
  def change
    rename_column :pages, :standalone, :blank_layout
  end
end
