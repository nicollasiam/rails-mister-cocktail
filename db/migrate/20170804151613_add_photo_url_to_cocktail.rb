class AddPhotoUrlToCocktail < ActiveRecord::Migration[5.0]
  def change
    add_column :cocktails, :photo_url, :string
  end
end
