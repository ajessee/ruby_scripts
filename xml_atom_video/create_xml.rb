require 'nokogiri'
require_relative 'parse_csv'

def create_xml(mappings)
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.gradItems {
      mappings.each do |mapping|
        xml.send(:"question-set", 'contentItemName' => "#{mapping.content_item_id}", 'title' => "#{mapping.title}") {
          xml.stimulus {
            xml.para {
              xml.atomVideo('type' => "videojs", 'source' => "", 'referenceName' => "#{mapping.reference_name}", 'height' => "", 'width' => "", 'controls' => "show") {}
            }
          }
        }
      end
    }
  end
  xml = builder.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS |
             Nokogiri::XML::Node::SaveOptions::FORMAT | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)

  File.write("./xmls/#{ARGV[0]}.xml", xml)
end

mappings = MappingsParser.new(ARGV[0]).mappings

create_xml(mappings)
