class AddSomeColsToCopies < ActiveRecord::Migration[5.2]
  def change
    add_column :lyric_copies, :agreement_number, :string, :comment=>"权利对应协议编号"
    add_column :melody_copies, :agreement_number, :string, :comment=>"权利对应协议编号"
    add_column :producer_copies, :agreement_number, :string, :comment=>"权利对应协议编号"
    add_column :recording_copies, :agreement_number, :string, :comment=>"权利对应协议编号"
    add_column :producer_copies, :begin_date, :date, :comment=>"开始时间"
    add_column :producer_copies, :end_date, :date, :comment=>"结束时间"
    add_column :producer_copies, :disctrict, :string, :comment=>"授权地域"
  end
end
