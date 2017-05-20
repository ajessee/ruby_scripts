require 'csv'

class CSVParser
  attr_reader :file

  def initialize(file)
    @file = file
    @tables = nil
  end

  def tables
    return @tables if @tables
    array = []
    CSV.foreach(file, headers: true) do |row|
      array << ConversionTable.new(row)
    end
    @tables = array
  end
end

class ConversionTable
  attr_reader :raw_score, :scaled_score #,:percentile

  def initialize(row)
    @raw_score = row['Raw Score']
    @scaled_score = row['Scaled Score']
    # @percentile = row['Percentile']
  end
end
