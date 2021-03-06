require 'rip'

if Rip.dir.to_s.empty? || Rip.env.to_s.empty?
  check = `rip-check`

  if $?.success?
    check.split("\n").each do |line|
      const, value = line.split("=")

      if const == 'RIPDIR'
        Rip.dir = value
      elsif const == 'RIPENV'
        Rip.env = value
      end
    end
  else
    print check
    exit 1
  end
end

# ARGV.args vs ARGV.flags
def ARGV.flags
  select { |arg| arg =~ /^-/ }
end

def ARGV.args
  self - flags
end


require 'fileutils'
include FileUtils
include Rip::Helpers
include Rip
