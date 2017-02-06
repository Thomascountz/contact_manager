class AddEmailAddressesToCompanies < ActiveRecord::Migration
  def up
    EmailAddress.destroy_all
    remove_column :email_address, :person_id
    add_column :email_address, :contact_id, :integer
    add_column :email_address, :contact_type, :string
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
