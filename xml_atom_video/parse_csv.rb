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
  attr_reader :reference_name, :content_item_id, :title

  def initialize(row)
    @reference_name = row['RefID']
    @content_item_id = row['ContentItem Name']
    @title = row['Title']
  end
end
