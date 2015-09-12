class RenameApplicationsTableToRegApplications < ActiveRecord::Migration
  def change
    rename_table :applications, :reg_applications
  end
end
