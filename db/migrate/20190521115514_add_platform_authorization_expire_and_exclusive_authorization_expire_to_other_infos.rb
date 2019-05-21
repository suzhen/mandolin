class AddPlatformAuthorizationExpireAndExclusiveAuthorizationExpireToOtherInfos < ActiveRecord::Migration[5.2]
  def change
    add_column :other_infos, :platform_authorization_expire, :datetime
    add_column :other_infos, :exclusive_authorization_expire, :datetime
    add_column :other_infos, :edition, :string
  end
end
