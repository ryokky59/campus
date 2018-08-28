class AddColumnToPictures < ActiveRecord::Migration[5.1]
  def change
    add_reference :pictures, :user, index: true
  end
end
