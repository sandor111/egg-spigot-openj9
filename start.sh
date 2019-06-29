#!/bin/ash
# Credits: https://steinborn.me/posts/tuning-minecraft-openj9/
#
# Properly tunes a Minecraft server to run efficiently under the
# OpenJ9 (https://www.eclipse.org/openj9) JVM.
#
# Licensed under the MIT license.
#

## BEGIN CONFIGURATION

# HEAP_SIZE: This is how much heap (in MB) you plan to allocate
#            to your server. By default, this is set to 4096MB,
#            or 4GB.
HEAP_SIZE=${SERVER_MEMORY}

## END CONFIGURATION -- DON'T TOUCH ANYTHING BELOW THIS LINE!

## BEGIN SCRIPT

# Compute the nursery size.
NURSERY_MINIMUM=$(($SERVER_MEMORY / 2))
NURSERY_MAXIMUM=$(($SERVER_MEMORY * 4 / 5))

# Launch the server.
CMD="java -Xms${SERVER_MEMORY}M -Xmx${SERVER_MEMORY}M -Xmns${NURSERY_MINIMUM}M -Xmnx${NURSERY_MAXIMUM}M -Xgc:concurrentScavenge -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:scvNoAdaptiveTenure -Xdisableexplicitgc -jar ${SERVER_JARFILE}"
echo "${CMD}"
${CMD}

## END SCRIPT
