# Show log in Rails console
if defined? Rails
  require 'logger'
  if Rails.version =~ /^2\./ # Rails 2.3
     Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
  else # Rails 3
     ActiveRecord::Base.logger = Logger.new(STDOUT) if defined? ActiveRecord
  end
end

# Enable route helpers in Rails console
if defined? Rails
  include Rails.application.routes.url_helpers
  default_url_options[:host] = 'localhost'
  default_url_options[:port] = 3000
end

# Benchmarking helper (http://ozmm.org/posts/time_in_irb.html)
if defined? Benchmark
  def benchmark(times = 1)
    ret = nil
    Benchmark.bm { |x| x.report { times.times { ret = yield } } }
    ret
  end
end

# Random time method
class Time
  def self.random(from=Time.at(0), to=Time.now)
    Time.at rand(to.to_f - from.to_f) + from.to_f
  end
end

# Instead, use AwesomePrint for them
require 'awesome_print'
AwesomePrint.irb!

puts "Custom .irbrc loaded and ready to go."
