# Build Container
- docker build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t aosp-build-host .
# Run Container
- docker run -it --rm -v $dir_outside_container:$dir_inside_container -u $user:$group aosp-build-host


