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
  attr_reader :studyplan_id, :lesson_id, :assignment_id, :difficulty_level

  def initialize(row)
    @studyplan_id = row['StudyPlanId']
    @lesson_id = row['LessonId']
    @assignment_id = row['AssignmentId']
    @difficulty_level = row['DifficultyLevel']
  end
end
