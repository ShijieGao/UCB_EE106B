#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/cc/ee106b/sp17/class/ee106b-aau/UCB_EE106B/lab1/src/baxter_interface"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/cc/ee106b/sp17/class/ee106b-aau/UCB_EE106B/lab1/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/cc/ee106b/sp17/class/ee106b-aau/UCB_EE106B/lab1/install/lib/python2.7/dist-packages:/home/cc/ee106b/sp17/class/ee106b-aau/UCB_EE106B/lab1/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/cc/ee106b/sp17/class/ee106b-aau/UCB_EE106B/lab1/build" \
    "/usr/bin/python" \
    "/home/cc/ee106b/sp17/class/ee106b-aau/UCB_EE106B/lab1/src/baxter_interface/setup.py" \
    build --build-base "/home/cc/ee106b/sp17/class/ee106b-aau/UCB_EE106B/lab1/build/baxter_interface" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/cc/ee106b/sp17/class/ee106b-aau/UCB_EE106B/lab1/install" --install-scripts="/home/cc/ee106b/sp17/class/ee106b-aau/UCB_EE106B/lab1/install/bin"
