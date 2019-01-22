#!/bin/bash
sudo wajig dailyupgrade; sudo wajig autoclean; sudo wajig autoremove; sudo wajig purgeorphans; sudo wajig purgeremoved
