# Run from HOME directory

dotfiles=(.bashrc .vimrc)

autogen_begin="# AUTOGEN: begin (dotfiles/setup.sh)"
autogen_end="# AUTOGEN: end"

for dotfile in ${dotfiles[@]}; do
  if ! [ -f $dotfile ]; then
    add_dotfile=true
  else
    if [ $(grep -xc "$autogen_begin" $dotfile) -eq 0 ]; then
      echo HERE
      echo "" >> $dotfile
      add_dotfile=true
    else
      add_dotfile=false
    fi
  fi
  if [ "$add_dotfile" == true ]; then
    echo $autogen_begin >> $dotfile
    echo "if [ -f dotfiles/$dotfile ]; then" >> $dotfile
    echo "  source dotfiles/$dotfile" >> $dotfile
    echo "fi" >> $dotfile
    echo $autogen_end >> $dotfile
  fi
done
