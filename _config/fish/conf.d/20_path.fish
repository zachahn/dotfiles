if test -d $HOME/.nodenv
  set PATH $HOME/.nodenv/bin $PATH
  status --is-interactive; and source (nodenv init -|psub)
end

if test -d $HOME/.cargo/bin
  set PATH $HOME/.cargo/bin $PATH
end

if test -d $HOME/.rbenv
  if test -d $HOME/.rbenv/bin
    set PATH $HOME/.rbenv/bin $PATH
  end

  status --is-interactive; and source (rbenv init -|psub)
end

set PATH $HOME/.bin $PATH
set PATH $HOME/.bin_local $PATH
set PATH .git/safe/../../bin $PATH
