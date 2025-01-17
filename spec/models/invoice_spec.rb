require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'merchant side setup' do
     before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @customer_1 = create(:customer)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_2)
      @item_4 = create(:item, merchant: @merchant_2)
      @invoice_1 = create(:invoice, customer: @customer_1, created_at: "Friday, September 17, 2021" )
      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, status: "shipped")
    end

    it 'has merchant invoices' do
      expect(@merchant_1.merchant_invoices).to eq([@invoice_1])
    end

    it 'has the date formated' do
      expect(@invoice_1.date).to eq("Friday, September 17, 2021")
    end
  end

  describe 'admin side setup' do
    before(:each) do
      @customer = create(:customer)
      @invoice_1 = create(:invoice, customer: @customer)
      @invoice_2 = create(:invoice, customer: @customer)
      @invoice_3 = create(:invoice, customer: @customer, created_at: Date.new(2020, 9, 17))
      @merchant = create(:merchant)
      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)
      @invoice_item_1 = create(:invoice_item, item: @item_1, status: 'shipped', invoice: @invoice_1, quantity: 10, unit_price: 10)
      @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 1, unit_price: 5)
      @invoice_item_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3, quantity: 2, unit_price: 10)
      @invoice_item_4 = create(:invoice_item, item: @item_1, status: 'shipped', invoice: @invoice_1, quantity: 10, unit_price: 10)

    end

    describe 'class methods' do
      it "gets all incomplete invoices" do
        expect(Invoice.incomplete_invoices).to eq([@invoice_2, @invoice_3])
      end

     it 'sorts invoices from oldest to newest' do
       expect(Invoice.order_by_oldest).to eq([@invoice_3, @invoice_2])
      end
    end

    describe 'instance methods' do
      it 'formats customer name' do
        expect(@invoice_1.customer_name).to eq("#{@customer.first_name} #{@customer.last_name}")
      end

      it "can calculate revenue" do
        expect(@invoice_1.revenue).to eq(200)
      end
    end
  end
end
