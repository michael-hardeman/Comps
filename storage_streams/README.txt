Contents
--------
storage_stream.ads: package spec
storage_stream.adb: package body
t_ss              : procedure, test program


This package provides a stream that writes data of any type at any
memory address. Quite convenient for writing low-level interfaces.

See comments in the package specification for usage, and the test
program for an example. Note how this package can be used to
determine whether the machine is big- or little-endian!

This package is free software, under the GMGPL license; see header
comments for details.
