My dotfiles
===============================================================================

```
$ sudo apt update
```

```
$ sudo apt install\
  ncurses-term\
  build-essential\
  make\
  clang\
  llvm\
  gdb\
  jq\
  tree\
  autoconf\
  automake\
  pkg-config\
  flex\
  bison\
  universal-ctags\
  xz-utils\
  linux-source\
  zlib1g-dev\
  libbz2-dev\
  libffi-dev\
  libmysqld-dev\
  libncurses5-dev\
  libncursesw5-dev\
  libpq-dev\
  libreadline-dev\
  libsqlite3-dev\
  libssl-dev\
  libc++-dev\
  libevent-dev\
  libyaml-dev\
  libelf-dev
```

* https://github.com/git/git
* https://docs.docker.com/engine/install/ubuntu/
* https://go.dev/doc/install
* https://github.com/rbenv/rbenv

```
$ gem install\
  rubocop\
  rubocop-minitest\
  rubocop-performance\
  rubocop-rake
```

```
$ crontab -l | grep -v '#'

*/5 * * * * bash ~/.local/bin/create_tags.sh
```

```
$ cat /etc/docker/daemon.json
{
  "default-address-pools": [
    { "base": "10.10.0.0/16", "size": 24 }
  ]
}
```

```
:call dein#update()
:VimProcInstall
:GoInstallBinaries
```
