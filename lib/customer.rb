class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :repository

  def initialize(id, first_name, last_name, created_at, updated_at, repository)
    @id = id.to_i
    @first_name = first_name
    @last_name = last_name
    @created_at = created_at
    @updated_at = updated_at
    @repository = repository
  end

  def invoices
    repository.find_invoices(id)
  end

  def transactions
    invoices.inject([]) {|all, invoice| all + invoice.transactions}
  end

  def successful_transactions
    transactions.select {|transaction| transaction.result == "success"}
  end

  def merchants
    successful_transactions.map{|transaction| transaction.invoice.merchant}
  end

  def group_merchants
    merchants.group_by { |merchant| merchant }
  end

  def favorite_merchant
    group_merchants.max_by { |n| n[1].length }.first
  end
end