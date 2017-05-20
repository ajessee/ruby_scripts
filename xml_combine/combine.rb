require 'nokogiri'
require 'pry-byebug'

dir = Dir.open("./XMLS")
path = File.expand_path("./XMLS")
path2 = File.expand_path("./XMLS/NEW")
files = dir.select {|f| f if f.include? ".xml"}

files.each do |file|
  puts "Opening and combining file: " + file
  doc = File.open(path + "/" + file) {|f| Nokogiri::XML(f)}
  new_doc = doc.xpath("//gradItems").children
  new_doc = new_doc.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS |
             Nokogiri::XML::Node::SaveOptions::FORMAT | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)
  File.write("./XMLS/NEW/#{file}", new_doc)
end

new_dir = Dir.open("./XMLS/NEW")
new_files = new_dir.select {|f| f if f.include? ".xml"}

File.open("merge.xml", "w") {|f| f.puts new_files.map {|file| IO.read path2 + "/" + file}}

files.each do |file|
  puts "Deleting original file: " + file
  File.delete(path + "/" + file)
end

new_files.each do |file|
  puts "Deleting temporary file: " + file
  File.delete(path2 + "/" + file)
end

