coq-vsu-int63
===================

Published by `applied.fm <https://applied.fm>`_.

A `Verified Software Unit <https://github.com/appliedfm/coq-vsu>`_ for 63-bit integer arithmetic.

Implemented in C, modeled in `Coq <https://coq.inria.fr>`_, and proven correct using the `Verified Software Toolchain <https://vst.cs.princeton.edu/>`_.

Compatible with `CompCert <https://compcert.org/>`_.

.. note:: This is a work in progress! We welcome feedback and pull requests. `Find us on GitHub <https://github.com/appliedfm/coq-vsu-int63>`_.


C library
---------

See our `Doxygen docs <doxygen/html/index.html>`_.

Coq library
-----------

* `Coq model <https://github.com/appliedfm/coq-vsu-int63/blob/main/theories/Int63/model/int63.v>`_
* `Coq specs <https://github.com/appliedfm/coq-vsu-int63/blob/main/theories/Int63/vst/spec/spec.v>`_
* `Coq proofs <https://github.com/appliedfm/coq-vsu-int63/blob/main/theories/Int63/vst/verif/verif.v>`_
