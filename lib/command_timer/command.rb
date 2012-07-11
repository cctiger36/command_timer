module CommandTimer
  class Command
    attr_accessor :description
    attr_accessor :content
    attr_writer :burn_time

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
    end

    def echo_command
      @content.split(';').each do |line|
        puts ">> #{line.strip.gsub('\\', '')}"
      end
    end
  end
end
