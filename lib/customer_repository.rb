require_relative 'customer'

class CustomerRepository
  attr_reader :customers, :engine

  def initialize(data, engine)
    @customers = data.map do |line|
      Customer.new(
        line[:id],
        line[:first_name],
        line[:last_name],
        line[:created_at],
        line[:updated_at],
        self
      )
    end
    @engine = engine
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def all
    @customers
  end

  def random
    @customers.sample
  end

  def find_by_id(search_value)
    find_by_attribute(search_value, :id)
  end

  def find_by_first_name(search_value)
    find_by_attribute(search_value, :first_name)
  end

  def find_by_last_name(search_value)
    find_by_attribute(search_value, :last_name)
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

  def find_all_by_first_name(search_value)
    find_all_by_attribute(search_value, :first_name)
  end

  def find_all_by_last_name(search_value)
    find_all_by_attribute(search_value, :last_name)
  end

  def find_all_by_created_at(search_value)
    find_all_by_attribute(search_value, :created_at)
  end

  def find_all_by_updated_at(search_value)
    find_all_by_attribute(search_value, :updated_at)
  end

  #customer methods
  def find_invoices(id)
    @engine.find_invoices_by_customer_id(id)
  end


  private
  def find_by_attribute(search_value, attribute)
    @customers.find{|item| item.send(attribute) == search_value}
  end

  def find_all_by_attribute(search_value, attribute)
    @customers.find_all{|item| item.send(attribute) == search_value}
  end
end
