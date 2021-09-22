require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  it "shows every merchant" do
    merchant_1 = Merchant.create!(name: 'Weston')
    merchant_2 = Merchant.create!(name: 'Ted')

    visit admin_merchants_path

    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
  end



  it 'can enable and disable merchants' do
    merchant_1 = Merchant.create!(name: 'Weston', status: true)
    merchant_2 = Merchant.create!(name: 'Ted', status: true)

    visit admin_merchants_path

    within('#enabled-merchants') do

      expect(page).to have_button("Disable: #{merchant_1.name}")
      expect(page).to have_button("Disable: #{merchant_2.name}")

      click_button "Disable: #{merchant_1.name}"
    end

    expect(current_path).to eq(admin_merchants_path)

    within('#disabled-merchants') do
      expect(page).to have_button("Enable: #{merchant_1.name}")

      click_button "Enable: #{merchant_1.name}"
    end

    expect(current_path).to eq(admin_merchants_path)
    within('#enabled-merchants') do
      expect(page).to have_button("Disable: #{merchant_1.name}")
    end
  end

  it "has a link to create a new merchant that takes you to the new admin merchant page" do
    merchant = Merchant.create!(name: 'Weston')

    visit admin_merchants_path

    expect(page).to have_link('New Merchant')

    click_link 'New Merchant'

    expect(current_path).to eq(new_admin_merchant_path)
  end

  it 'can show the 5 most successful merchants' do
    customer = create(:customer)

    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    invoice_1 = create(:invoice, customer: customer, created_at: "Friday, September 17, 2021" )
    transaction = create(:transaction, result: 'success', invoice: invoice_1)
    invoice_item_1 = create(:invoice_item, item: item_1, status: 2, unit_price: 4, quantity: 4, invoice: invoice_1)

    merchant_2 = create(:merchant)
    item_2 = create(:item, merchant: merchant_2)
    invoice_2 = create(:invoice, customer: customer, created_at: "Thursday, September 16, 2021")
    transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)
    invoice_item_2 = create(:invoice_item, item: item_2, status: 0, unit_price: 6, quantity: 6, invoice: invoice_2, created_at: "Wednesday, September 15, 2021")

    merchant_3 = create(:merchant)
    item_3 = create(:item, merchant: merchant_3)
    invoice_3 = create(:invoice, customer: customer, created_at: "Wednesday, September 15, 2021")
    transaction_3 = create(:transaction, result: 'success', invoice: invoice_3)
    invoice_item_3 = create(:invoice_item, item: item_3, status: 2, unit_price: 8, quantity: 8, invoice: invoice_3)

    merchant_4 = create(:merchant)
    item_4 = create(:item, merchant: merchant_4)
    invoice_4 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
    transaction_4 = create(:transaction, result: 'success', invoice: invoice_4)
    invoice_item_4 = create(:invoice_item, item: item_4, status: 2, unit_price: 10, quantity: 10, invoice: invoice_4)

    merchant_5 = create(:merchant)
    item_5 = create(:item, merchant: merchant_5)
    invoice_5 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
    transaction_5 = create(:transaction, result: 'success', invoice: invoice_5)
    invoice_item_5 = create(:invoice_item, item: item_5, status: 2, unit_price: 12, quantity: 12, invoice: invoice_5)

    merchant_6 = create(:merchant)
    item_6 = create(:item, merchant: merchant_6)
    invoice_6 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
    transaction_6 = create(:transaction, result: 'success', invoice: invoice_6)
    invoice_item_6 = create(:invoice_item, item: item_6, status: 2, unit_price: 14, quantity: 14, invoice: invoice_6)

    merchant_7 = create(:merchant)
    item_7 = create(:item, merchant: merchant_7)
    invoice_7 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
    transaction_7 = create(:transaction, result: 'failed', invoice: invoice_7)
    invoice_item_7 = create(:invoice_item, item: item_7, status: 2, unit_price: 50, quantity: 50, invoice: invoice_7)

    visit admin_merchants_path

    within('#top-5-merchants') do
      expect(page).to have_content(merchant_6.name)
      expect(page).to have_content(merchant_5.name)
      expect(page).to have_content(merchant_4.name)
      expect(page).to have_content(merchant_3.name)
      expect(page).to have_content(merchant_2.name)

      expect(page).to have_content("Total revenue: 196")
      expect(page).to have_content("Total revenue: 144")
      expect(page).to have_content("Total revenue: 100")
      expect(page).to have_content("Total revenue: 64")
      expect(page).to have_content("Total revenue: 36")

      expect(page).to have_link(merchant_6.name)

      click_link merchant_6.name

      expect(current_path).to eq(admin_merchant_path(merchant_6))
    end
  end

  it 'shows merchants best day' do
    customer = create(:customer)

    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    invoice_1 = create(:invoice, customer: customer, created_at: "Friday, September 17, 2021" )
    transaction = create(:transaction, result: 'success', invoice: invoice_1)
    invoice_item_1 = create(:invoice_item, item: item_1, status: 2, unit_price: 4, quantity: 4, invoice: invoice_1)

    merchant_2 = create(:merchant)
    item_2 = create(:item, merchant: merchant_2)
    invoice_2 = create(:invoice, customer: customer, created_at: "Thursday, September 16, 2021")
    transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)
    invoice_item_2 = create(:invoice_item, item: item_2, status: 0, unit_price: 6, quantity: 6, invoice: invoice_2, created_at: "Wednesday, September 15, 2021")

    merchant_3 = create(:merchant)
    item_3 = create(:item, merchant: merchant_3)
    invoice_3 = create(:invoice, customer: customer, created_at: "Wednesday, September 15, 2021")
    transaction_3 = create(:transaction, result: 'success', invoice: invoice_3)
    invoice_item_3 = create(:invoice_item, item: item_3, status: 2, unit_price: 8, quantity: 8, invoice: invoice_3)

    merchant_4 = create(:merchant)
    item_4 = create(:item, merchant: merchant_4)
    invoice_4 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
    transaction_4 = create(:transaction, result: 'success', invoice: invoice_4)
    invoice_item_4 = create(:invoice_item, item: item_4, status: 2, unit_price: 10, quantity: 10, invoice: invoice_4)

    merchant_5 = create(:merchant)
    item_5 = create(:item, merchant: merchant_5)
    invoice_5 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
    transaction_5 = create(:transaction, result: 'success', invoice: invoice_5)
    invoice_item_5 = create(:invoice_item, item: item_5, status: 2, unit_price: 12, quantity: 12, invoice: invoice_5)

    merchant_6 = create(:merchant)
    item_6 = create(:item, merchant: merchant_6)
    invoice_6 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
    transaction_6 = create(:transaction, result: 'success', invoice: invoice_6)
    invoice_item_6 = create(:invoice_item, item: item_6, status: 2, unit_price: 14, quantity: 14, invoice: invoice_6)

    merchant_7 = create(:merchant)
    item_7 = create(:item, merchant: merchant_7)
    invoice_7 = create(:invoice, customer: customer, created_at: "Tuesday, September 14, 2021")
    transaction_7 = create(:transaction, result: 'failed', invoice: invoice_7)
    invoice_item_7 = create(:invoice_item, item: item_7, status: 2, unit_price: 50, quantity: 50, invoice: invoice_7)

    visit admin_merchants_path


    
  end

  # As an admin,
  # When I visit the admin merchants index
  # Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
  # And I see a label “Top selling date for was "
  #
  # Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.

end
