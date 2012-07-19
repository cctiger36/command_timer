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
      puts "= Start observer, press <Ctrl-C> to stop it."
      puts "= #{@observer}"
      puts "===================="
      IO.popen @observer do |pipe|
      end
      puts "Observer stopped."
    end
  end
end
