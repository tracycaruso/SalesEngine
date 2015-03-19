require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions, :engine

  def initialize(data, engine)
    @transactions = data.map do |line|
      Transaction.new(line[:id], line[:invoice_id], line[:credit_card_number], line[:credit_card_expiration_date], line[:result], line[:created_at], line[:updated_at], self)
    end
    @engine = engine
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    @transactions
  end

  def random
    @transactions.sample
  end

  def find_by_id(search_value)
    find_by_attribute(search_value, :id)
  end

  def find_by_invoice_id(search_value)
    find_by_attribute(search_value, :invoice_id)
  end

  def find_by_credit_card_number(search_value)
    find_by_attribute(search_value, :credit_card_number)
  end

  def find_by_result(search_value)
    find_by_attribute(search_value, :result)
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

  def find_all_by_invoice_id(search_value)
    find_all_by_attribute(search_value, :invoice_id)
  end

  def find_all_by_credit_card_number(search_value)
    find_all_by_attribute(search_value, :credit_card_number)
  end

  def find_all_by_result(search_value)
    find_all_by_attribute(search_value, :result)
  end

  def find_all_by_created_at(search_value)
    find_all_by_attribute(search_value, :created_at)
  end

  def find_all_by_updated_at(search_value)
    find_all_by_attribute(search_value, :updated_at)
  end

  def find_transaction(id)
    engine.find_transaction_by_invoice_id(id)
  end

  #transaction methods
  def find_invoice(id)
    engine.find_invoice_by_id(id)
  end

  def next_id
  transactions.last.id + 1
end

def new_charge(card_info, id)
  card_info = {
    id:                     next_id,
    invoice_id:             id,
    credit_card_number:     card_info[:credit_card_number],
    credit_card_expiration: card_info[:credit_card_expiration],
    result:                 card_info[:result],
    created_at:             "#{Date.new}",
    updated_at:             "#{Date.new}"
  }

  new_transaction = Transaction.new(card_info[:id], card_info[:invoice_id], card_info[:credit_card_number], card_info[:credit_card_expiration_date], card_info[:result], card_info[:created_at], card_info[:updated_at], self)
  transactions << new_transaction
end



  private
  def find_by_attribute(search_value, attribute)
    @transactions.find{|item| item.send(attribute) == search_value}
  end

  def find_all_by_attribute(search_value, attribute)
    @transactions.find_all{|item| item.send(attribute) == search_value}
  end
end
