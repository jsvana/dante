class AddVoteToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :vote, :integer, default: 0
  end
end
