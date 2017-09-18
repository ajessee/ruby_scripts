require 'csv'
require 'byebug'

class CSVParser
  attr_reader :file

  def initialize(file)
    @file = file
    @question_array = nil
  end

  def question_array
    return @question_array if @question_array
    array = []
    counter = 0
    obj = nil

    CSV.foreach(file, headers: true) do |row|
      if row["PARENT/Child"] == "PARENT" && counter == 0
        counter = 1
        obj = QuestionSetParent.new(row)
        next
      elsif row["PARENT/Child"] == "PARENT" && counter == 1
        array << obj
        obj = QuestionSetParent.new(row)
        next
      else
        obj.children << QuestionSetChild.new(row)
        next
      end
    end
    array << obj
    @question_array = array
  end
end

class QuestionSetParent
  attr_reader :content_item_id
  attr_accessor :children

  def initialize(row)
    @content_item_id = row["Question"]
    @children = []
  end
end

class QuestionSetChild
  attr_reader :question, :answers, :tag

  def initialize(row)
    @question = row['Question']
      if row['Correct Answer'] != nil
      @answers = row['Correct Answer']
      else
      @answers = ""
      end
      if row['Tag'] != nil
      @tag = row['Tag']
      else
      @tag = nil
      end 
    @answers = clean_answers(@answers)
  end

  def clean_answers(answers)
    answers.split(" or ")
  end

end
