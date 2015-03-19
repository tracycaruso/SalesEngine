require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @fake_data = Parser.call("./test/support/invoices.csv")
    @sales_engine = Minitest::Mock.new
  end

  def test_it_exists
    assert InvoiceRepository.new(@fake_data, @sales_engine)
  end

  def test_it_knows_its_parent
    engine = SalesEngine.new("file")
    repository = InvoiceRepository.new(@fake_data, engine)
    assert_equal engine, repository.engine
  end

  def test_it_will_find_transactions_by_invoice_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_transactions_by_invoice_id,[3],[3])
    assert_equal [3], repository.find_transactions(3)
    @sales_engine.verify
  end

  def test_it_will_find_invoice_items_by_invoice_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_invoice_items_by_invoice_id,[3],[3])
    assert_equal [3], repository.find_invoice_items(3)
    @sales_engine.verify
  end

  def test_it_will_find_items_by_invoice_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_items_by_invoice_id,[3],[3])
    assert_equal [3], repository.find_items(3)
    @sales_engine.verify
  end

  def test_it_will_find_a_customer_by_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_customer_by_id,[3],[3])
    assert_equal [3], repository.find_customer(3)
    @sales_engine.verify
  end

  def test_it_will_find_a_merchant_by_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    @sales_engine.expect(:find_merchant_by_id,[3],[3])
    assert_equal [3], repository.find_merchant(3)
    @sales_engine.verify
  end



  def test_responds_to_all_method
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:all)
  end

  def test_returns_all_invoices
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    assert_equal repository.invoices, repository.all
  end

  def test_responds_to_random_invoice
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:random)
  end

  def test_returns_a_random_invoice
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoices = 3.times.map{repository.random}
    assert_equal invoices.length, invoices.uniq.length
  end

  def test_responds_to_find_by_id
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_by_id)
  end

  def test_returns_invoice_by_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    assert_instance_of Invoice, repository.find_by_id(1)
  end

  def test_it_can_find_invoice_by_id_using_customer_id_to_confirm
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_by_id(1)
    assert_equal 1, invoice.customer_id
  end

  def test_responds_to_find_by_customer_id
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_by_customer_id)
  end

  def test_returns_invoice_by_customer_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    assert_instance_of Invoice, repository.find_by_customer_id(1)
  end

  def test_it_can_find_first_invoice_with_matching_customer_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_by_customer_id(1)
    assert_equal 1, invoice.id
  end

  def test_it_can_find_first_invoice_with_another_matching_customer_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_by_customer_id(2)
    assert_equal 9, invoice.id
  end

  def test_responds_to_find_by_merchant_id
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_by_merchant_id)
  end

  def test_returns_invoice_by_merchant_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    assert_instance_of Invoice, repository.find_by_merchant_id(26)
  end

  def test_it_can_find_first_invoice_with_matching_merchant_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_by_merchant_id(26)
    assert_equal 1, invoice.id
  end

  def test_it_can_find_first_invoice_with_another_matching_merchant_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_by_merchant_id(33)
    assert_equal 4, invoice.id
  end

  def test_responds_to_find_by_status
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_by_status)
  end

  def test_returns_invoice_by_status
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    assert_instance_of Invoice, repository.find_by_status("shipped")
  end

  def test_it_can_find_first_invoice_with_matching_status
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_by_status("shipped")
    assert_equal 1, invoice.id
  end

  def test_responds_to_find_by_created_at
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_by_created_at)
  end

  def test_returns_invoice_by_created_at
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    assert_instance_of Invoice, repository.find_by_created_at(Date.parse("2012-03-27 07:54:12 UTC"))
  end

  def test_it_can_find_first_invoice_with_matching_created_at_date
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_by_created_at(Date.parse("2012-03-27 07:54:12 UTC"))
    assert_equal 25, invoice.id
  end

  def test_it_can_find_first_invoice_with_another_matching_created_at_date
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_by_created_at(Date.parse("2012-03-09 16:54:16 UTC"))
    assert_equal 6, invoice.id
  end

  def test_responds_to_find_by_updated_at
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_by_updated_at)
  end

  def test_returns_invoice_by_updated_at
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    assert_instance_of Invoice, repository.find_by_updated_at("2012-03-27 07:54:12 UTC")
  end

  def test_it_can_find_first_invoice_with_matching_updated_at_date
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_by_updated_at("2012-03-27 07:54:12 UTC")
    assert_equal 47, invoice.id
  end

  def test_it_can_find_first_invoice_with_another_matching_updated_at_date
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_by_updated_at("2012-03-09 16:54:16 UTC")
    assert_equal 132, invoice.id
  end

  def test_responds_to_find_all_by_id
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_all_by_id)
  end

  def test_there_is_only_one_id_for_each_invoice
    repository = TransactionRepository.new(@fake_data, @sales_engine)
    invoice = repository.find_all_by_id(1)
    assert_equal 1, invoice.length
  end

  def test_responds_to_find_all_by_customer_id
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_all_by_customer_id)
  end

  def test_returns_all_invoices_by_customer_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoices = repository.find_all_by_customer_id(1)
    assert_equal 8, invoices.length
  end

  def test_returns_all_invoices_by_different_customer_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoices = repository.find_all_by_customer_id(3)
    assert_equal 4, invoices.length
  end

  def test_responds_to_find_all_by_merchant_id
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_all_by_merchant_id)
  end

  def test_returns_all_invoices_by_merchant_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoices = repository.find_all_by_merchant_id(26)
    assert_equal 2, invoices.length
  end

  def test_returns_all_invoices_by_different_merchant_id
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoices = repository.find_all_by_merchant_id(33)
    assert_equal 2, invoices.length
  end

  def test_responds_to_find_all_by_status
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_all_by_status)
  end

  def test_returns_all_invoices_by_status
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoices = repository.find_all_by_status("shipped")
    assert_equal 200, invoices.length
  end

  def test_responds_to_find_all_by_created_at
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_all_by_created_at)
  end

  def test_returns_all_invoices_by_created_at_date
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoices = repository.find_all_by_created_at(Date.parse("2012-03-27 07:54:12 UTC"))
    assert_equal 11, invoices.length
  end

  def test_returns_all_invoices_by_different_created_at_date
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoices = repository.find_all_by_created_at(Date.parse("2012-03-09 16:54:16 UTC"))
    assert_equal 10, invoices.length
  end

  def test_responds_to_find_all_by_updated_at
    items_repo = InvoiceRepository.new(@fake_data, @sales_engine)
    assert items_repo.respond_to?(:find_all_by_updated_at)
  end

  def test_returns_all_invoices_by_updated_at_date
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoices = repository.find_all_by_updated_at("2012-03-27 07:54:12 UTC")
    assert_equal 2, invoices.length
  end

  def test_returns_all_invoices_by_different_updated_at_date
    repository = InvoiceRepository.new(@fake_data, @sales_engine)
    invoices = repository.find_all_by_updated_at("2012-03-09 16:54:16 UTC")
    assert_equal 2, invoices.length
  end
end
