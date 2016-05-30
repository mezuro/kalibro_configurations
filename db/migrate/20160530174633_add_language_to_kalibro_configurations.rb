class AddLanguageToKalibroConfigurations < ActiveRecord::Migration
  def change
    change_table :kalibro_configurations do |t|
      t.column :language, :string
      t.index :language
    end
  end
end
