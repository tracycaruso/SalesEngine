require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
   @engine = SalesEngine.new("./data/")
   @engine.startup
   end

   def test_it_exists
     assert SalesEngine
   end

   def test_it_has_a_customer_repo_when_started_up
     assert @engine.customer_repository
   end

   def test_it_has_an_invoice_items_repo_when_started_up
     assert @engine.invoice_item_repository
   end

   def test_it_has_an_invoice_repo_when_started_up
     assert @engine.invoice_repository
   end

   def test_it_has_an_item_repo_when_started_up
     assert @engine.item_repository
   end

   def test_it_has_a_merchant_repo_when_started_up
     assert @engine.merchant_repository
   end

   def test_it_has_a_transaction_repo_when_started_up
     assert @engine.transaction_repository
   end

end
