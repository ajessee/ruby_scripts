require 'nokogiri'
require_relative 'parse_csv'

def update_xml(mapping)
  xml = File.open("./studyplans/#{mapping.studyplan_id}.xml") { |f| Nokogiri::XML(f) }
  node = xml.at_css("Assignment[Id=\"#{mapping.assignment_id}\"]")
  node['DifficultyLevel'] = "#{mapping.difficulty_level}"
  File.write("./studyplans/#{mapping.studyplan_id}.xml", xml.to_xml)
end

mappings = MappingsParser.new("mappings.csv").mappings

mappings.each {|mapping| update_xml(mapping)}
