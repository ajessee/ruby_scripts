require 'nokogiri'
require_relative 'parse_csv'

def create_xml(mappings)
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.root{
      mappings.each do |mapping|
        xml.sequence('template' => "#{mapping.sequence}", 'title' => "#{mapping.title}", 'timeOrder' => '1' )
    end
    }

  end
  xml = builder.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS |
             Nokogiri::XML::Node::SaveOptions::FORMAT | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)

  File.write("./xmls/#{ARGV[0]}", xml)
end

mappings = MappingsParser.new(ARGV[0]).mappings

create_xml(mappings)


