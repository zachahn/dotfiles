# Prompt
autoload -Uz promptinit
promptinit

PROMPT="${SSH_TTY:+"%n@%m "}%~ %F{4}❯%f "
PROMPT="${SSH_TTY:+"%F{1}%n@%m%f "}%~ %F{4}❯%f "


function precmd () {
  # Tab title
  print -Pn "\e]1;%m: %~\a"
  # Window title
  print -Pn "\e]2;%n@%m: %~\a"
}
