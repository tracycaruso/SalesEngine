class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :repository

  def initialize(id, customer_id, merchant_id, status, created_at, updated_at, repository)
    @id = id.to_i
    @customer_id = customer_id.to_i
    @merchant_id = merchant_id.to_i
    @status = status
    @created_at = created_at
    @updated_at = updated_at
    @repository = repository
  end

  def transactions
    repository.find_transactions(id)
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def items
    invoice_items.map {|invoice_item| invoice_item.item}
  end

  def customer
    repository.find_customer(customer_id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def success?
   transactions.any? { |transaction| transaction.result == "success"}
  end

end
