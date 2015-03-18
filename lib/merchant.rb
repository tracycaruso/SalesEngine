require_relative 'csv_parser'
require_relative 'merchant_repository'
require_relative 'sales_engine'

require 'bigdecimal'
require 'bigdecimal/util'
class Merchant


  attr_reader :id, :name, :created_at, :updated_at, :repository

  def initialize(id, name, created_at, updated_at, repository)
    @id = id.to_i
    @name = name
    @created_at = created_at
    @updated_at = updated_at
    @repository = repository
  end

  def items
    repository.find_items(id)
  end

  def invoices
    repository.find_invoices(id)
  end

  ##successful invoices
  def successful_invoices
    invoices.select {|invoice| invoice.success?}
  end

  def unsuccessful_invoices
    # invoices.select {|invoice| invoice.failure?}
    invoices - successful_invoices
  end

  ##revenue
  def revenue(date = nil)
    revenues = merchant_invoice_items.map do |item|
      item.quantity.to_i * item.unit_price.to_i
    end
    convert_to_dollars(revenues)
  end

  def merchant_invoice_items
    successful_invoices.flat_map {|invoice| invoice.invoice_items}
  end

  def convert_to_dollars(money)
    BigDecimal.new(money.reduce(:+))/100
  end

  ##favorite_customer
  def all_customers
    successful_invoices.group_by {|invoice| invoice.customer.id}
  end

  def favorite_customer
    all_customers.max_by {|customer| customer[1].length}.last.first.customer
  end

  ##pending_invoices
  ## expected 4 got 9 ?
  def customers_with_pending_invoices
    unsuccessful_invoices.map {|invoice| invoice.customer}
  end


end
