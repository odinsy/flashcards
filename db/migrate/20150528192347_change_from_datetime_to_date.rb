class ChangeFromDatetimeToDate < ActiveRecord::Migration
  def change
  	change_column :cards, :review_date, :date
  end
end