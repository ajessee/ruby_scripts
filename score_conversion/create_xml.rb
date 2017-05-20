require 'nokogiri'
require 'byebug'
require_relative 'parse_csv'

filename = ARGV[0]
title = ARGV[1]

def create_xml(tables, filename, title)
	builder = Nokogiri::XML::Builder.new do |xml|
	  xml.scoreConversionTable('name' => "#{title}") {
	  	tables.each do |table|
	  	  xml.scoreConversionEntry('n' => "#{table.raw_score}", 'scaledScore' => "#{table.scaled_score}") #'percentile' => "#{table.percentile}"
	 	  end
	  }
	end
	xml = builder.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::FORMAT | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)

  File.write("./xmls/#{filename}.xml", xml)
end



tables = CSVParser.new(filename).tables

create_xml(tables, "#{filename}", title)
