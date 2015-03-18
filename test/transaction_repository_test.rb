require_relative 'test_helper'
require_relative '../lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @fake_data = Parser.call("./test/support/transactions.csv")
    @sales_engine = Minitest::Mock.new
  end

  def test_it_exists
    assert TransactionRepository.new(@fake_data, @sales_engine)
  end

  def test_it_knows_its_parent
    engine = SalesEngine.new("file")
    repository = TransactionRepository.new(@fake_data, engine)
    assert_equal engine, repository.engine
  end

  def test_it_will_find_invoice_by_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_invoice_by_id,[3],[3])
    assert_equal [3], repository.find_invoice(3)
    @sales_engine.verify
  end

  def test_responds_to_all_method
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:all)
  end

  def test_returns_all_invoices
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert_equal repository.transactions, repository.all
  end

  def test_responds_to_random_item
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:random)
  end

  def test_returns_a_random_item
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = 2.times.map{repository.random}
    assert_equal transactions.length, transactions.uniq.length
  end

  def test_responds_to_find_by_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_id)
  end

  def test_returns_a_transaction_by_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert_instance_of Transaction, repository.find_by_id(1)
  end

  def test_transaction_it_can_find_transaction_by_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_id(1)
    assert_equal 1, transaction.invoice_id
  end

  def test_transaction_if_can_find_different_transaction_by_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_id(2)
    assert_equal 2, transaction.invoice_id
  end

  def test_responds_to_find_by_invoice_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_invoice_id)
  end

  def test_returns_a_transaction_by_invoice_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert_instance_of Transaction, repository.find_by_invoice_id(2)
  end

  def test_it_returns_first_transaction_that_matches_a_invoice_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_invoice_id(1)
    assert_equal 1, transaction.id
  end

  def test_it_returns_first_transaction_that_matches_a_different_invoice_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_invoice_id(2)
    assert_equal 2, transaction.id
  end

  def test_responds_to_find_by_credit_card_number
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_credit_card_number)
  end

  def test_returns_a_transaction_by_credit_card_number
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert_instance_of Transaction, repository.find_by_credit_card_number("4654405418249632")
  end

  def test_it_returns_first_transaction_that_matches_a_credit_card_number
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_credit_card_number("4580251236515201")
    assert_equal 2, transaction.id
  end

  def test_it_returns_first_transaction_that_matches_a_different_credit_card_number
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_credit_card_number("4580251236515201")
    assert_equal 2, transaction.id
  end

  def test_responds_to_find_by_result
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_result)
  end

  def test_returns_a_transaction_by_result
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert_instance_of Transaction, repository.find_by_result("success")
  end

  def test_it_returns_first_transaction_that_matches_a_result
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_result("success")
    assert_equal 1, transaction.id
  end

  def test_it_returns_first_transaction_that_matches_a_different_result
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_result("failed")
    assert_equal 11, transaction.id
  end

  def test_responds_to_find_by_created_at
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_created_at)
  end

  def test_returns_a_transaction_by_created_at
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert_instance_of Transaction, repository.find_by_created_at("2012-03-27 14:54:09 UTC")
  end

  def test_it_returns_first_transaction_that_matches_a_created_at_date
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, transaction.id
  end

  def test_it_returns_first_transaction_that_matches_a_different_created_at_date
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 3, transaction.id
  end

  def test_responds_to_find_by_updated_at
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_updated_at)
  end

  def test_returns_a_transaction_by_updated_at
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert_instance_of Transaction, repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
  end

  def test_it_returns_first_transaction_that_matches_a_updated_at_date
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, transaction.id
  end

  def test_it_returns_first_transaction_that_matches_a_different_updated_at_date
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal 3, transaction.id
  end

  def test_responds_to_all_find_by_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_id)
  end

  def test_there_is_only_one_id_for_each_transaction
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transaction = repository.find_all_by_id(1)
    assert_equal 1, transaction.length
  end

  def test_responds_to_find_all_by_invoice_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_invoice_id)
  end

  def test_it_returns_all_transactions_with_matching_invoice_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = repository.find_all_by_invoice_id(12)
    assert_equal 3, transactions.length
  end

  def test_it_returns_all_transactions_with_different_matching_invoice_id
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = repository.find_all_by_invoice_id(13)
    assert_equal 2, transactions.length
  end

  def test_responds_to_find_all_by_credit_card_number
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_credit_card_number)
  end

  def test_it_returns_all_transactions_with_a_matching_credit_card_number
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = repository.find_all_by_credit_card_number("4580251236515201")
    assert_equal 1, transactions.length
  end

  def test_it_returns_all_transactions_with_a_different_matching_credit_card_number
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = repository.find_all_by_credit_card_number("4654405418249632")
    assert_equal 1, transactions.length
  end

  def test_responds_to_find_all_by_result
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_result)

  end

  def test_it_returns_all_transactions_with_a_matching_result
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = repository.find_all_by_result("success")
    assert_equal 170, transactions.length
  end

  def test_it_returns_all_transactions_with_a_different_matching_result
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = repository.find_all_by_result("failed")
    assert_equal 30, transactions.length
  end

  def test_responds_to_find_all_by_created_at
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_created_at)
  end

  def test_it_returns_all_transactions_with_a_matching_created_at_date
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 2, transactions.length
  end

  def test_it_returns_all_transactions_with_a_matching_different_created_at_date
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 20, transactions.length
  end

  def test_responds_to_find_all_by_updated_at
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_updated_at)
  end

  def test_it_returns_all_transactions_with_a_matching_updated_at_date
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 2, transactions.length
  end

  def test_it_returns_all_transactions_with_a_matching_different_updated_at_date
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    transactions = repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal 20, transactions.length
  end

end
