class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :subtitle

      t.integer :section_id
      t.timestamps
    end


    add_index :lessons, :section_id # contains itself and whatever you're going to use to associate it to other models
      # since it has section_id it belongs to particular section so you have to create that association in lesson.rb file
  end
end
