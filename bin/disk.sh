#! /usr/bin/bash
df | grep /dev/mapper/cryptroot | awk '{print $5}'