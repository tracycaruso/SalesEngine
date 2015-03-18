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
    invoices - successful_invoices
  end

  ##revenue
  def revenue(date=nil)
    if date==nil
      revenues = merchant_invoice_items.map { |invoice_item| invoice_item.quantity.to_i * invoice_item.unit_price.to_i }
    else
      merchant_invoice_items = invoices_matching_date.flat_map { |invoice| invoice.invoice_items }
      revenues = merchant_invoice_items.map { |invoice_item| invoice_item.quantity.to_i * invoice_item.unit_price.to_i }
    end
    convert_to_dollars(revenues.reduce(:+))
  end

  def merchant_invoice_items
    successful_invoices.flat_map {|invoice| invoice.invoice_items}
  end

  def invoices_matching_date
    successful_invoices.select {|invoice| invoice.created_at.to_s == date.to_s }
  end

  def successful_invoices_by_date(date)
    return successful_invoices if date == nil
      successful_invoices.select do |invoice|
        Date.parse(invoice.created_at) == date
      end
  end

  def convert_to_dollars(money)
    BigDecimal.new(money)/100
  end

  ##favorite_customer
  def all_customers
    successful_invoices.group_by {|invoice| invoice.customer.id}
  end

  def favorite_customer
    all_customers.max_by {|customer| customer[1].length}.last.first.customer
  end

  ##customers_pending_invoices
  def customers_with_pending_invoices
    unsuccessful_invoices.map {|invoice| invoice.customer}
  end

  ##
  def number_of_items_sold
   successful_invoices.reduce(0) do |sum, invoice|
     sum + invoice.invoice_items.reduce(0) do |sum, invoice_item|
       sum + invoice_item.quantity
     end
   end
 end


end
