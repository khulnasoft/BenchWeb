# Welcome to [KhulnaSoft Framework Benchmarks (BW)](http://www.khulnasoft.com/benchmarks/)

[![Build Status](https://github.com/KhulnaSoft/BenchWeb/workflows/build/badge.svg?branch=master&event=push)](https://github.com/KhulnaSoft/BenchWeb/actions?query=workflow%3Abuild+branch%3Amaster)

If you're new to the project, welcome! Please feel free to ask questions [here](https://github.com/KhulnaSoft/BenchWeb/issues/2978). We encourage new frameworks and contributors to ask questions. We're here to help!

This project provides representative performance measures across a wide field of web application frameworks. With much help from the community, coverage is quite broad and we are happy to broaden it further with contributions. The project presently includes frameworks on many languages including `Go`, `Python`, `Java`, `Ruby`, `PHP`, `C#`, `F#`,`Clojure`, `Groovy`, `Dart`, `JavaScript`, `Erlang`, `Haskell`, `Scala`, `Perl`, `Lua`, `C`, and others.  The current tests exercise plaintext responses, JSON serialization, database reads and writes via the object-relational mapper (ORM), collections, sorting, server-side templates, and XSS counter-measures. Future tests will exercise other components and greater computation.

[Read more and see the results of our tests on cloud and physical hardware](http://www.khulnasoft.com/benchmarks/). For descriptions of the test types that we run, see the 
[test requirements section](https://github.com/KhulnaSoft/BenchWeb/wiki/Project-Information-Framework-Tests-Overview).

If you find yourself in a directory or file that you're not sure what the purpose is, checkout our [file structure](https://github.com/KhulnaSoft/BenchWeb/wiki/Codebase-File-Structure) in our documentation, which will briefly explain the use of relevant directories and files.

## Quick Start Guide

To get started developing you'll need to install [docker](https://docs.docker.com/install/) or see our [Quick Start Guide using vagrant](#quick-start-guide-vagrant)

1. Clone BW.

        $ git clone https://github.com/KhulnaSoft/BenchWeb.git

2. Change directories

        $ cd BenchWeb

3. Run a test.

        $ ./bw --mode verify --test gemini

### Explanation of the `./bw` script

The run script is pretty wordy, but each and every flag is required. If you are using windows, either adapt the docker command at the end of the `./bw` shell script (replacing `${SCRIPT_ROOT}` with `/c/path/to/BenchWeb`), or use vagrant.

The command looks like this: `docker run -it --rm --network bw -v /var/run/docker.sock:/var/run/docker.sock -v [FWROOT]:/BenchWeb khulnasoft/bw [ARGS]`

- `-it` tells docker to run this in 'interactive' mode and simulate a TTY, so that `ctrl+c` is propagated.
- `--rm` tells docker to remove the container as soon as the benchmarks finishes running, meaning there aren't hundreds of stopped containers lying around.
- `--network=bw` tells the container to join the 'bw' Docker virtual network
- The first `-v` specifies which Docker socket path to mount as a volume in the running container. This allows docker commands run inside this container to use the host container's docker to create/run/stop/remove containers.
- The second `-v` mounts the BenchWeb source directory as a volume to share with the container so that rebuilding the benchmarks image is unnecessary and any changes you make on the host system are available in the running benchmarks container.
- `khulnasoft/bw` is the name of benchmarks container to run

#### A note on Windows

- Docker expects Linux-style paths. If you cloned on your `C:\` drive, then `[ABS PATH TO THIS DIR]` would be `/c/BenchWeb`.
- [Docker for Windows](https://www.docker.com/docker-windows) understands `/var/run/docker.sock` even though that is not a valid path on Windows, but only when using Linux containers (it doesn't work with Windows containers and LCOW). [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/) **may** not understand `/var/run/docker.sock`, even when using Linux containers - use at your own risk.

## Quick Start Guide (Vagrant)

Get started developing quickly by utilizing vagrant with BW. [Git](https://git-scm.com),
[Virtualbox](https://www.virtualbox.org/) and [vagrant](https://www.vagrantup.com/) are
required.

1. Clone BW.

        $ git clone https://github.com/KhulnaSoft/BenchWeb.git

2. Change directories

        $ cd BenchWeb/infrastructure/vagrant

3. Build the vagrant virtual machine

        $ vagrant up

4. Run a test

        $ vagrant ssh
        $ bw --mode verify --test gemini

## Add a New Test

Either on your computer, or once you open an SSH connection to your vagrant box, start the new test initialization wizard.

        vagrant@BW-all:~/BenchWeb$ ./bw --new

This will walk you through the entire process of creating a new test to include in the suite.

## Resources

### Official Documentation

Our official documentation can be found in the [wiki](https://github.com/KhulnaSoft/BenchWeb/wiki). 
If you find any errors or areas for improvement within the docs, feel free to open an issue in this repo.

### Live Results

Results of continuous benchmarking runs are available in real time [here](https://bw-status.khulnasoft.com/).

### Data Visualization

If you have a `results.json` file that you would like to visualize, you can [do that here](https://bw-status.khulnasoft.com/share). You can also attach a `runid` parameter to that url where `runid` is a run listed on [bw-status](https://bw-status.khulnasoft.com) like so: https://www.khulnasoft.com/benchmarks/#section=test&runid=fd07b64e-47ce-411e-8b9b-b13368e988c6.
If you want to visualize them or compare different results files on bash, here is an unofficial [plaintext results parser](https://github.com/joeyleeeeeee97/PlainTextResultsParser)

## Contributing

The community has consistently helped in making these tests better, and we welcome any and all changes. Reviewing our contribution practices and guidelines will help to keep us all on the same page. The [contribution guide](https://github.com/KhulnaSoft/BenchWeb/wiki/Development-Contributing-Guide) can be found in the [BW documentation](https://github.com/KhulnaSoft/BenchWeb/wiki).

Join in the conversation in the [Discussions tab](https://github.com/KhulnaSoft/BenchWeb/discussions), on [Twitter](https://twitter.com/bwenchmarks), or chat with us on [Freenode](https://webchat.freenode.net/) at `#khulnasoft-fwbm`. 
