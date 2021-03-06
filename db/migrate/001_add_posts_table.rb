#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddPostsTable < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.column :author, :string
      t.column :title, :string
      t.column :body, :text
      t.column :created_at, :datetime
    end
  end

  def self.down
  end
end
