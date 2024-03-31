require "./spec_helper"

describe ExpressionParser do
  describe "#parse" do
    it "is expected to parse text into commands" do
      input = "log 3.5 2024-03-29 hellzone 004_design_ui"
      output = { command: "log", args: ["3.5", "2024-03-29", "hellzone", "004_design_ui"] }

      ExpressionParser.parse(input).should eq(output)
    end
  end

  describe "#execute_command", tags: "watch_output_for_correctness" do
    db = InMemoryDb.new
    command = { command: "log", args: ["3.5", "2024-03-29", "execute_command", "004_make_it_work"] }

    ExpressionParser.execute_command(command, db)

    db.print_all_timelogs

    false.should eq(true)
  end
end
