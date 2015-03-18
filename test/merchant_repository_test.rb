require_relative 'test_helper'
require_relative '../lib/merchant_repository'

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

  def test_if_responds_to_most_revenue
    repository = MerchantRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:most_revenue)
  end

  def test_it_returns_merchant_with_highest_revenue
  end


end
