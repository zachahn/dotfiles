autoload -Uz promptinit
promptinit

setopt prompt_subst

PROMPT='${PROMPT_STATUS}${SSH_TTY:+"%F{1}%n@%m%f "}%F{7}${PROMPT_PWD_DIRNAME}${PROMPT_PWD_SEPARATOR}%f${PROMPT_PWD_BASENAME} %F{4}❯%f '

function precmd () {
  PROMPT_STATUS='%(?..[%?] )'

  # Tab title
  print -Pn "\e]1;%m: %~\a"
  # Window title
  print -Pn "\e]2;%n@%m: %~\a"

  local pwd_ish="${PWD/#$HOME/~}"
  local pwd_dirname="$(dirname $pwd_ish)"
  local pwd_basename="$(basename $pwd_ish)"

  if [[ $pwd_dirname == $pwd_basename || $pwd_dirname == "." ]]; then
    PROMPT_PWD_DIRNAME=""
    PROMPT_PWD_SEPARATOR=""
    PROMPT_PWD_BASENAME="${pwd_basename}"
  elif [[ $pwd_dirname == "/" ]]; then
    PROMPT_PWD_DIRNAME="/"
    PROMPT_PWD_SEPARATOR=""
    PROMPT_PWD_BASENAME="${pwd_basename}"
  else
    PROMPT_PWD_DIRNAME="${pwd_dirname}";
    PROMPT_PWD_SEPARATOR="/"
    PROMPT_PWD_BASENAME="${pwd_basename}"
  fi
}
