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

# Our success message handler
function success_exit {
    echo "$1" 1>&2
    exit 0
}

# Help interface
# This should show the help interface and exit the script.
function show_help {
    printf "Pass in correct argument"
    exit 1
}

#
#   If the argument to the script is 'stopall' then stop all
#   If remove, then stop and remove all
#   If the argument is 'start env', then start the docker-machine and make the 'env' the active one
#   If the argument is 'stop env', then stop the env
#
if [ -n "$1" ]
then
    if [ "$1" = 'status' ]; then
        $(docker-machine ls 1>&2) || error_exit "Could not determine status of 'docker-machine'"
         if [ "$?" = 0 ]; then
             success_exit "Finished"
         fi

    elif [ "$1" = 'stop-all' ]
    then
        printf "Trying to stop docker containers..."
        COMMAND=`docker stop $(docker ps -aq)` || error_exit "Could not stop docker containers"

         if [ "$?" = 0 ]; then
             printf "Done!"
             exit 0
         fi

    elif [ "$1" = 'remove-all' ]
    then
        printf "Trying to stop and remove docker containers..."
        COMMAND=`docker stop $(docker ps -aq)` && `docker rm $(docker ps -aq)` || error_exit "Could not terminate docker containers"

         if [ "$?" = 0 ]; then
             printf "Done!"
             exit 0
         fi

    elif [ "$1" = 'start' ]
    then
        # Check if docker is already running
        RUNNING=`pgrep docker`
        if [ "$?" = "0" ]
        then
            error_exit "Docker already running. Aborting!"
        fi

        # Check if the docker-machine environment is provided
        if [ -z "$2" ]; then
            error_exit "No environment passed"
        fi

        # Start the provided environment
        COMMAND=$(docker-machine start $2 1>&2) || error_exit "Could not start docker machine"

        # Exit if the command was successful
         if [ "$?" = 0 ]; then
             success_exit "Done!"
         fi
    elif [ "$1" = 'stop' ]
    then

        # Check docker env provided
        if [ -z "$2" ]; then
            error_exit "No environment passed"
        fi

        # Proceed to stop the environment
        COMMAND=$(docker-machine stop $2 1>&2) || error_exit "Could not stop the docker machine"

        # Check the machine statue
        MACHINE_STATUS=$( docker-machine ls | awk 'NR == 2 { print $3 }' )
        if [ $MACHINE_STATUS = 'Stopped' ]; then
            error_exit "Docker machine stopped."
        fi
    fi
else
    # Show the help screen and exit 1
    show_help
fi
