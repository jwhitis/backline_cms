class RemoveImageAndVideoEmbedFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :image, :string
    remove_column :pages, :video_embed, :text
  end
end
