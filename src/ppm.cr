require "./cli.cr"
require "./in_memory_db.cr"
require "./expression_collector.cr"
require "./expression_parser.cr"

module Ppm
  VERSION = "0.1.0"

  def self.main
    action = Cli.parse

    case action
    when "version"
      puts "ppm version #{VERSION}"
    when "timelogs"
      db = InMemoryDb.new
      expressions = ExpressionCollector.collect
      commands = expressions.map { |ex| ExpressionParser.parse(ex) }
      commands.each { |command| ExpressionParser.execute_command(command, db) }

      db.print_all_timelogs
    end
  end
end

Ppm.main
