require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/item_repository'

class ItemTest < Minitest::Test
    def setup
      @item_repository = Minitest::Mock.new
      @fake_data = Parser.call("./test/support/items.csv")
      @sales_engine = Minitest::Mock.new
    end

    def test_it_exists
      assert Item.new(1, "Item", "Qui Esse,Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", 75107, 1, "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC", @item_repository)
    end

    def test_it_knows_its_parent
      repository = ItemRepository.new(@fake_data, @engine)
      item = Item.new(1, "Item", "Qui Esse,Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", 75107, 1, "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC", repository)
      assert_equal repository, item.repository
    end

    def test_item_finds_matching_invoice_item
      item = Item.new(1, "Item", "Qui Esse,Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", 75107, 1, "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC", @item_repository)
      @item_repository.expect(:find_invoice_items, [3] , [item.id])
      assert_equal [3], item.invoice_items
      @item_repository.verify
    end

    def test_item_finds_matching_merchant
      item = Item.new(1, "Item", "Qui Esse,Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", 75107, 1, "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC", @item_repository)
      @item_repository.expect(:find_merchant, [3] , [item.id])
      assert_equal [3], item.merchant
      @item_repository.verify
    end

  end
