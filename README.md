# coq-vsu-int63

![GitHub](https://img.shields.io/github/license/appliedfm/coq-vsu-int63)

A [Verified Software Unit](https://github.com/appliedfm/coq-vsu) for 63-bit integer arithmetic.

Formally verified 63-bit integer arithmetic, implemented in C and proven in Coq.

Powered by [Coq](https://coq.inria.fr) and [VST](https://vst.cs.princeton.edu/). Compatible with [CompCert](https://compcert.org/).

## Packages

* `coq-vsu-int63-src` - C source code
* `coq-vsu-int63-vst` - VST model, spec, and proof (`x86_64-linux`)
* `coq-vsu-int63-vst-32` - VST model, spec, and proof (`x86_32-linux`)
* `coq-vsu-int63` - All of the above

## Installing

```console
$ opam pin -n -y .
$ opam install --working-dir ./coq-vsu-int63.opam
```

## Building without `opam`

The general pattern looks like this:

```console
$ make [verydeepclean|deepclean|clean]
$ make BITSIZE={opam|64|32} [all|theories|install|install-src|install-vst]
```

`BITSIZE` determines which `compcert` target to use:

* `opam` and `64` both use `x86_64-linux`
* `32` uses `x86_32-linux`

#

[![Coq](https://img.shields.io/badge/-Coq-royalblue)](https://github.com/coq/coq)
[![compcert](https://img.shields.io/badge/-compcert-orangered)](https://compcert.org/)
[![VST](https://img.shields.io/badge/-VST-navy)](https://vst.cs.princeton.edu/)

[![applied.fm](https://img.shields.io/badge/-applied.fm-orchid)](https://applied.fm)
