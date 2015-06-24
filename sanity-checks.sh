
###############################################################################
# Sanity Checks
###############################################################################
if [[ $EUID -ne 0 ]]; then
    echo "ERROR: Must be run with root privileges."
    exit 1
fi

# seriously! these checks are here for a reason. the packages from the
# reddit ppa aren't built for anything but precise (12.04) right now, so
# if you try and use this install script on another release you're gonna
# have a bad time.
source /etc/lsb-release
if [ "$DISTRIB_ID" != "Ubuntu" -o "$DISTRIB_RELEASE" != "12.04" ]; then
    echo "ERROR: Only Ubuntu 12.04 is supported."
    exit 1
fi

if [[ "2000000" -gt $(awk '/MemTotal/{print $2}' /proc/meminfo) ]]; then
    LOW_MEM_PROMPT="reddit requires at least 2GB of memory to work properly, continue anyway? [y/n] "
    read -er -n1 -p "$LOW_MEM_PROMPT" response
    if [[ "$response" != "y" ]]; then
      echo "Quitting."
      exit 1
    fi
fi

