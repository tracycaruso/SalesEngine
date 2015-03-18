require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices, :engine

  def initialize(data, engine)
    @invoices = data.map do |line|
      Invoice.new(line[:id], line[:customer_id], line[:merchant_id], line[:status], line[:created_at], line[:updated_at], self)
    end
    @engine = engine
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @invoices
  end

  def random
    @invoices.sample
  end

  def find_by_id(search_value)
    find_by_attribute(search_value, :id)
  end

  def find_by_customer_id(search_value)
    find_by_attribute(search_value, :customer_id)
  end

  def find_by_merchant_id(search_value)
    find_by_attribute(search_value, :merchant_id)
  end

  def find_by_status(search_value)
    find_by_attribute(search_value, :status)
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

  def find_all_by_customer_id(search_value)
    find_all_by_attribute(search_value, :customer_id)
  end

  def find_all_by_merchant_id(search_value)
    find_all_by_attribute(search_value, :merchant_id)
  end

  def find_all_by_status(search_value)
    find_all_by_attribute(search_value, :status)
  end

  def find_all_by_created_at(search_value)
    find_all_by_attribute(search_value, :created_at)
  end

  def find_all_by_updated_at(search_value)
    find_all_by_attribute(search_value, :updated_at)
  end

  #invoice methods
  def find_transactions(id)
    engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items(id)
    engine.find_invoice_items_by_invoice_id(id)
  end

  def find_customer(id)
    engine.find_customer_by_id(id)
  end

  def find_merchant(id)
    engine.find_merchant_by_id(id)
  end

  def find_items(id)
    engine.find_items_by_invoice_id(id)
  end



  # def create(input)
  #   invoice = Invoice.new(
  #     id = invoices.last.id + 1,
  #     customer_id = input[:customer].id,
  #     merchant_id = input[:merchant].id,
  #     status = input[:status],
  #     created_at = Time.now,
  #     updated_at = Time.now,
  #     self,
  #   )
  #   invoices << invoice
  #
  #   create_quantity_hash(input)
  #
  #   input[:items].each do |item|
  #     sales_engine.create_new_invoice_item(item, invoices.last.id, @hash[item])
  #   end
  #   invoice
  # end

  private
  def find_by_attribute(search_value, attribute)
    @invoices.find{|item| item.send(attribute) == search_value}
  end

  def find_all_by_attribute(search_value, attribute)
    @invoices.find_all{|item| item.send(attribute) == search_value}
  end
end
