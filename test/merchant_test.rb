require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require 'bigdecimal'

class MerchantTest < Minitest::Test
  def setup
    @merchant_repository = Minitest::Mock.new
    @fake_data = Parser.call("./test/support/merchants.csv")
    @sales_engine = Minitest::Mock.new
  end

  def test_it_exists
    assert Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
  end

  def test_it_knows_its_parent
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', repository)
    assert_equal repository, merchant.repo
  end

  def test_merchant_finds_matching_items
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    @merchant_repository.expect(:find_items, [3] , [merchant.id])
    assert_equal [3], merchant.items
    @merchant_repository.verify
  end

  def test_merchant_finds_matching_invoices
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    @merchant_repository.expect(:find_invoices, [3] , [merchant.id])
    assert_equal [3], merchant.invoices
    @merchant_repository.verify
  end

  def test_it_responds_to_successful_invoices
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:successful_invoices)
  end

  def test_it_responds_to_unsuccessful_invoices
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:unsuccessful_invoices)
  end

  def test_it_responds_to_revenue
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:revenue)
  end

  def test_it_responds_to_all_customers
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:all_customers)
  end

  def test_it_responds_to_favorite_customer
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:favorite_customer)
  end

  def test_it_responds_to_customers_with_pending_invoices
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:customers_with_pending_invoices)
  end

  def test_it_finds_invoices_for_merchant
    parent = Minitest::Mock.new
    merchant = Merchant.new(1, "merchant first_name", "2012-03-27 14:53:59 UTC", "2012-03-27 14:45:59 UTC", parent)
    parent.expect(:find_invoices, [1, 2], [merchant.id])
    assert_equal [1, 2], merchant.invoices
    parent.verify
  end

  def test_customer_with_pending_invoices
    sales_engine = SalesEngine.new("./support/")
    sales_engine.startup
    assert_instance_of Array, sales_engine.merchant_repository.merchants[2].customers_with_pending_invoices
  end

  def test_responds_to_revenue
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:revenue)
  end

  def test_responds_to_total_merchant_revenue
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:total_merchant_revenue)
  end

  def test_responds_to_total_merchant_items
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:total_merchant_items)
  end

  def test_responds_to_successful_invoice_items
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:successful_invoice_items)
  end

  def test_responds_to_successful_invoices
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:successful_invoices)
  end

  def test_responds_to_unsuccessful_invoices
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:unsuccessful_invoices)
  end

  def test_responds_to_all_customers
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:all_customers)
  end

  def test_responds_to_favorite_customer
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:favorite_customer)
  end

  def test_responds_to_customers_with_pending_invoices
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:customers_with_pending_invoices)
  end
end
