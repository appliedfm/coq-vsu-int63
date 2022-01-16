# coq-vst-int63

![GitHub](https://img.shields.io/github/license/appliedfm/coq-vst-int63)

Formally verified 63-bit integer arithmetic, implemented in C and proven in Coq.

Powered by [Coq](https://coq.inria.fr) and [VST](https://vst.cs.princeton.edu/). Compatible with [CompCert](https://compcert.org/).

## Installing

```console
$ opam install ./coq-vst-int63.opam ./coq-vst-int63-32.opam
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
