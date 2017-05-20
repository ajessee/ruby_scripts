# will return an array of Ruby objects for each document

require_relative "questions.rb"

def doc_tables_to_ruby(document)

  array = []
  hash = {}
  title = document.paragraphs[0].text
  string = ""
  text_array = []
  final_array = []

  document.tables.each do |table|
    table.rows.each_with_index do |row, rindex| # Row-based iteration
      if row.cells[0].text == "Listening Stimulus"
        hash[row.cells[0].text] = row.cells[1].text.rstrip
        row.cells[1].paragraphs.each {|p| string << p.to_html }
        xml = Nokogiri::XML string
        xml.xpath("//span").each { |child| child.remove if child.children.empty? }
        xml.xpath("//span").each { |n| text_array << n.children.text }
        text_array.each_with_index  do |e, i|
          if i.even? || i == 0
           final_array << [e, text_array[i+1]]
         end
        end
        hash[:xml] = xml.to_xml
        hash[:array] = final_array
      else
        hash[row.cells[0].text] = row.cells[1].text.rstrip
      end
    end
    hash["Document Title"] = title
    array << hash
    hash = {}
    string = ""
    text_array = []
    final_array = []
    xml = nil
  end

  array.map! { |hash| Questions.new(hash)}

end
