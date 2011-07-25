FitNexus
========

This project aims to include a set of plugins and add-ons to [FitNesse](http://fitnesse.org/)
to enhance its capabilities and make it into a more full-featured testing platform. The
planned add-ons include:

- [Cukable](http://github.com/wapcaplet/cukable): [Cucumber](http://cukes.info)
  frontend for FitNesse
- [Mastiffe](http://github.com/Ken-g6/Mastiffe): Manual testing interface for FitNesse
- [Rsel](http://github.com/a-e/rsel): Ruby-based Selenium support for FitNesse

FitNexus is being developed by the [Automation Excellence](http://github.com/a-e) team, and
is still in early development.


Installation
------------

Clone this repository:

    $ git clone git://github.com/a-e/FitNexus.git
    (or, if you have edit privileges):
    $ git clone git@github.com:a-e/FitNexus.git

After cloning the repo, initialize and update the submodules to pull the latest
code from the related repositories:

    $ cd FitNexus
    $ git submodule update --init

You should see the `submodules/cukable`, `submodules/mastiffe`, and
`submodules/rsel` directories being turned into git repositories, with the
latest code pulled from the respective repositories.

If you haven't already, install [RVM](http://www.beginrescueend.com):

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
ree@fitnexus`. To do this automatically whenever you `cd` into the `FitNexus`
directory, create an `.rvmrc` file containing that command:

    $ echo "rvm ree@fitnexus" > .rvmrc

Install bundler in your global gemset:

    $ rvm ree@global
    $ gem install bundler

Then install the gem dependencies for FitNexus:

    $ rvm ree@fitnexus
    $ bundle install

Run FitNesse:

    $ ./run.sh


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

