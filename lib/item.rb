require 'bigdecimal'
require 'bigdecimal/util'
class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at, :repository

  def initialize(id, name, description, unit_price, merchant_id, created_at, updated_at, repository)
    @id = id.to_i
    @name = name
    @description = description
    @unit_price = (unit_price.to_d)/100
    @merchant_id = merchant_id.to_i
    @created_at = created_at
    @updated_at = updated_at
    @repository = repository
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def dated_invoice_items
    invoice_items.group_by {|invoice_item| invoice_item.invoice.created_at }
  end

  #separate into parts
  def best_day
    all_invoices = {}
    dated_invoice_items.map do |date, invoice_items|
      all_invoices[date] = invoice_items.reduce(0) {|sum, items| sum + items.quantity}
    end
    parse_date(all_invoices.max_by { |date, quantity| quantity })
  end

  def all_invoices
  end

  def parse_date(date)
    Date.parse(date[0])
  end
end
