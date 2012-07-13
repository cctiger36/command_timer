module CommandTimer
  class Runner
    def initialize(yml, options = {})
      @commands = Parser.parse(yml)
      echo_commands
      @count_down = options['count_down'] || 30
      @ntp_server = options['ntp_server']
    end

    def start
      @commands.each_with_index do |command, index|
        puts "####################"
        puts "# Next: Command#{index + 1}"
        puts "# #{command.description}" if command.description
        puts "####################"
        if command.burn_time
          if ['auto', 'Auto'].include?(command.burn_time)
            command.exec
          else
            count_down_and_burn_command(command)
          end
        else
          wait_input_to_continue(command)
        end
      end
    end

    private

    def count_down_and_burn_command(command)
      puts "Get ready to execute the next command at [#{command.burn_time}]."
      current_time = CommandTimer.ntp_time(@ntp_server)
      left_sec = command.burn_time.to_i - current_time.to_i
      if left_sec <= 0
        puts "Time over."
        return
      end
      loop do
        if left_sec >= @count_down
          current_time = CommandTimer.ntp_time(@ntp_server)
          left_sec = command.burn_time.to_i - current_time.to_i
          puts "Time resynced."
        else
          current_time += 1
          left_sec -= 1
        end
        puts "[#{current_time}] Next command will be executed at [#{command.burn_time}] (#{left_sec} seconds left)."
        if left_sec < 1
          break
        else
          if left_sec > @count_down
            sleep(left_sec - @count_down)
          else
            sleep(1)
          end
        end
      end
      command.exec
    end

    def wait_input_to_continue(command)
      loop do
        print "Input C to execute the next command or S to skip: "
        input = STDIN.gets.chomp
        if ["c", "C", "continue"].include?(input)
          command.exec
          break
        end
        if ["s", "S", "skip"].include?(input)
          puts "Command skipped."
          break
        end
      end
    end

    def echo_commands
      @commands.each_with_index do |command, index|
        puts "--------------------"
        puts "Command #{index + 1}"
        puts command.description if command.description
        if command.burn_time
          puts "Will be executed at #{command.burn_time}"
        else
          puts "Be executed by user input"
        end
        command.echo_command
        puts "Observer: #{command.observer}" if command.observer
      end
      puts "--------------------"
      puts ""
    end
  end
end
