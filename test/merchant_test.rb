require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

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
    assert_equal repository, merchant.repository
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

  def test_if_responds_to_successful_invoices
    merchant = Merchant.new(1, 'Schroeder-Jerde', '2012-03-27 14:53:59 UTC', '2012-03-27 14:53:59 UTC', @merchant_repository)
    assert merchant.respond_to?(:successful_invoices)
  end

end
