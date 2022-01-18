# coq-vsu-int63

![build](https://github.com/appliedfm/coq-vsu-int63/actions/workflows/build.yml/badge.svg)

![GitHub](https://img.shields.io/github/license/appliedfm/coq-vsu-int63)

A [Verified Software Unit](https://github.com/appliedfm/coq-vsu) for 63-bit integer arithmetic.

Formally verified 63-bit integer arithmetic, implemented in C and proven in Coq.

Powered by [Coq](https://coq.inria.fr) and [VST](https://vst.cs.princeton.edu/). Compatible with [CompCert](https://compcert.org/).


## Verification status

Specifications are proven respect for the following targets:

- [x] `x86_64-linux`
- [x] `x86_32-linux`

Proofs are checked by our [CI infrastructure](https://github.com/appliedfm/coq-vsu-int63/actions/workflows/build.yml).


## Packages

* `coq-vsu-int63-src` - C source code
* `coq-vsu-int63-vst` - VST model, spec, and proof (`x86_64-linux`)
* `coq-vsu-int63-vst-32` - VST model, spec, and proof (`x86_32-linux`)
* `coq-vsu-int63` - All of the above

## Installing

Installation is performed by `opam` with help by [coq-vsu](https://github.com/appliedfm/coq-vsu).

```console
$ opam pin -n -y .
$ opam install --working-dir ./coq-vsu-int63.opam
```

## Using the C library

The C library is installed to the path given by `vsu -I`. For example:

```console
$ tree `vsu -I`
/home/tcarstens/.opam/coq-8.14/lib/coq-vsu/lib/include
└── coq-vsu-int63
    ├── int63.h
    └── src
        └── int63.c

2 directories, 2 files
$
```

## Building without `opam`

The general pattern looks like this:

```console
$ make [verydeepclean|deepclean|clean]
$ make BITSIZE={opam|64|32} [all|_CoqProject|clightgen|theories]
```

`BITSIZE` determines which `compcert` target to use. If unspecified, the default value is `opam`:

* `opam` and `64` both use `x86_64-linux`
* `32` uses `x86_32-linux`

### Example: `x86_64-linux`

```console
$ make verydeepclean ; make
```

### Example: `x86_32-linux`

```console
$ make verydeepclean ; make BITSIZE=32
```

#

[![Coq](https://img.shields.io/badge/-Coq-royalblue)](https://github.com/coq/coq)
[![compcert](https://img.shields.io/badge/-compcert-orangered)](https://compcert.org/)
[![VST](https://img.shields.io/badge/-VST-navy)](https://vst.cs.princeton.edu/)

[![applied.fm](https://img.shields.io/badge/-applied.fm-orchid)](https://applied.fm)
