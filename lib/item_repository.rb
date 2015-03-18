require_relative 'item'

class ItemRepository
  attr_reader :items, :engine

  def initialize(data, engine)
    @items = data.map do |line|
      Item.new(line[:id], line[:name], line[:description], line[:unit_price], line[:merchant_id], line[:created_at], line[:updated_at], self)
    end
    @engine = engine
  end

  def inspect
   "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @items
  end

  def random
    @items.sample
  end

  def find_by_id(search_value)
    find_by_attribute(search_value, :id)
  end

  def find_by_name(search_value)
    find_by_attribute(search_value, :name)
  end

  def find_by_description(search_value)
    find_by_attribute(search_value, :description)
  end

  def find_by_unit_price(search_value)
    find_by_attribute(search_value, :unit_price)
  end

  def find_by_merchant_id(search_value)
    find_by_attribute(search_value, :merchant_id)
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

  def find_all_by_name(search_value)
    find_all_by_attribute(search_value, :name)
  end

  def find_all_by_description(search_value)
    find_all_by_attribute(search_value, :description)
  end

  def find_all_by_unit_price(search_value)
    find_all_by_attribute(search_value, :unit_price)
  end

  def find_all_by_merchant_id(search_value)
    find_all_by_attribute(search_value, :merchant_id)
  end

  def find_all_by_created_at(search_value)
    find_all_by_attribute(search_value, :created_at)
  end

  def find_all_by_updated_at(search_value)
    find_all_by_attribute(search_value, :updated_at)
  end

  #invoice repository
  def find_invoice_items(item_id)
    engine.find_invoice_items_by_item_id(item_id)
  end

  def find_merchant(merchant_id)
    engine.find_merchant_by_id(merchant_id)
  end




  private
  def find_by_attribute(search_value, attribute)
    @items.find{|item| item.send(attribute) == search_value}
  end

  def find_all_by_attribute(search_value, attribute)
    @items.find_all{|item| item.send(attribute) == search_value}
  end
end
