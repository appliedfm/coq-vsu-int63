From VST Require Export floyd.proofauto.
From VST Require Export floyd.library.
From Int63 Require Export c.clightgen.int63.

#[global]Instance CompSpecs : compspecs. make_compspecs prog. Defined.
Definition Vprog : varspecs. mk_varspecs prog. Defined.
