module ExpressionCollector
  def self.collect
    self.preprocess(self.raw_collect)
  end

  def self.preprocess(raw_output : String)
    raw_output.gsub(/\/(backlog|todo|doing|done)\//, "/")
              .gsub(".typ", "")
              .gsub("project\/", "")
              .gsub("\/", " ")
              .split("\n")
              .map { |line| line.split(":").reverse.join(" ") }
              .reject { |line| line.empty? }
  end

  def self.raw_collect
    # TODO: restrict search to active projects
    # TODO: make this command (i.e, log) agnostic
    `rg '#metadata\\("(log \\d+.\\d+) (\\d{4}-\\d{2}-\\d{2})"\\)' -r '$1 $2'`
  end
end
