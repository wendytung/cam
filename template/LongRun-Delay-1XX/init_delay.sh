#################################################################
# Script to poll Infrastructure Management for approval status
#
# Version: 2.4
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Licensed Materials - Property of IBM
#
# ©Copyright IBM Corp. 2020.
#
#################################################################

#!/bin/sh

SetParams() {
   WAIT_TIME=$1
   FILE=$2

   # Log params
   printf "Wait Time: %s\n" $WAIT_TIME
   printf "File Path: %s\n" $FILE
}

WaitUntilExpired() {
   SetParams $1 $2 
   sleep $WAIT_TIME 
   echo Done > $FILE
}

WaitUntilExpired $1 $2 

