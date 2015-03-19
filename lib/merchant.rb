require_relative 'csv_parser'
require_relative 'merchant_repository'
require_relative 'sales_engine'
require 'bigdecimal'
require 'bigdecimal/util'

class Merchant
  attr_reader :id, :name, :created_at, :updated_at, :repo

  def initialize(id, name, created_at, updated_at, repo)
    @id         = id.to_i
    @name       = name
    @created_at = created_at
    @updated_at = updated_at
    @repo       = repo
  end

  def items
    repo.find_items(id)
  end

  def invoices
    repo.find_invoices(id)
  end


  #revenue
  def revenue(date=nil)
    if date==nil
      merchant_invoice_items = successful_invoices.flat_map do |invoice|
        invoice.invoice_items
      end
    else
      given_date_invoices = successful_invoices.select do |invoice|
        invoice.created_at.to_s == date.to_s
      end
      merchant_invoice_items = given_date_invoices.flat_map do |invoice|
        invoice.invoice_items
      end
    end
    revenues = merchant_invoice_items.map do |invoice_item|
      invoice_item.revenue
    end
    BigDecimal.new(revenues.reduce(:+))/100
  end


  def total_merchant_revenue
    revenues = successful_invoice_items.map do |invoice_item|
      invoice_item.revenue
    end
    revenues.reduce(:+)
   end

  def total_merchant_items
    quantities = successful_invoice_items.map do |invoice_item|
      invoice_item.quantity
    end
    quantities.reduce(:+)
  end

  def successful_invoice_items
    successful_invoices.flat_map { |invoice| invoice.invoice_items }
  end

  def successful_invoices
    invoices.select { |invoice| invoice.success? }
  end

  def unsuccessful_invoices
    invoices - successful_invoices
  end

  def all_customers
    successful_invoices.group_by {|invoice| invoice.customer.id}
  end

  def favorite_customer
    all_customers.max_by {|customer| customer[1].length}.last.first.customer
  end

  def customers_with_pending_invoices
    unsuccessful_invoices.map {|invoice| invoice.customer}
  end

  def number_of_items_sold
   successful_invoices.reduce(0) do |sum, invoice|
     sum + invoice.invoice_items.reduce(0) do |sum, invoice_item|
       sum + invoice_item.quantity
     end
   end
 end
end
