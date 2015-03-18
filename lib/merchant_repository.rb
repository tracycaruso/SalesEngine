require_relative 'merchant'
require 'bigdecimal'
require 'bigdecimal/util'

class MerchantRepository
  attr_reader :merchants, :engine

  def initialize(data, engine)
    @merchants = data.map do |line|
      Merchant.new(line[:id], line[:name], line[:created_at], line[:updated_at], self)
    end
    @engine = engine
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @merchants
  end

  def random
    @merchants.sample
  end

  def find_by_id(search_value)
    find_by_attribute(search_value, :id)
  end

  def find_by_name(search_value)
    find_by_attribute(search_value, :name)
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

  def find_all_by_created_at(search_value)
    find_all_by_attribute(search_value, :created_at)
  end

  def find_all_by_updated_at(search_value)
    find_all_by_attribute(search_value, :updated_at)
  end


  #MERCHANT METHODS
  def find_items(id)
    engine.find_items_by_merchant_id(id)
  end

  def find_invoices(id)
    engine.find_invoices_by_merchant_id(id)
  end

  #BUSINESS LOGIC

  def most_revenue(num)
    @merchants.sort_by {|merchant| merchant.revenue}.reverse[0..num-1]
  end

  def revenue(date)
    @merchants.reduce(0) { |sum, merchant| sum + merchant.revenue(date) }
  end

  def most_items(num)
    sorted_merchants_and_items_sold = merchants_and_items_sold.sort_by do |n|
      n[1]
    end.reverse
    sorted_merchants_and_items_sold.map do |n|
      n[0]
    end[0..num-1]
  end

  def merchants_and_items_sold
    @merchants.map do |merchant|
      [ merchant, merchant.number_of_items_sold ]
    end
  end






  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  private
  def find_by_attribute(search_value, attribute)
    @merchants.find{|item| item.send(attribute) == search_value}
  end

  def find_all_by_attribute(search_value, attribute)
    @merchants.find_all{|item| item.send(attribute) == search_value}
  end
end
