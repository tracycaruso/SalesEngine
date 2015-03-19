require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require 'bigdecimal'

class MerchantRespoitoryTest < Minitest::Test
  def setup
    @fake_data = Parser.call("./test/support/merchants.csv")
    @sales_engine = Minitest::Mock.new
  end

  def test_it_exists
    assert MerchantRepository.new(@fake_data, @sales_engine)
  end

  def test_it_knows_its_parent
    engine = SalesEngine.new("file")
    repository = MerchantRepository.new(@fake_data, engine)
    assert_equal engine, repository.engine
  end

  def test_it_will_find_items_by_merchant_id
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_items_by_merchant_id,[3],[3])
    assert_equal [3], repository.find_items(3)
    @sales_engine.verify
  end

  def test_it_will_find_invoices_by_merchant_id
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_invoices_by_merchant_id,[3],[3])
    assert_equal [3], repository.find_invoices(3)
    @sales_engine.verify
  end

  def test_it_can_talk_to_parent_for_items
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_items_by_merchant_id, [1, 2], [1])
    assert_equal [1, 2], repository.find_items(1)
    @sales_engine.verify
  end

  def test_it_can_talk_to_parent_for_invoices
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_invoices_by_merchant_id, [1, 2], [1])
    assert_equal [1, 2], repository.find_invoices(1)
    @sales_engine.verify
  end

  def test_responds_to_all_method
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:all)
  end

  def test_returns_all_merchants
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert_equal repository.merchants, repository.all
  end

  def test_responds_to_random_method
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:random)
  end

  def test_returns_random_merchants
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    merchants = 2.times.map{repository.random}
    assert_equal merchants.length, merchants.uniq.length
  end

  def test_responds_to_find_by_id
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_id)
  end

  def test_responds_to_find_by_name
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_name)
  end

  def test_responds_to_find_by_created_at
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_created_at)
  end

  def test_responds_to_find_by_updated_at
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_updated_at)
  end

  def test_responds_to_find_all_by_id
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_id)
  end

  def test_returns_merchant_by_id
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert_instance_of Merchant, repository.find_by_id(1)
  end

  def test_it_can_find_invoice_by_id
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    merchant = repository.find_by_id(1)
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_responds_to_find_all_by_name
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_name)
  end

  def test_it_can_find_invoice_by_name
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    merchant = repository.find_by_name("Schroeder-Jerde")
    assert_equal 1, merchant.id
  end

  def test_responds_to_find_all_by_created_at
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_created_at)
  end

  def test_it_can_find_invoice_by_created_at
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    merchant = repository.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, merchant.id
  end

  def test_responds_to_find_all_by_updated_at
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_updated_at)
  end

  def test_it_can_find_invoice_by_updated_at
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    merchant = repository.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, merchant.id
  end


  def test_responds_to_find_items
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_items)
  end

  def test_responds_to_find_invoices
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_invoices)
  end

  def test_responds_to_most_revenue
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:most_revenue)
  end

  def test_responds_to_most_items
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:most_items)
  end

  def test_responds_to_revenue
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:revenue)
  end

  def test_responds_to_revenue
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:revenue)
  end

  def test_responds_to_convert_to_dollars
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:convert_to_dollars)
  end

end
