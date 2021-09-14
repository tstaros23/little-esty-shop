class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :status, default: 0
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
