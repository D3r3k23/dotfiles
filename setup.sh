dotfiles=(.bashrc .vimrc .inputrc)

autogen_begin="# AUTOGEN: begin (dotfiles/setup.sh)"
autogen_end="# AUTOGEN: end"

for dotfile in ${dotfiles[@]}; do
  if ! [ -f $dotfile ]; then # if dotfile does not exist
    echo "creating new dotfile: $dotfile"
    add_dotfile=true
  else # if dotfile exists
    if [ $(grep -xc "$autogen_begin" $dotfile) -eq 0 ]; then # if autogen not present
      echo "adding to existing dotfile: $dotfile"
      echo "" >> $dotfile
      add_dotfile=true
    else # if autogen already present
      echo "dotfile already set up: $dotfile"
      add_dotfile=false
    fi
  fi
  if [ "$add_dotfile" == true ]; then
    echo $autogen_begin                      >> $dotfile
    echo "if [ -f dotfiles/$dotfile ]; then" >> $dotfile
    echo "  source dotfiles/$dotfile"        >> $dotfile
    echo "fi"                                >> $dotfile
    echo $autogen_end                        >> $dotfile
  fi
done
