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


  def create_quantity_hash(inputs)
      @item_quantities = Hash.new(0)
      inputs[:items].each do |item|
        @item_quantities[item] += 1
      end
    end

    def create(inputs)
      data =  {
        id:           "#{invoices.last.id + 1}",
        customer_id:  inputs[:customer].id,
        merchant_id:  inputs[:merchant].id,
        status:       inputs[:status],
        created_at:   "#{Date.new}",
        updated_at:   "#{Date.new}"
          }

      new_invoice = Invoice.new(data[:id], data[:customer_id], data[:merchant_id], data[:status], data[:created_at], data[:updated_at], self)
      invoices << new_invoice
      create_quantity_hash(inputs)
      engine.create_new_items_with_invoice_id(inputs[:items], new_invoice.id, @item_quantities)
      new_invoice
    end

    def new_charge(card_info, id)
      engine.new_charge(card_info, id)
    end

  private
  def find_by_attribute(search_value, attribute)
    @invoices.find{|item| item.send(attribute) == search_value}
  end

  def find_all_by_attribute(search_value, attribute)
    @invoices.find_all{|item| item.send(attribute) == search_value}
  end
end
