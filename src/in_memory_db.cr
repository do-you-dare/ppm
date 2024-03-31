require "sqlite3"

class InMemoryDb
  @db : DB::Database

  def initialize
    @db = DB.open "sqlite3::memory:"
    db_setup
  end

  def log_spent_time(project : String, time : Float, date : String, task : String)
    @db.exec "insert into timelogs values (?, ?, ?, ?)",
             args: [project, time, date, task]
  end

  def print_all_timelogs
    puts "== All time logs"
    # TODO: understand what `rs` means in this context
    @db.query("SELECT * FROM timelogs") do |rs|
      rs.each do
        project = rs.read(String)
        time = rs.read(Float)
        date = rs.read(String)
        task = rs.read(String)
        puts "#{date} - #{project}/#{task}:	 #{time}"
      end
    end

    puts "\n== Aggregating by date"
    # TODO: string_agg should work as well as group_concat, but it
    # doesn't seem to work. I'll open an issue later reporting it.
    @db.query("SELECT group_concat(project, ', '), total(time), date FROM timelogs GROUP BY date") do |rs|
      rs.each do
        project = rs.read(String)
        time = rs.read(Float)
        date = rs.read(String)
        puts "#{date} - #{project}:	 #{time}"
      end
    end

    puts "\n== Aggregating by task"
    @db.query("SELECT max(project), total(time), task FROM timelogs GROUP BY task") do |rs|
      rs.each do
        project = rs.read(String)
        time = rs.read(Float)
        task = rs.read(String)
        puts "#{project}/#{task}:	 #{time}"
      end
    end

    puts "\n== Aggregating by project"
    @db.query("SELECT project, total(time) FROM timelogs GROUP BY project") do |rs|
      rs.each do
        project = rs.read(String)
        time = rs.read(Float)
        puts "#{project}:	 #{time}"
      end
    end
  end

  def db_setup
    @db.exec "create table timelogs (project text, time float, date text, task text)"
  end
end
