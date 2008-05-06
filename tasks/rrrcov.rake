def is_windows?
  processor, platform, *rest = RUBY_PLATFORM.split("-")
  platform == 'mswin32'
end

namespace :test do
  desc "Run Ruby Rcov on Rails"
  task :rcov do
    code = ["unit", "functional", "integration"]
    files = code.collect{|x| Dir["./test/#{x}/*_test.rb"]}.join(" ")
    args = "-o 'coverage/all' -T -x 'gems/*,rcov*' --rails #{files}"
    cmd = (is_windows? ? 'rcov.cmd' : 'rcov') << " #{args}"
    sh(cmd, {})
    puts "View the full results at <file://coverage/all/index.html>"
  end
end

