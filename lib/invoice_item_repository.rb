require_relative 'invoice_item'

class InvoiceItemRepository
  attr_reader :invoice_items, :engine

  def initialize(data, engine)
    @invoice_items = data.map do |line|
      InvoiceItem.new(line[:id], line[:item_id], line[:invoice_id], line[:quantity], line[:unit_price], line[:created_at], line[:updated_at], self)
    end
    @engine = engine
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def all
    @invoice_items
  end

  def random
    @invoice_items.sample
  end

  def find_by_id(search_value)
    find_by_attribute(search_value, :id)
  end

  def find_by_item_id(search_value)
    find_by_attribute(search_value, :item_id)
  end

  def find_by_invoice_id(search_value)
    find_by_attribute(search_value, :invoice_id)
  end

  def find_by_quantity(search_value)
    find_by_attribute(search_value, :quantity)
  end

  def find_by_unit_price(search_value)
    find_by_attribute(search_value, :unit_price)
  end

  def find_by_created_at(search_value)
    find_by_attribute(search_value, :created_at)
  end

  def find_by_updated_at(search_value)
    find_by_attribute(search_value, :updated_at)
  end

  def find_all_by_id(search_value)
    find_all_by_attribute(search_value, :id)
  end

  def find_all_by_item_id(search_value)
    find_all_by_attribute(search_value, :item_id)
  end

  def find_all_by_invoice_id(search_value)
    find_all_by_attribute(search_value, :invoice_id)
  end

  def find_all_by_quantity(search_value)
    find_all_by_attribute(search_value, :quantity)
  end

  def find_all_by_unit_price(search_value)
    find_all_by_attribute(search_value, :unit_price)
  end

  def find_all_by_created_at(search_value)
    find_all_by_attribute(search_value, :created_at)
  end

  def find_all_by_updated_at(search_value)
    find_all_by_attribute(search_value, :updated_at)
  end

  #InvoiceItem Methods
  def find_invoice(invoice_id)
    engine.find_invoice_by_id(invoice_id)
  end

  def find_item(item_id)
    engine.find_item_by_id(item_id)
  end

  def next_id
    invoice_items.last.id + 1
  end

  def create_new_invoice_items(items, id, quantity)
    items.each do |item|
      data = {
      id:     next_id,
      item_id:  item.id,
      invoice_id: id,
      quantity: quantity[item],
      unit_price: item.unit_price,
      created_at: "#{Date.new}",
      updated_at: "#{Date.new}",
              }
      invoice_item = InvoiceItem.new(data[:id], data[:item_id], data[:invoice_id], data[:quantity], data[:unit_price], data[:created_at], data[:updated_at], self)
      @invoice_items << invoice_item
    end
  end


  private
  def find_by_attribute(search_value, attribute)
    @invoice_items.find{|item| item.send(attribute) == search_value}
  end

  def find_all_by_attribute(search_value, attribute)
    @invoice_items.find_all{|item| item.send(attribute) == search_value}
  end
end
