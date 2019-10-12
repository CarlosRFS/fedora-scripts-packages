#!/usr/bin/env bash

systemctl stop radeon-profile-daemon.service
systemctl disable radeon-profile-daemon.service
rm /usr/bin/radeon-profile
rm /usr/bin/radeon-profile-daemon
rm /usr/share/pixmaps/radeon-profile.png
rm /usr/share/applications/radeon-profile.desktop
rm /etc/systemd/system/radeon-profile-daemon.service
