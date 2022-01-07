#!/bin/bash

echo -e "\n============================"
echo -e "  CircleCI  orb  Validate"
echo -e "============================\n"
circleci orb pack --skip-update-check src > orb.yml
circleci orb --skip-update-check validate orb.yml
echo -e "\n============================"
echo -e "         Shell check"
echo -e "============================\n"
shellcheck -e SC2148 SC2155 src/scripts/*.sh
echo -e "\n============================"
echo -e "  CircleCI config Validate"
echo -e "============================\n"
circleci config validate
