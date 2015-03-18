require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @fake_data = Parser.call("./test/support/customers.csv")
    @sales_engine = Minitest::Mock.new
  end

  def test_it_exists
    assert CustomerRepository.new(@fake_data, @sales_engine)
  end

  def test_it_knows_its_parent
    engine = SalesEngine.new("file")
    repository = CustomerRepository.new(@fake_data, engine)
    assert_equal engine, repository.engine
  end

  def test_it_will_find_invoices_by_customer_id
    repository = CustomerRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_invoices_by_customer_id,[3],[8])
    assert_equal [3], repository.find_invoices(8)
    @sales_engine.verify
  end

  def test_it_returns_all_customers
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert_equal repository.customers, repository.all
   end

   def test_it_responds_to_random_customer
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.respond_to?(:random)
   end

   def test_it_returns_a_random_customer
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     customers = 10.times.map{repository.random}
     assert customers.uniq.length > 5
   end

   def test_it_responds_to_find_by_id
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.respond_to?(:find_by_id)
   end

   def test_it_finds_customer_by_id
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert_instance_of Customer, repository.find_by_id(1)
   end

   def test_find_by_id
    repository = CustomerRepository.new(@fake_data, @sales_engine)
    assert_equal "Ondricka", repository.find_by_id(1).last_name
    end

   def test_it_responds_to_find_by_first_name
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.respond_to?(:find_by_first_name)
   end

   def test_it_finds_customer_by_first_name
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert_instance_of Customer, repository.find_by_first_name("Joey")
   end

   def test_it_responds_to_find_by_last_name
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.respond_to?(:find_by_last_name)
   end

   def test_it_finds_customer_by_last_name
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert_instance_of Customer, repository.find_by_last_name("Ondricka")
   end

   def test_it_responds_to_find_by_created_at
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.respond_to?(:find_by_created_at)
   end

   def test_it_finds_customer_by_created_at
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert_instance_of Customer, repository.find_by_created_at("2012-03-27 14:54:09 UTC")
   end

   def test_it_responds_to_find_by_updated_at
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.respond_to?(:find_by_updated_at)
   end

   def test_it_finds_customer_by_updated_at
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert_instance_of Customer, repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
   end

   def test_it_responds_to_find_all_by_id
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.respond_to?(:find_all_by_id)
   end

   def test_it_finds_all_customers_by_id
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert_instance_of Array, repository.find_all_by_id(1)
   end

   def test_it_responds_to_find_all_by_created_at
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.respond_to?(:find_all_by_created_at)
   end

   def test_it_finds_all_customers_by_created_at
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.find_all_by_created_at(:all)
   end

   def test_it_responds_to_find_all_by_updated_at
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.respond_to?(:find_all_by_updated_at)
   end

   def test_it_finds_all_customers_by_updated_at
     repository = CustomerRepository.new(@fake_data, @sales_engine)
     assert repository.find_all_by_updated_at(:all)  # What??????
   end

end
