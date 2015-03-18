require 'simplecov'            # These two lines must go first
SimpleCov.start

require 'minitest/test'
require 'minitest/autorun'     # Sets up minitest
require 'minitest/pride'                               # You could require other shared gems here, too
require_relative '../lib/csv_parser'
require_relative '../lib/sales_engine'
