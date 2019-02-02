# platform specific stuff

UNAME=`uname`
if [ -f $HOME/.bashrc.d/$UNAME ]; then
      . $HOME/.bashrc.d/$UNAME
fi
if [ -d $HOME/.bashrc.d/$UNAME ]; then
    source_scripts $HOME/.bashrc.d/$UNAME
fi
if [ -d $HOME/.bashrc.d/$UNAME.d ]; then
    source_scripts $HOME/.bashrc.d/$UNAME.d
fi
