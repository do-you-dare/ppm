require "option_parser"

class Cli
  def self.parse
    action = "timelogs"
    OptionParser.parse do |parser|
      parser.banner = "Usage: ppm [subcommand] [options]"
      parser.on("timelogs", "See tracked time") do
        parser.banner = "Usage: ppm timelogs"
        action = "timelogs"
      end
      parser.on("-v", "--version", "Print version and exit") do
        action = "version"
      end
    end

    action
  end
end
