Blog Render
===========

About
-----

This project contains the styling for the blog at <https://seankelleher.ie>.

Usage
-----

### Build environment

The build environment for the project is defined in `build.Dockerfile`. The
build environment can be replicated locally by following the setup defined in
the Dockerfile, or Docker can be used to mount the local directory in the build
environment by running the following:

    bash scripts/with_build_env.sh --dev 8080:8080 sh

This will also forward the local 8080 port to port 8080 inside the container.

### Building

The directory containing the blog content must be stored in
`target/deps/blog_content`. With that in place the blog can be built locally by
running `make`, or can be built using Docker by running the following:

    bash scripts/with_build_env.sh make

Building the project generates the static site to `target/gen/site/public`.
