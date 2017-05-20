require 'csv'

class MappingsParser
  attr_reader :file

  def initialize(file)
    @file = file
    @mappings = nil
  end

  def mappings
    return @mappings if @mappings
    array = []
    CSV.foreach(file, headers: true) do |row|
      array << Mappings.new(row)
    end
    @mappings = array
  end
end

class Mappings
  attr_reader :sequence, :title

  def initialize(row)
    @sequence = row['sequence']
    @title = row['title']
  end
end
