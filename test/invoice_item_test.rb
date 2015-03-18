require_relative 'test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice_item_repository'

class InvoiceItemTest < Minitest::Test
  def setup
    @invoice_item_repository = Minitest::Mock.new
    @fake_data = Parser.call("./test/support/invoice_items.csv")
    @sales_engine = Minitest::Mock.new
  end

  def test_it_exists
    assert InvoiceItem.new(1, 539, 1, 5, 13635, "2012-03-27 14:54:09", "UTC,2012-03-27 14:54:09 UTC", @invoice_item_repository)
  end

  def test_it_knows_its_parent
    repository = InvoiceItemRepository.new(@fake_data, @engine)
    customer = InvoiceItem.new(1, 539, 1, 5, 13635, "2012-03-27 14:54:09", "UTC,2012-03-27 14:54:09 UTC", repository)
    assert_equal repository, customer.repository
  end

  def test_invoice_item_finds_matching_invoice
    invoice_item = InvoiceItem.new(1, 539, 1, 5, 13635, "2012-03-27 14:54:09", "UTC,2012-03-27 14:54:09 UTC", @invoice_item_repository)
    @invoice_item_repository.expect(:find_invoice, [1] , [invoice_item.invoice_id])
    assert_equal [1], invoice_item.invoice
    @invoice_item_repository.verify
  end

  def test_invoice_item_finds_matching_item
    invoice_item = InvoiceItem.new(1, 539, 1, 5, 13635, "2012-03-27 14:54:09", "UTC,2012-03-27 14:54:09 UTC", @invoice_item_repository)
    @invoice_item_repository.expect(:find_item, [539] , [invoice_item.item_id])
    assert_equal [539], invoice_item.item
    @invoice_item_repository.verify
  end
end
