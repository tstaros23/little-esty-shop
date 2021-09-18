require 'rails_helper'

RSpec.describe "merchant items show page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
  end

  it "links to merchant item's show page" do

    visit merchant_items_path(@merchant_1)

    click_link(@item_1.name)
    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.unit_price)
  end

  it 'shows a link to update item information' do
    visit merchant_item_path(@merchant_1, @item_1)

    expect(page).to have_content("Update Item")
    click_link "Update Item"
    expect(current_path).to eq(edit_item_path(@item_1))
  end
end
