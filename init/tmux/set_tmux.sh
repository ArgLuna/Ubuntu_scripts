#!/bin/bash
echo ">>Installing..."
apt-get install -y tmux || exit

echo ">>Copy .tmux.conf"
cp ~/Ubuntu_scripts/init/tmux/tmux.conf ~/.tmux.conf -v

echo ">>Finish!"
