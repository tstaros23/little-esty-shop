require "rails_helper"

RSpec.describe 'admin show page' do
  before(:each) do
    @customer = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer, created_at: Date.new(2021, 9, 17))
  end

  it 'shows relevant invoice information' do
    visit admin_invoice_path(@invoice_1)

    within('#invoice-information') do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content("Friday, September 17, 2021")
      expect(page).to have_content("#{@customer.first_name} #{@customer.last_name}")
    end

  end
end


# As an admin
# When I visit an admin invoice show page
# Then I see all of the items on the invoice including:
#
# Item name
# The quantity of the item ordered
# The price the Item sold for
# The Invoice Item status
