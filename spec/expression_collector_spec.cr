require "./spec_helper.cr"

describe ExpressionCollector do
  describe "#preprocess" do
    it "should process the raw output" do
      input = "project/hellzone/backlog/004_design_ui.typ:log 3.5 2024-03-29
project/backlog/hellzone/004_design_ui.typ:log 4.5 2024-03-28
project/management_scripts/todo/001_file_structure_and_time_tracking.typ:log 4.5 2024-03-28"

      expected = [
        "log 3.5 2024-03-29 hellzone 004_design_ui",
        "log 4.5 2024-03-28 hellzone 004_design_ui",
        "log 4.5 2024-03-28 management_scripts 001_file_structure_and_time_tracking"
      ]

      ExpressionCollector.preprocess(input).should eq(expected)
    end
  end
end
