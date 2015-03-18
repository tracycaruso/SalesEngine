require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/transaction_repository'

class TransactionTest < Minitest::Test
  def setup
    @transaction_repository = Minitest::Mock.new
    @fake_data = Parser.call("./test/support/transactions.csv")
    @sales_engine = Minitest::Mock.new
  end

  def test_it_exists
    assert Transaction.new(1, 1, 4654405418249632, nil,"success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC", @transaction_repository)
  end

  def test_it_knows_its_parent
    repository = TransactionRepository.new(@fake_data, @engine)
    customer = Transaction.new(1, 1, 4654405418249632, nil,"success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC", repository)
    assert_equal repository, customer.repository
  end

  def test_transaction_finds_matching_invoice
    transaction = Transaction.new(1, 1, 4654405418249632, nil,"success", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC", @transaction_repository)
    @transaction_repository.expect(:find_invoice, [3] , [transaction.id])
    assert_equal [3], transaction.invoice
    @transaction_repository.verify
  end

end
