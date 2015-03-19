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

    def most_revenue(x)
       merchants_sorted_by_revenue = @merchants.sort_by do |merchant|
          merchant.total_merchant_revenue
        end
       merchants_sorted_by_revenue.reverse.first(x)
     end

     def most_items(x)
       merchants_sorted_by_items = @merchants.sort_by do |merchant|
          merchant.total_merchant_items
        end
       merchants_sorted_by_items.reverse.first(x)
     end

     def revenue(date)
       successful_invoices = @merchants.flat_map do |merchant|
          merchant.successful_invoices
        end
       successful_invoices_for_date = successful_invoices.select do |invoice|
          invoice.created_at.to_s == date.to_s
        end
       successful_invoice_items = successful_invoices_for_date.flat_map do |invoice|
         invoice.invoice_items
       end
       revenues = successful_invoice_items.map do |invoice_item|
         invoice_item.revenue
       end
       BigDecimal.new(revenues.reduce(:+))/100
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
