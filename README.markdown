# My vim setup

This is my current vim setup, uploaded to github to make sharing settings
between my computers easier, as well as tracking changes.  Occasionally people
have asked me to email them copies of my .vimrc as well, so now they don't have
to.

## Caveat

This is all very much a "work in progress".  I have had a .vimrc that I've
emailed to myself many times over the last few years as I migrate from machine
to machine.  Gradually as time has passed it's become more and more messy and
unwieldy, as well as requiring more and more plugins to work.  By putting the
plugins up here (as git submodules where those plugins are stored in git;
otherwise just adding the current version as downloaded from vim.org), I
alleviate some of that.

When setting this up, I decided to start from a fresh slate and pull in
functionality from my old setup as needed.  Thus there may be things I've
forgotten.

## Pre-requisites

This vim setup makes use of the
[Command-T](https://github.com/wincent/Command-T) plugin, which requires Ruby.
I also found that the vim-nox package in Ubuntu is compiled against a different
version of Ruby to that included in Ubuntu's ruby package.  This caused some
bugs which I resolved by compiling vim myself against the ruby package I had
installed.  Please read the Command-T documentation for more information.

Please note that this is only a problem if you intend to use the Command-T
plugin.  There are no adverse affects from simply having it installed.  Other
than that, this vim setup should be perfectly suitable for most pre-packaged vim
distributions.

## Included plugins

As of the time of writing the plugins I've installed are:
 
* [Pathogen](https://github.com/tpope/vim-pathogen)
* [Command-T](https://github.com/wincent/Command-T)
* [NERDTree](http://github.com/scrooloose/nerdtree)
* [Fugitive](http://github.com/tpope/vim-fugitive)
* [a.vim](http://www.vim.org/scripts/script.php?script_id=31)
* [YankRing](http://www.vim.org/scripts/script.php?script_id=1234)
* [OmniCPPComplete](http://www.vim.org/scripts/script.php?script_id=1520)

## Installation

Installation is quite simple.  The following will backup your existing vim files
and get mine from github:

```shell
for i in ~/.vim ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done
git clone --recursive git://github.com/dpwright/.vim.git 
```

All files in this vim setup are contained within the hidden .vim subdirectory.
You'll need to create a symlink to the vimrc file so that it gets read, like so:

```shell
ln -s ~/.vim/vimrc ~/.vimrc
```

That should be all that's required!

## Acknowledgements

I based my vim distribution on [Steve
Francia's](https://github.com/spf13/spf13-vim) a little bit.  In particular I
copied the installation script above from him.  I haven't actually tried his vim
setup out, but it looks good, so if you don't like mine give his a go!
