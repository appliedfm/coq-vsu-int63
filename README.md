# coq-vst-int63

![GitHub](https://img.shields.io/github/license/appliedfm/coq-vst-int63)

Formally verified 63-bit integer arithmetic, implemented in C and proven in Coq.

Powered by [Coq](https://coq.inria.fr) and [VST](https://vst.cs.princeton.edu/). Compatible with [CompCert](https://compcert.org/).

## Packages

* `coq-veric-int63-src.opam` - C source code
* `coq-veric-int63-vst.opam` - VST model, spec, and proof (`x86_64-linux`)
* `coq-veric-int63-vst-32.opam` - VST model, spec, and proof (`x86_32-linux`)

## Installing

```console
$ opam pin -n -y .
$ opam install --working-dir ./coq-veric-int63-src.opam ./coq-veric-int63-vst.opam ./coq-veric-int63-vst-32.opam
```

## Building without installing

### `x86_64-linux`

```console
$ make deepclean ; make BITSIZE=64
```

### `x86_32-linux`

```console
$ make deepclean ; make BITSIZE=32
```

#

[![Coq](https://img.shields.io/badge/-Coq-royalblue)](https://github.com/coq/coq)
[![compcert](https://img.shields.io/badge/-compcert-orangered)](https://compcert.org/)
[![VST](https://img.shields.io/badge/-VST-navy)](https://vst.cs.princeton.edu/)

[![applied.fm](https://img.shields.io/badge/-applied.fm-orchid)](https://applied.fm)
