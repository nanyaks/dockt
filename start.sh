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
    if [ "$1" = 'stop-all' ]
    then
        COMMAND=`docker stop $(docker ps -aq)` || error_exit "Could not stop docker containers"
    elif [ "$1" = 'remove-all' ]
    then
        COMMAND=`docker stop $(docker ps -aq)` && `docker rm $(docker ps -aq)` || error_exit "Could not terminate docker containers"
    elif [ "$1" = 'start' ]
    then
        echo "start"
    elif [ "$1" = 'stop' ]
    then
        COMMAND=`docker-machine stop $2` || error_exit "Could not stop the docker machine"

        # Check the machine statue
        MACHINE_STATUS=$( docker-machine ls | awk 'NR == 2 { print $3 }' )
        if [ "$?" = 0 && $MACHINE_STATUS = 'Stopped']; then
            error_exit "Docker machine stopped."
        fi
    fi
else
    # Show the help screen and exit 1
    show_help
fi




RUNNING=`pgrep docker`
if [ "$?" = "0" ]
then
    error_exit "Docker already running. Aborting!"
fi



# echo ${#RUNNING[@]}
