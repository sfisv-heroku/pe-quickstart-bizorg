#!/bin/bash
# Creates a mew scratch org, initiates it, and opens it

DURATION=14

if [ "$#" -eq 1 ]; then
  DURATION=$1
fi

sfdx force:org:create -a pe-quickstart-bizorg -s -f config/project-scratch-def.json -d $DURATION
sfdx force:source:push
sfdx force:user:permset:assign -n PE_Example_Access
sfdx force:apex:execute -f scripts/setupaccess.apex
sfdx force:user:password:generate
sfdx force:org:open -p /lightning/setup/ConnectedApplication/home
echo "Org is set up"