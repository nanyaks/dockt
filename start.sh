#!/bin/bash

##################################################################
#
#   DS Docker scripts
#
#   @author Loknan S. Nanyak - @nanyaks
#   @date   Wed Aug 19 12:15:47 2015
##################################################################

# Error handling

# Our naive error handling routine
# This is used to send error signals to the user to stdout
function error_exit {
    echo "$1" 1>&2
    exit 1
}

# Help interface
# This should show the help interface and exit the script.
function show_help {
    echo "Pass in correct argument"
    exit 1
}

#
#   If the argument to the script is 'stopall' then stop all
#   If remove, then stop and remove all
#   If the argument is 'start env', then start the docker-machine and make the 'env' the active one
#   If the argument is 'stop env', then stop the env
#
#
if [ -n "$1" ]
then
    #
    error_exit "Argument passed"
else
    #
    show_help
fi



RUNNING=`pgrep docker`
if [ "$?" = "0" ]
then
    error_exit "Docker already running. Aborting!"
fi

# Test if docker machine is running
MACHINE_STATUS=$( docker-machine ls | awk 'NR == 2 { print $3 }' )
if [ $MACHINE_STATUS = 'Stopped' ]
then
    error_exit "Docker machine is not running"
fi


# echo ${#RUNNING[@]}
