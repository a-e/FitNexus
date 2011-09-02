Gem::Specification.new do |s|
  s.name = "fitnexus"
  s.version = "0.0.1"
  s.summary = "FitNesse with benefits"
  s.description = <<-EOS
    FitNexus installs a FitNesse wiki with several enhancements, including
    Mastiffe for manual testing, Rsel for Selenium testing, and Cukable for
    Cucumber testing.
  EOS
  s.authors = ["Automation Excellence"]
  s.email = "wapcaplet88@gmail.com"
  s.homepage = "http://github.com/a-e/fitnexus"
  s.platform = Gem::Platform::RUBY

  s.files = `git ls-files`.split("\n")
  s.require_path = 'lib'

  s.executables = ['fitnexus']
end
