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

  def test_revenue
    skip
    engine = SalesEngine.new("./support")
    engine.startup
    assert_equal BigDecimal.new("666444.52"), engine.merchant_repository.revenue(nil)
  end

  def test_most_revenue
    skip
    engine = SalesEngine.new("./support")
    engine.startup
    assert_equal "Bechtelar, Jones and Stokes", engine.merchant_repository.most_revenue(1).inspect
  end

  def test_items_sold
    engine = SalesEngine.new("./support")
    engine.startup
    assert_equal 20, engine.merchant_repository.merchants_and_items_sold.length
  end

  def test_most_items
    engine = SalesEngine.new("./support")
    engine.startup
    assert_equal "Schroeder-Jerde", engine.merchant_repository.most_items(1).first.name
  end


end
