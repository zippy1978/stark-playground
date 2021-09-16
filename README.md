![Stark](https://github.com/zippy1978/stark/raw/main/logo/StarkLogoDark.png)

# Stark playground

This repository is an evolving show ase of what can be done with the Stark programing language.

For more information about the language, please refer to [The Stark programming language](https://github.com/zippy1978/stark) repository.

## Layout


### stdmods

Stark is not yet provided with a standard library (the infamous stdlib). So this repository provides stdmods (standard modules) as a first effort to build such a library. stdmods sources are located inside the ``stdmods`` folder.

### Examples

A set of example programs are located inside the ``examples``folder.

- clock: an ascii clock displaying the current time
- httpdownload: downloads a file using the HTTP protocol
- projectgen: generate a Makefile based Stark project
- readfile: write and read a file

## Usage

This repository is a Bazel project, so [Bazel](https://bazel.build/) is all you need to build and test everything.

Here is the command you can use to run an example program:

```bash
$ bazel run //examples:clock
```