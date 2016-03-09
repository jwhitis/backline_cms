class AddSiteReferenceToTables < ActiveRecord::Migration
  def change
    add_reference :albums,          :site, index: true, null: false
    add_reference :nav_links,       :site, index: true, null: false
    add_reference :pages,           :site, index: true, null: false
    add_reference :photos,          :site, index: true, null: false
    add_reference :shows,           :site, index: true, null: false
    add_reference :subscribers,     :site, index: true, null: false
    add_reference :tracks,          :site, index: true, null: false
    add_reference :tweets,          :site, index: true, null: false
    add_reference :twitter_handles, :site, index: true, null: false
    add_reference :videos,          :site, index: true, null: false

    add_foreign_key :albums,          :sites
    add_foreign_key :nav_links,       :sites
    add_foreign_key :pages,           :sites
    add_foreign_key :photos,          :sites
    add_foreign_key :shows,           :sites
    add_foreign_key :subscribers,     :sites
    add_foreign_key :tracks,          :sites
    add_foreign_key :tweets,          :sites
    add_foreign_key :twitter_handles, :sites
    add_foreign_key :videos,          :sites
  end
end
