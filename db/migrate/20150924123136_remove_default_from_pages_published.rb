class RemoveDefaultFromPagesPublished < ActiveRecord::Migration
  def change
    change_column_default :pages, :published, nil
  end
end
