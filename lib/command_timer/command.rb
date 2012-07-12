module CommandTimer
  class Command
    attr_writer :burn_time
    attr_accessor :description
    attr_accessor :content
    attr_accessor :observer

    def burn_time
      if @burn_time =~ /[0-9]{2}:[0-9]{2}:[0-9]{2}/
        CommandTimer.parse_time(@burn_time)
      else
        nil
      end
    end

    def exec
      echo_command
      system @content
      if @observer
        puts "===================="
        puts "= Start observer, input S to stop it."
        puts "= #{@observer}"
        puts "===================="
        thread = Thread.new do
          system @observer
        end
        thread.run
        input = ""
        until ["s", "S", "stop"].include?(input) do
          input = STDIN.gets.chomp
        end
        thread.kill
        puts "Observer stopped."
      end
    end

    def echo_command
      @content.split(';').each do |line|
        puts ">> #{line.strip.gsub('\\', '')}"
      end
    end
  end
end
