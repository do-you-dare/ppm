require "./in_memory_db.cr"

module ExpressionParser
  def self.parse(line : String)
    tokens = line.split(" ")

    {
      command: tokens[0],
      args: tokens[1..]
    }
  end

  def self.execute_command(expression, db : InMemoryDb)
    case expression[:command]
    when "log"
      time, date, project, task = expression[:args]
      db.log_spent_time(project, time.to_f, date, task)
    else
      raise "Invalid command"
    end
  end
end
