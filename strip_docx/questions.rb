class Questions

  attr_reader :listening_stimulus_array, :listening_stimulus_xml, :document_title, :question_id, :kaplan_qid, :passage_id, :question_type, :skillcode, :listening_stimulus, :prompt, :correct_answer, :option_1,:option_2, :option_3, :option_4

  def initialize(args = {})
    @document_title = args["Document Title"]
    @question_id = args["Question #"]
    @kaplan_qid = args["Kaplan QID"]
    @passage_id = args["Passage ID (file name)"]
    @question_type = args["Question Type"]
    @skillcode = args["SkillCode"]
    @listening_stimulus = args["Listening Stimulus"]
    @listening_stimulus_array = args[:array]
    @listening_stimulus_xml = args[:xml]
    @prompt = args["Stem / Prompt"]
    @correct_answer = args["Correct Answer"]
    @option_1 = args["Option 1"]
    @option_2 = args["Option 2"]
    @option_3 = args["Option 3"]
    @option_4 = args["Option 4"]
  end

end


