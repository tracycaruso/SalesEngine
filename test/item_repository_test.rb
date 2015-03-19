require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @fake_data = Parser.call("./test/support/items.csv")
    @sales_engine = Minitest::Mock.new
  end

  def test_it_exists
    assert ItemRepository.new(@fake_data, @sales_engine)
  end

  def test_it_knows_its_parent
    engine = SalesEngine.new("file")
    repository = ItemRepository.new(@fake_data, engine)
    assert_equal engine, repository.engine
  end

  def test_it_will_find_item_by_id
    repository = ItemRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_invoice_items_by_item_id,[3],[3])
    assert_equal [3], repository.find_invoice_items(3)
    @sales_engine.verify
  end

  def test_it_will_find_merchant_by_id
    repository = ItemRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_merchant_by_id,[3],[3])
    assert_equal [3], repository.find_merchant(3)
    @sales_engine.verify
  end

  def test_responds_to_all_method
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:all)
  end

  def test_returns_all_invoices
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert_equal repository.items, repository.all
  end

  def test_responds_to_random_item
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:random)
  end

  def test_returns_a_random_item
    repository = ItemRepository.new(@fake_data, @sales_engine)
    items = 3.times.map{repository.random}
    assert_equal items.length, items.uniq.length
  end

  def test_responds_to_find_by_id
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_id)
  end

  def test_returns_an_item_by_id
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of Item, repository.find_by_id(1)
  end

  def test_it_can_find_item_by_id
    repository = ItemRepository.new(@fake_data, @sales_engine)
    item = repository.find_by_id(1)
    assert_includes item.description, "Nihil autem sit odio inventore delenit"
  end

  def test_responds_to_find_by_name
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_name)
  end

  def test_returns_an_item_by_name
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of Item, repository.find_by_name("Item Qui Esse")
  end

  def test_it_can_find_item_by_name
    repository = ItemRepository.new(@fake_data, @sales_engine)
    item = repository.find_by_id(1)
    assert_includes item.name, "Item Qui Esse"
  end

  def test_responds_to_find_by_description
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_description)
  end

  def test_returns_an_item_by_description
    repository = ItemRepository.new(@fake_data, @sales_engine)
    description = "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora."
    assert_instance_of Item, repository.find_by_description(description)
  end

  def test_it_returns_first_item_matching_description
    repository = ItemRepository.new(@fake_data, @sales_engine)
    description = "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora."
    item = repository.find_by_description(description)
    assert_equal 2, item.id
  end

  def test_responds_to_find_by_unit_price
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_unit_price)
  end

  def test_returns_an_item_by_unit_price
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of Item, repository.find_by_unit_price(670.76)
  end

  def test_it_can_find_item_by_unit_price
    repository = ItemRepository.new(@fake_data, @sales_engine)
    item = repository.find_by_unit_price(670.76)
    assert_equal 2, item.id
  end

  def test_it_can_find_item_by_a_different_unit_price
    repository = ItemRepository.new(@fake_data, @sales_engine)
    item = repository.find_by_unit_price(343.55)
    assert_equal 8, item.id
  end

  def test_responds_to_find_by_created_at
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_created_at)
  end

  def test_returns_an_item_by_created_at
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of Item, repository.find_by_created_at("2012-03-27 14:53:59 UTC")
  end

  def test_returns_item_by_created_at_date
    repository = ItemRepository.new(@fake_data, @sales_engine)
    item = repository.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, item.id
  end

  def test_returns_item_by_different_created_at_date
    repository = ItemRepository.new(@fake_data, @sales_engine)
    item = repository.find_by_created_at("2012-03-27 14:54:00 UTC")
    assert_equal 171, item.id
  end

  def test_responds_to_find_by_updated_at
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_by_updated_at)
  end

  def test_returns_an_item_by_updated_at
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert_instance_of Item, repository.find_by_updated_at("2012-03-27 14:54:00 UTC")
  end

  def test_returns_item_by_updated_at_date
    repository = ItemRepository.new(@fake_data, @sales_engine)
    item = repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, item.id
  end

  def test_returns_item_by_different_updated_at_date
    repository = ItemRepository.new(@fake_data, @sales_engine)
    item = repository.find_by_updated_at("2012-03-27 14:54:00 UTC")
    assert_equal 171, item.id
  end

  def test_responds_to_find_all_by_id
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_id)
  end

  def test_there_is_only_one_id_for_each_item
    repository = ItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_id(1)
    assert_equal 1, items.length
  end

  def test_responds_to_find_all_by_name
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_name)
  end

  def test_it_can_find_multiple_items_by_name
    repository = ItemRepository.new(@fake_data, @sales_engine)
    name = "Item Qui Esse"
    items = repository.find_all_by_name(name)
    assert_equal 2, items.length
  end

  def test_responds_to_find_all_by_description
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_description)
  end

  def test_returns_all_items_by_description
    repository = ItemRepository.new(@fake_data, @sales_engine)
    description = "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora."
    items = repository.find_all_by_description(description)

    matching_descriptions = repository.all.count{|e| e.description == description}
    assert_equal matching_descriptions, items.length
  end

  def test_responds_to_find_all_by_unit_price
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_unit_price)
  end

  def test_returns_all_items_by_unit_price
    repository = ItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_unit_price(30845)

    matching_prices = repository.all.count{|e| e.unit_price == 30845}
    assert_equal matching_prices, items.length
  end

  def test_returns_all_items_by_different_unit_price
    repository = ItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_unit_price(54969)

    matching_prices = repository.all.count{|e| e.unit_price == 54969}
    assert_equal matching_prices, items.length
  end

  def test_responds_to_find_all_by_created_at
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_created_at)
  end

  def test_returns_all_items_by_created_at
    repository = ItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")

    matching_dates = repository.all.count{|e| e.created_at == "2012-03-27 14:53:59 UTC"}
    assert_equal matching_dates, items.length
  end

  def test_returns_all_items_by_different_created_at
    repository = ItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_created_at("2012-03-27 14:54:00 UTC")
    matching_dates = repository.all.count{|e| e.created_at == "2012-03-27 14:54:00 UTC"}
    assert_equal matching_dates, items.length
  end

  def test_responds_to_find_all_by_updated_at
    repository = ItemRepository.new(@fake_data, @sales_engine)
    assert repository.respond_to?(:find_all_by_updated_at)
  end

  def test_returns_all_items_by_updated_at
    repository = ItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_updated_at("2012-03-27 14:53:59 UTC")

    matching_dates = repository.all.count{|e| e.created_at == "2012-03-27 14:53:59 UTC"}
    assert_equal matching_dates, items.length
  end

  def test_returns_all_items_by_different_updated_at
    repository = ItemRepository.new(@fake_data, @sales_engine)
    items = repository.find_all_by_updated_at("2012-03-27 14:54:00 UTC")

    matching_dates = repository.all.count{|e| e.created_at == "2012-03-27 14:54:00 UTC"}
    assert_equal matching_dates, items.length
  end
  #
  # def test_responds_to_successful_invoice_items
  #   repository = ItemRepository.new(@fake_data, @sales_engine)
  #   assert repository.respond_to?(:successful_invoice_items)
  # end
  #
  # def test_successful_invoice_returns_items
  #   repository = ItemRepository.new(@fake_data, @sales_engine)
  #   assert_instance_of Array, repository.successful_invoice_items
  # end
  #
  #
  # def test_responds_to_most_revenue
  #   repository = ItemRepository.new(@fake_data, @sales_engine)
  #   assert repository.respond_to?(:most_revenue)
  # end
  #
  # def test_responds_to_revenue
  #   repository = ItemRepository.new(@fake_data, @sales_engine)
  #   assert repository.respond_to?(:revenue)
  # end


end
