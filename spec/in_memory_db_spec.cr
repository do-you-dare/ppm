require "./spec_helper"

describe InMemoryDb do
  # TODO: Write tests

  it "works" do
    db = InMemoryDb.new
    db.log_spent_time("project", 4.5, "2024-03-20", "Start project")
    db.log_spent_time("project", 1.5, "2024-03-21", "Start project")
    db.log_spent_time("project", 1.0, "2024-03-22", "End project")

    db.print_all_timelogs

    true.should eq(true)
  end
end
