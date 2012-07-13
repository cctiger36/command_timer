module CommandTimer
  class Command
    attr_writer :burn_time
    attr_accessor :description
    attr_accessor :content
    attr_accessor :observer
    attr_accessor :grep

    def burn_time
      if @burn_time =~ /[0-9]{2}:[0-9]{2}:[0-9]{2}/
        CommandTimer.parse_time(@burn_time)
      else
        @burn_time
      end
    end

    def exec
      echo_command
      system @content
      if @observer
        run_observer
      end
    end

    def echo_command
      @content.split(';').each do |line|
        puts ">> #{line.strip.gsub('\\', '')}"
      end
    end

    def run_observer
      puts "===================="
      puts "= Start observer, input S to stop it."
      puts "= #{@observer}"
      puts "===================="
      observer_thread = Thread.new do
        if @grep
          run_grep
        else
          system @observer
        end
      end
      observer_thread.run
      interaction_thread = Thread.new do
        input = ""
        until ["s", "S", "stop"].include?(input) do
          input = STDIN.gets.chomp
        end
      end
      interaction_thread.run
      while observer_thread.alive? and interaction_thread.alive? do
      end
      observer_thread.kill
      interaction_thread.kill
      puts "Observer stopped."
    end

    def run_grep
      current_count = 0
      grep_str = @grep.split(",").first
      end_count = @grep.split(",").last.to_i
      IO.popen @observer do |f|
        while line = f.gets
          puts line
          current_count += 1 if line.include?(grep_str)
          break if current_count >= end_count
        end
      end
    end
  end
end
