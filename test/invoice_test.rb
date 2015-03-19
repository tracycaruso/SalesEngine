require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'

class InvoiceTest < Minitest::Test
  def setup
    @invoice_repository = Minitest::Mock.new
    @fake_data = Parser.call("./test/support/invoices.csv")
    @sales_engine = Minitest::Mock.new
  end

  def test_it_exists
    assert Invoice.new(1, 1, 26, "shipped", "2012-03-25 09:54:09", "UTC,2012-03-25 09:54:09 UTC", @invoice_repository)
  end

  def test_it_knows_its_parent
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = Invoice.new(1, 1, 26, "shipped", "2012-03-25 09:54:09", "UTC,2012-03-25 09:54:09 UTC", repository)
    assert_equal repository, invoice.repo
  end

  def test_it_has_an_id
    invoice = Invoice.new(1, 20, 30, "status", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC", "repository")
    assert_equal 1, invoice.id
  end

  def test_it_has_a_customer_id
    invoice = Invoice.new(1, 20, 30, "status", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC", "repository")
    assert_equal 20, invoice.customer_id
  end

  def test_it_has_a_merchant_id
    invoice = Invoice.new(1, 20, 30, "status", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC", "repository")
    assert_equal 30, invoice.merchant_id
  end

  def test_it_has_a_status
    invoice = Invoice.new(1, 20, 30, "status", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC", "repository")
    assert_equal "status", invoice.status
  end

  def test_it_has_a_created_at
    invoice = Invoice.new(1, 20, 30, "status", "2012-03-27 14:53:59 UTC", "2012-03-27 14:53:59 UTC", "repository")
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), invoice.created_at
  end


  def test_invoice_finds_matching_transactions
    invoice = Invoice.new(1, 1, 26, "shipped", "2012-03-25 09:54:09", "UTC,2012-03-25 09:54:09 UTC", @invoice_repository)
    @invoice_repository.expect(:find_transactions, [3] , [invoice.id])
    assert_equal [3], invoice.transactions
    @invoice_repository.verify
  end

  def test_invoice_finds_matching_invoice_items
    invoice = Invoice.new(1, 1, 26, "shipped", "2012-03-25 09:54:09", "UTC,2012-03-25 09:54:09 UTC", @invoice_repository)
    @invoice_repository.expect(:find_invoice_items, [3] , [invoice.id])
    assert_equal [3], invoice.invoice_items
    @invoice_repository.verify
  end

  def test_invoice_finds_matching_customer
    invoice = Invoice.new(1, 1, 26, "shipped", "2012-03-25 09:54:09", "UTC,2012-03-25 09:54:09 UTC", @invoice_repository)
    @invoice_repository.expect(:find_customer, [1] , [invoice.customer_id])
    assert_equal [1], invoice.customer
    @invoice_repository.verify
  end

  def test_invoice_finds_matching_merchant
    invoice = Invoice.new(1, 1, 26, "shipped", "2012-03-25 09:54:09", "UTC,2012-03-25 09:54:09 UTC", @invoice_repository)
    @invoice_repository.expect(:find_merchant, [26] , [invoice.merchant_id])
    assert_equal [26], invoice.merchant
    @invoice_repository.verify
  end





end
