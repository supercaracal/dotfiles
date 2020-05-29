export HISTSIZE=10000
export EDITOR=$(which vim)
export TZ="Asia/Tokyo"
termemu="gnome-256color"

alias ll='ls -alF'

if [[ -e $HOME/.Xmodmap && -n $DISPLAY ]]; then
  xmodmap $HOME/.Xmodmap
fi

if [[ -n $(find /usr/share/terminfo -name "$termemu") ]]; then
  export TERM="$termemu"

  if [[ -d $HOME/vcs/git ]]; then
    . ~/vcs/git/contrib/completion/git-prompt.sh
    export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;35m\]$(__git_ps1)\[\033[00m\]\$ '
  else
    export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  fi
fi

if [[ $(ls /usr/lib/jvm/java-*-* 2> /dev/null) ]]; then
  export JAVA_HOME="$(ls -d /usr/lib/jvm/* | sort -d -r | head -n 1)"
fi

if [[ -d $HOME/.embulk ]]; then
  export PATH="$PATH:$HOME/.embulk/bin"
fi

if [[ -d $HOME/.jenv ]]; then
  export PATH="$PATH:$HOME/.jenv/bin"
  eval "$(jenv init -)"
fi

if [[ -d $HOME/.ndenv ]]; then
  export PATH="$PATH:$HOME/.ndenv/bin"
  eval "$(ndenv init -)"
fi

if [[ -d $HOME/.nodenv ]]; then
  export PATH="$PATH:$HOME/.nodenv/bin"
  eval "$(nodenv init -)"
fi

if [[ -d $HOME/.rbenv ]]; then
  export PATH="$PATH:$HOME/.rbenv/bin"
  eval "$(rbenv init -)"
fi

if [[ -d $HOME/.pyenv ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PATH:$PYENV_ROOT/bin"
  eval "$(pyenv init -)"
fi

if [[ -d $HOME/.tfenv ]]; then
  export PATH="$PATH:$HOME/.tfenv/bin"
fi

if [[ -d /usr/local/go ]]; then
  mkdir -p $HOME/.local/bin
  export GOPATH="$HOME/.local"
  export PATH="$PATH:/usr/local/go/bin"
fi

export PATH="$PATH:$HOME/.local/bin"

function delete_local_branches() {
  git branch | grep -v '*\|master\|HEAD' | xargs git branch -D
}

function delete_remote_merged_branches() {
  local check_only=$1
  local delete_branches=()
  for branch in $(git branch -r --merged | grep -v "*\|master\|HEAD" | sed -e "s/origin\///g" | sort | uniq); do
    delete_branches=("${delete_branches[@]}" ":${branch}")
  done
  if [ -z "$(echo ${delete_branches[@]})" ]; then
    echo 'None.'
  elif [ -z "${check_only}" ]; then
    git push origin ${delete_branches[@]}
  else
    echo ${delete_branches[@]}
  fi
}

export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
