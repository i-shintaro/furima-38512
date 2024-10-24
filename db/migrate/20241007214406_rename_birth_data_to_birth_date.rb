class RenameBirthDataToBirthDate < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :birth_data, :birth_date
  end
end
