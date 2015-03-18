require_relative 'csv_parser'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'

class SalesEngine
	attr_accessor :filepath
	attr_reader :customer_repository,
							:invoice_repository,
							:invoice_item_repository,
							:item_repository,
							:merchant_repository,
							:transaction_repository

	def initialize(filepath)
		@filepath = filepath
	end #optional

	def startup
		initialize_customer_repository
		initialize_invoice_repository
		initialize_invoice_item_repository
		initialize_item_repository
		initialize_merchant_repository
		initialize_transaction_repository
	end

	def initialize_customer_repository
		customer_data 				= Parser.call("#{@filepath}/customers.csv")
		@customer_repository 	= CustomerRepository.new(customer_data, self)
	end

	def initialize_invoice_item_repository
		invoice_item_data 			 = Parser.call("#{@filepath}/invoice_items.csv")
		@invoice_item_repository = InvoiceItemRepository.new(invoice_item_data, self)
	end

	def initialize_invoice_repository
		invoice_data 				= Parser.call("#{@filepath}/invoices.csv")
		@invoice_repository = InvoiceRepository.new(invoice_data, self)
	end

	def initialize_item_repository
		item_data 			 = Parser.call("#{@filepath}/items.csv")
		@item_repository = ItemRepository.new(item_data, self)
	end

	def initialize_merchant_repository
		merchant_data 			 = Parser.call("#{@filepath}/merchants.csv")
		@merchant_repository = MerchantRepository.new(merchant_data, self)
	end

	def initialize_transaction_repository
		transaction_data 				= Parser.call("#{@filepath}/transactions.csv")
		@transaction_repository = TransactionRepository.new(transaction_data, self)
	end














	def find_items_by_merchant_id(id)
		item_repository.find_all_by_merchant_id(id)
	end

	def find_invoices_by_merchant_id(id)
		invoice_repository.find_all_by_merchant_id(id)
	end

	def find_transactions_by_invoice_id(id)
		transaction_repository.find_all_by_invoice_id(id)
	end

	def find_invoice_items_by_invoice_id(id)
		invoice_item_repository.find_all_by_invoice_id(id)
	end

	#### Questionable?
	def find_items_by_invoice_id(id)
		invoice_item_repository.find_all_by_invoice_id(id)
	end

	def find_customer_by_id(id)
		customer_repository.find_by_id(id)
	end

	def find_merchant_by_id(id)
		merchant_repository.find_by_id(id)
	end

	def find_invoice_by_id(id)
		invoice_repository.find_by_id(id)
	end

	def find_item_by_id(id)
		item_repository.find_by_id(id)
	end



	def find_invoice_items_by_item_id(id)
		invoice_item_repository.find_all_by_item_id(id)
	end

	def find_invoices_by_customer_id(id)
		invoice_repository.find_all_by_customer_id(id)
	end


	#business



end