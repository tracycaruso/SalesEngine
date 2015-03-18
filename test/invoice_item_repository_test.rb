require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'


class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @fake_data = Parser.call("./test/support/invoice_items.csv")
    @sales_engine = Minitest::Mock.new
  end

  def test_it_exists
    assert InvoiceItemRepository.new(@fake_data, @sales_engine)
  end

  def test_it_knows_its_parent
    engine = SalesEngine.new("file")
    repository = InvoiceItemRepository.new(@fake_data, engine)
    assert_equal engine, repository.engine
  end

  def test_it_will_find_invoice_by_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_invoice_by_id,[3],[3])
    assert_equal [3], repository.find_invoice(3)
    @sales_engine.verify
  end

  def test_it_will_find_item_by_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_item_by_id,[1],[3])
    assert_equal [1], repository.find_item(3)
    @sales_engine.verify
  end

  def test_responds_to_all_method
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:all)
  end

  def test_returns_all_invoice_items
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert_equal repository.invoice_items, repository.all
  end

  def test_responds_to_random_invoice_items
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:random)
  end

  def test_returns_a_random_invoice_item
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_items = 3.times.map{repository.random}
    assert_equal invoice_items.length, invoice_items.uniq.length
  end

  def test_responds_to_find_by_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_id)
  end

  def test_returns_invoice_item_by_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of InvoiceItem, repository.find_by_id(1)
  end

  def test_it_can_find_invoice_item_by_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_id(1)
    assert_equal 539, invoice_item.item_id
  end

  def test_it_can_find_invoice_item_by_a_different_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_id(199)
    assert_equal 1282, invoice_item.item_id
  end

  def test_responds_to_find_by_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_item_id)
  end

  def test_returns_invoice_item_by_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of InvoiceItem, repository.find_by_item_id(539)
  end

  def test_it_can_find_invoice_item_by_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_item_id(539)
    assert_equal 1, invoice_item.id
    assert_equal 5, invoice_item.quantity
  end

  def test_it_can_find_invoice_item_by_a_different_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_item_id(1282)
    assert_equal 199, invoice_item.id
  end


  def test_responds_to_find_by_invoice_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_invoice_id)
  end

  def test_returns_invoice_item_by_invoice_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of InvoiceItem, repository.find_by_invoice_id(1)
  end

  def test_it_can_find_invoice_item_by_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_invoice_id(1)
    assert_equal 1, invoice_item.id
  end

  def test_it_can_find_invoice_item_by_a_different_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_invoice_id(2)
    assert_equal 9, invoice_item.id
  end

  def test_responds_to_find_by_quantity
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_quantity)
  end

  def test_returns_invoice_item_by_quantity
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of InvoiceItem, repository.find_by_quantity(5)
  end

  def test_it_can_find_invoice_item_by_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_quantity(5)
    assert_equal 1, invoice_item.id
  end

  def test_it_can_find_invoice_item_by_different_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_quantity(9)
    assert_equal 2, invoice_item.id
  end

  def test_responds_to_find_by_unit_price
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_unit_price)
  end

  def test_returns_invoice_item_by_unit_price
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of InvoiceItem, repository.find_by_unit_price(13635)
  end

  def test_it_can_find_invoice_item_by_unit_price
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_unit_price(13635)
    assert_equal 1, invoice_item.id
  end

  def test_it_can_find_invoice_item_by_different_unit_price
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_unit_price(23324)
    assert_equal 2, invoice_item.id
  end

  def test_responds_to_find_by_created_at
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_created_at)
  end

  def test_returns_invoice_item_by_created_at
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of InvoiceItem, repository.find_by_created_at("2012-03-27 14:54:09 UTC")
  end

  def test_returns_invoice_item_by_created_at_date
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, invoice_item.id
  end

  def test_returns_invoice_item_by_different_created_at_date
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 16, invoice_item.id
  end

  def test_responds_to_find_by_updated_at
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_updated_at)
  end

  def test_returns_invoice_item_by_updated_at
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of InvoiceItem, repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
  end

  def test_returns_invoice_item_by_updated_at_date
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, invoice_item.id
  end

  def test_returns_invoice_item_by_a_different_updated_at_date
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    invoice_item = repository.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal 16, invoice_item.id
  end

  def test_responds_to_find_all_by_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_id)
  end

  def test_there_is_only_one_id_for_each_invoice_item
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_id(1)
    assert_equal 1, items.length
  end

  def test_responds_to_find_all_by_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_item_id)
  end

  def test_it_finds_all_items_that_match_a_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_item_id(4)
    assert_equal 2, items.length
  end

  def test_it_finds_all_items_that_match_a_different_item_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_item_id(1135)
    assert_equal 2, items.length
  end

  def test_responds_to_find_all_by_invoice_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_invoice_id)
  end

  def test_it_finds_all_items_that_match_a_invoice_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_invoice_id(1)
    assert_equal 8, items.length
  end

  def test_it_finds_all_items_that_match_a_different_invoice_id
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_invoice_id(2)
    assert_equal 4, items.length
  end

  def test_responds_to_find_all_by_quantity
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_quantity)
  end

  def test_it_finds_all_items_that_match_a_quantity
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_quantity(5)
    assert_equal 21, items.length
  end

  def test_it_finds_all_items_that_match_a_different_quantity
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_quantity(9)
    assert_equal 23, items.length
  end

  def test_responds_to_find_all_by_unit_price
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_unit_price)
  end

  def test_it_finds_all_items_that_match_a_unit_price
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_unit_price(78660)
    assert_equal 2, items.length
  end

  def test_it_finds_all_items_that_match_a_different_unit_price
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_unit_price(72018)
    assert_equal 3, items.length
  end

  def test_responds_to_all_find_by_created_at
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_created_at)
  end

  def test_it_finds_all_items_that_match_a_created_at_date
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal 15, items.length
  end

  def test_it_finds_all_items_that_match_a_different_created_at_date
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 97, items.length
  end

  def test_responds_to_all_find_by_updated_at
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_updated_at)
  end

  def test_it_finds_all_items_that_match_a_updated_at_date
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 15, items.length
  end

  def test_it_finds_all_items_that_match_a_different_updated_at_date
    repository = InvoiceItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal 97, items.length
  end

end
