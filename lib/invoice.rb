require'date'

class Invoice
  attr_reader(
    :id,
    :customer_id,
    :merchant_id,
    :status,
    :created_at,
    :updated_at,
    :repo
  )

  def initialize(
    id,
    customer_id,
    merchant_id,
    status,
    created_at,
    updated_at,
    repo
  )
    @id          = id.to_i
    @customer_id = customer_id.to_i
    @merchant_id = merchant_id.to_i
    @status      = status
    @created_at  = Date.parse(created_at)
    @updated_at  = updated_at
    @repo        = repo
  end

  def transactions
    repo.find_transactions(id)
  end

  def invoice_items
    repo.find_invoice_items(id)
  end

  def items
    invoice_items.map {|invoice_item| invoice_item.item}
  end

  def customer
    repo.find_customer(customer_id)
  end

  def merchant
    repo.find_merchant(merchant_id)
  end

  def success?
    transactions.any? { |transaction| transaction.result == "success"}
  end

  def charge(input)
    repo.new_charge(input, id)
  end
end
