class Admin::DashboardController < ApplicationController
  def index
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end
