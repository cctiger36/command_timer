module CommandTimer
  class Runner
    COUNT_DOWN_START_BEFORE = 30

    def start(yml_path)
      commands = Parser.parse(yml_path)
      echo_commands(commands)
      commands.each_with_index do |command|
        count_down_and_burn_command(command)
      end
    end

    def count_down_and_burn_command(command)
      puts "Get ready to execute next command at #{command.burn_time}."
      current_time = self.class.ntp_time
      left_sec = command.burn_time.to_i - current_time.to_i
      if left_sec <= 0
        puts "Time over."
        return
      end
      loop do
        if left_sec >= COUNT_DOWN_START_BEFORE
          current_time = self.class.ntp_time
          left_sec = command.burn_time.to_i - current_time.to_i
          puts "Time resynced."
        else
          current_time += 1
          left_sec -= 1
        end
        puts "[#{current_time}] Command will be executed in #{left_sec} second."
        if left_sec < 1
          break
        else
          if left_sec > COUNT_DOWN_START_BEFORE
            sleep(left_sec - COUNT_DOWN_START_BEFORE)
          else
            sleep(1)
          end
        end
      end
      command.content.each do |c|
        puts ">> #{c}"
        system c
      end
    end

    def echo_commands(commands)
      commands.each_with_index do |command, index|
        puts "--------------------"
        puts "Command #{index + 1}"
        puts command.description if command.description
        puts "Will be executed at #{command.burn_time}"
        command.content.each {|line| puts "  #{line}"}
      end
      puts "--------------------"
    end

    class << self
      def ntp_time
        parse_time(%x[ntpdate -q ntp.nict.jp].scan(/[0-9]{2}:[0-9]{2}:[0-9]{2}/).first)
      end

      def parse_time(str)
        hms = str.split(':').map(&:to_i)
        now = Time.now
        Time.new(now.year, now.month, now.day, hms[0], hms[1], hms[2])
      end
    end
  end
end
