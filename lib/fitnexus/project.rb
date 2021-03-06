require 'fileutils'
require 'open3'
require 'timeout'
require 'ftools' # For File.copy

FITNESSE_VERSION = "20110104"
FITNESSE_DOWNLOAD = "http://fitnesse.org/fitnesse.jar?responder=releaseDownload\\&release=#{FITNESSE_VERSION}"

module FitNexus

  # Display a prompt with the given question. If the user answers
  # 'y' or 'Y', return true. Otherwise, return false.
  def prompt(question)
    print("#{question} [y/N]: ")
    answer = gets.strip.downcase
    if answer == 'y'
      return true
    else
      return false
    end
  end


  # Attempt to create a new directory at the given `path`. If
  # a file or directory already exists there, prompt for removal.
  def create_dir(path)
    is_file = File.file?(path)
    is_dir = File.directory?(path)

    # Check for existing file/dir, and offer to overwrite
    if is_file || is_dir
      puts "File #{path} already exists." if is_file
      puts "Directory #{path} already exists." if is_dir

      if prompt("WARNING: Existing #{path} will be deleted. Continue?")
        puts "Removing existing #{path} ..."
        FileUtils.rm_rf(path)
      else
        puts "Please use another directory."
        Process.exit
      end
    end

    puts "Creating directory #{path} ..."
    FileUtils.mkdir_p(path)
  end


  # Download a fitnesse.jar into the given path.
  def download_fitnesse(path)
    puts "Downloading fitnesse.jar version #{FITNESSE_VERSION} ..."
    Dir.chdir(path) do
      `wget --quiet #{FITNESSE_DOWNLOAD} -O fitnesse.jar`
    end
  end


  # Create the FitNesseRoot directory hierarchy in the given path,
  # by starting fitnesse.jar and waiting for it to begin producing
  # output. A bit of hack, but gets the job done.
  def create_fitnesse_root(path)
    puts "Temporarily starting FitNesse to create FitNesseRoot ..."
    Dir.chdir(path) do
      cmd = "java -jar fitnesse.jar -p 8080"
      pipe = IO.popen(cmd)

      # This will block until FitNesse starts up and writes to stdout
      line = pipe.gets

      fitnesse_started = (line =~ /Started/)
      root_dir = File.join(path, 'FitNesseRoot')
      root_created = File.directory?(root_dir)

      # If FitNesse started, kill it
      if fitnesse_started
        puts "Stopping FitNesse server ..."
        Process.kill 'HUP', pipe.pid
        if root_created
          puts "Created #{root_dir}"
        else
          puts "Error: #{root_dir} wasn't created. Quitting."
          Process.exit
        end
      # If it didn't start, display an appropriate message and/or quit
      else
        if root_created
          puts "FitNesse didn't start, but that's OK."
          puts "Created #{root_dir}"
        else
          puts "Error: #{root_dir} wasn't created. Quitting."
          Process.exit
        end
      end
    end
  end


  # Install project template onto `path`
  def install_template(path)
    puts "Installing project template to #{path} ..."
    template_dir = File.expand_path('../template', __FILE__)
    FileUtils.cp_r("#{template_dir}/.", path)
  end


  # Install Mastiffe into the given path
  def install_mastiffe(path)
    puts "Installing Mastiffe into #{path} ..."
    Dir.chdir(path) do
      `git clone git://github.com/a-e/Mastiffe.git`
      `ln -sv #{path}/Mastiffe/FitNesseRoot/files/mastiffe #{path}/FitNesseRoot/files/mastiffe`
      `ln -sv #{path}/Mastiffe/mastiffe #{path}/mastiffe`
    end
  end

  def startup_message(path)
    puts "------------------"
    puts "FitNexus installer"
    puts "------------------"
  end

  def success_message(path)
    puts "Done!"
    puts "-----"
    puts "You still need to install some gems manually; a bundler Gemfile is"
    puts "provided, so all you really need to do is:"
    puts "  $ cd #{path}"
    puts "  $ gem install bundler"
    puts "  $ bundle install"
    puts "But there are some extra steps if you want to use RVM. See the README:"
    puts "  http://github.com/a-e/FitNexus"
    puts "for more information."
    puts ""
    puts "Once all gems are installed, you can start using your new wiki:"
    puts "  $ cd #{path}"
    puts "  $ ./run.sh"
    puts "Please report any problems to http://github.com/a-e/FitNexus/issues"
    puts "Enjoy!"
  end

  # Create a FitNexus project in the given path.
  def create_project(path)
    path = File.expand_path(path)
    startup_message(path)
    create_dir(path)
    download_fitnesse(path)
    create_fitnesse_root(path)
    install_mastiffe(path)
    install_template(path)
    # TODO: Error handling
    success_message(path)
  end

end # module FitNexus


