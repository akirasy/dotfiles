#!/usr/bin/env bash

# dialog TUI
app="create-config-symlinks"

main_dialog(){
    text="Which config to deploy?"
    title="Menu"
    exec 3>&1
    stream=$(dialog --backtitle "$app" --title "$title" --no-cancel --menu "$text" 0 0 0 "1" "vim" "2" "tint2" "3" "openbox" 2>&1 1>&3)
    case $stream in
    1) vim_dialog	;;
    2) tint2_dialog	;;
    3) openbox_dialog	;;
    esac
}

vim_dialog(){
    text="Which add-ons to deploy?"
    title="Vi Improved (vim)"
    exec 3>&1
    stream=$(dialog --backtitle "$app" --title "$title" --menu "$text" 0 0 0 "1" "Vim config" "2" "indentLine" "3" "emmet-vim" 2>&1 1>&3)
    case $stream in
    1) vim_config	;;
    2) vim_indentLine	;;
    3) vim_emmet-vim	;;
    esac
}

tint2_dialog(){
    text="Which device to deploy?"
    title="Tint2"
    exec 3>&1
    stream=$(dialog --backtitle "$app" --title "$title" --no-cancel --menu "$text" 0 0 0 "1" "General use" "2" "HP-mini" "3" "Raspbian lite" 2>&1 1>&3)
    case $stream in
    1) tint2_general	;;
    2) tint2_hpmini     ;;
    3) tint2_raspbian	;;
    esac
}

openbox_dialog(){
    text="Which device to deploy?"
    title="Tint2"
    exec 3>&1
    stream=$(dialog --backtitle "$app" --title "$title" --no-cancel --menu "$text" 0 0 0 "1" "General use" "2" "HP-mini" "3" "Raspbian lite" 2>&1 1>&3)
    case $stream in
    1) openbox_general	;;
    2) openbox_hpmini   ;;
    3) openbox_raspbian	;;
    esac
}

end_dialog(){
    text="\nConfig deployed successfully!"
    title="Info Box"
    dialog --backtitle "$app" --title "$title" --infobox "$text" 7 20
}

# deploy functions
check_dialog(){
if [ ! "$(which dialog 2> /dev/null)" ]; then
    echo -e "\nPackage 'dialog' need to be installed for this shell.\n"
    exit 1
fi
}
vim_config(){
    cp -r $PWD/vim/vim $HOME/.vim
    cp -r $PWD/vim/vimrc $HOME/.vimrc
}
vim_indentLine(){
    git clone --depth 1 https://github.com/Yggdroot/indentLine.git $HOME/.vim/pack/git/start/indentLine/
}
vim_emmet-vim(){
    git clone --depth 1 https://github.com/mattn/emmet-vim.git $HOME/.vim/pack/git/start/emmet-vim/
}
tint2_general(){
    echo "not-configured"
}
tint2_hpmini(){
    mkdir -p $HOME/.config/
    cp -r $PWD/tint2/hp-mini/* $HOME/.config/tint2/
}
tint2_raspbian(){
    echo "not-configured"
}
openbox_general(){
    echo "not-configured"
}
openbox_hpmini(){
    mkdir -p $HOME/.config/
    cp -r $PWD/openbox/hp-mini/* $HOME/.config/openbox/
}
openbox_raspbian(){
    echo "not-configured"
}

# begin shell command
check_dialog
main_dialog
end_dialog
