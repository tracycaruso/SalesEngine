require 'csv'

class Parser
    def self.call(file_name)
        CSV.open(file_name, {:headers => true, :header_converters => :symbol} )
    end
end
