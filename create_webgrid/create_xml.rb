require 'nokogiri'
require_relative 'parse_csv'

def create_xml(question_array)
	builder = Nokogiri::XML::Builder.new do |xml|
	  xml.gradItems {
      question_array.each do |question_set|
  	    xml.send(:"question-set", 'contentItemName' => "#{question_set.content_item_id}") {
          xml.stimulus{}
          question_set.children.each do |question|
            xml.send(:"question-set-member", 'contentItemName' => "#{question_set.content_item_id}.0#{question.question}") {
                  xml.categoryRefs {
                    xml.send(:"catRef-IELTS-QTopic", 'categoryName' => "#{question.tag}"){}
                  }
                  xml.fillInInteraction {
                    xml.fillInInput{
                      question.answers.each do |answer|
                        xml.send(:"exactAnswer", 'value' => answer){}
                      end
                    }
                  }
            }
          end
          }
      end
  	}
	end

	xml = builder.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS |
             Nokogiri::XML::Node::SaveOptions::FORMAT | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)

  File.write("./xmls/#{ARGV[0]}.xml", xml)
end

question_array = CSVParser.new(ARGV[0]).question_array

create_xml(question_array)


# p question_array[0]
# p question_array[0].children
# p question_array[0].children[0].answers
# mappings.each do |thing|
#   puts thing.children
# end
