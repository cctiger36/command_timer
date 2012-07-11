require "command_timer/version"
require "command_timer/command"
require "command_timer/runner"
require "command_timer/parser"

module CommandTimer
  class << self
    def ntp_time(server)
      ENV['PATH'].split(':').each do |path|
        if File.exists?(path + '/ntpdate')
          server ||= 'ntp.nict.jp'
          return parse_time(%x[ntpdate -q #{server}].scan(/[0-9]{2}:[0-9]{2}:[0-9]{2}/).first)
        end
      end
      puts "Warning: ntpdate not found and then use the local clock."
      Time.now
    end

    def parse_time(str)
      hms = str.split(':').map(&:to_i)
      now = Time.now
      Time.new(now.year, now.month, now.day, hms[0], hms[1], hms[2])
    end
  end
end
