# host specific settings

if [ -f $HOME/.bashrc.d/hostname.d/`hostname -s` ]; then
      . $HOME/.bashrc.d/hostname.d/`hostname -s`
fi                                                                              
