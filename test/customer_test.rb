require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'

class CustomerTest < Minitest::Test
  def setup
    @customer_repository = Minitest::Mock.new
    @sales_engine = Minitest::Mock.new
    @fake_data = Parser.call("./test/support/customers.csv")
  end

  def test_it_exists
    assert Customer.new(1, "Joey", "Ondricka", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC", @customer_repository)
  end

  def test_it_knows_its_parent
    repository = CustomerRepository.new(@fake_data, @sales_engine)
    customer = Customer.new(1, "Joey", "Ondricka", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC", repository)
    assert_equal repository, customer.repo
  end

  def test_customer_finds_matching_invoices
    customer = Customer.new(1, "Joey", "Ondricka", "2012-03-27 14:54:09 UTC", "2012-03-27 14:54:09 UTC", @customer_repository)
    @customer_repository.expect(:find_invoices, [3] , [customer.id])
    assert_equal [3], customer.invoices
    @customer_repository.verify
  end
end
