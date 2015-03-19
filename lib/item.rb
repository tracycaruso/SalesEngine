require 'bigdecimal'
require 'bigdecimal/util'
class Item
  attr_reader(
    :id,
    :name,
    :description,
    :unit_price,
    :merchant_id,
    :created_at,
    :updated_at,
    :repo
  )

  def initialize(
    id,
    name,
    description,
    unit_price,
    merchant_id,
    created_at,
    updated_at,
    repo
  )
    @id          = id.to_i
    @name        = name
    @description = description
    @unit_price  = (unit_price.to_d)/100
    @merchant_id = merchant_id.to_i
    @created_at  = created_at
    @updated_at  = updated_at
    @repo        = repo
  end

  def invoice_items
    repo.find_invoice_items(id)
  end

  def merchant
    repo.find_merchant(merchant_id)
  end

  def dated_invoice_items
    invoice_items.group_by do |invoice_item|
      invoice_item.invoice.created_at.to_s
    end
  end

  #separate into parts
  def best_day
    all_invoices = {}
    dated_invoice_items.map do |date, invoice_items|
      all_invoices[date] = invoice_items.reduce(0) do |sum, items|
        sum + items.quantity
      end
    end
    parse_date(all_invoices.max_by { |date, quantity| quantity })
  end

  def parse_date(date)
    Date.parse(date[0])
  end

  def successful_invoice_items
    invoice_items.select do |invoice_item|
      invoice_item.success?
    end
  end

  def total_item_revenue
    revenues = successful_invoice_items.map do |invoice_item|
      invoice_item.revenue
    end
    revenues.reduce(:+)
  end

  def total_item_quantity
    quantities = successful_invoice_items.map do |invoice_item|
      invoice_item.quantity
    end
    quantities.reduce(:+)
  end
end
