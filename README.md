FitNexus
========

This project aims to include a set of plugins and add-ons to [FitNesse](http://fitnesse.org/)
to enhance its capabilities and make it into a more full-featured testing platform. The
add-ons include:

- [Cukable](http://github.com/wapcaplet/cukable): [Cucumber](http://cukes.info)
  frontend for FitNesse
- [Mastiffe](http://github.com/Ken-g6/Mastiffe): Manual testing interface for FitNesse
- [Rsel](http://github.com/a-e/rsel): Ruby-based Selenium support for FitNesse

FitNexus is being developed by the [Automation Excellence](http://github.com/a-e)
team, and is still in early development. So far, it has only been tested on
Linux; it might work on OSX, but it will definitely not work on Windows.


Prerequisites
-------------

Before installing FitNexus, you will need:

- [ruby](http://ruby-lang.org)
- [rubygems](http://rubygems.org)
- [git](http://git-scm.com)

All of these should be available through your usual package manager. In Ubuntu:

    $ sudo apt-get install ruby rubygems git

FitNexus will only work in a Unix-like environment. So far, it has only been
tested on Ubuntu and CentOS.


Installation
------------

FitNexus is distributed as a lightweight gem file, and consists primarily of a
Ruby script that installs and configures a new FitNesse wiki in a directory of
your choice. To install FitNexus:

    $ sudo gem install fitnexus

To create a new project in `~/my_wiki`, run:

    $ fitnexus ~/my_wiki

If all goes to plan, this will create the following files and folders in
`~/my_wiki`:

- `fitnesse.jar`: FitNesse executable
- `FitNesseRoot`: Wiki files and content
- `Gemfile`: Gem dependencies to be installed
- `mastiffe`: Symlink to Mastiffe files
- `Mastiffe`: Git clone of Mastiffe
- `plugins.properties`: FitNesse configuration
- `run.sh`: Script to start up the wiki

There's one more thing you need to do manually before FitNexus will be fully
installed, and that's to install the gem dependencies (Rsel and Cukable). This
is not handled automatically because FitNexus doesn't know whether you want to
use [RVM](http://beginrescueend.com) or not.

If you do NOT want to use RVM, you need to ensure that you have Ruby and
Rubygems installed systemwide. Then do:

    $ sudo gem install bundler
    $ cd ~/my_wiki
    $ bundle install

Then skip ahead to "Running FitNexus" below.

If you do want to use RVM, then begin by doing this:

    $ bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)

[Follow the instructions](http://www.beginrescueend.com/rvm/install/) to configure it.
When you get to the part about installing Ruby, use Ruby Enterprise Edition 1.8.7:

    $ rvm install ree

Switch to that ruby:

    $ rvm ree

Create a gemset for FitNexus:

    $ rvm gemset create fitnexus
    $ rvm ree@fitnexus

Once your gemset is created, you can switch to it at any time with `rvm
ree@fitnexus`. To do this automatically whenever you `cd` into your FitNexus
directory (i.e., `~/my_wiki`), create an `.rvmrc` file containing that command:

    $ echo "rvm ree@fitnexus" > ~/my_wiki/.rvmrc

Install bundler in your global gemset:

    $ cd ~/my_wiki
    $ rvm ree@global
    $ gem install bundler

Then install the gem dependencies for FitNexus:

    $ rvm ree@fitnexus
    $ bundle install


Running FitNexus
----------------

FitNexus is just a regular FitNesse wiki with a few enhancements. A startup
script is provided, which you can edit to meet your needs (for instance, if you
want to run on a port other than 8080). Just run this:

    $ ./run.sh

Then visit `http://localhost:8080` (or whatever hostname you're using) in your
web browser. You should get a FitNexus welcome page, with links to some
templates that will help you get started writing tests.



License
-------
The MIT License

Copyright (c) 2011 Automation Excellence

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

