require 'docx'
require_relative "doc_tables_to_ruby.rb"

files = Dir.entries("original_files").select {|f| f if f.include? ".docx" && "Kaplan" }.delete_if {|f| f if f.include? "~lock"}

file_location = "original_files/"

all_questions = []

def convert(filename)
  doc = Docx::Document.open(filename)
end

files.map! { |file| convert(file_location + file)}

files.each { |file| all_questions << doc_tables_to_ruby(file) }

puts all_questions.count



