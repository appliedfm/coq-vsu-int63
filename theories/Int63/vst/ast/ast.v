From VST Require Import floyd.proofauto.
From appliedfm Require Import Int63.vst.clightgen.int63.

#[global]Instance CompSpecs : compspecs. make_compspecs prog. Defined.
Definition Vprog : varspecs. mk_varspecs prog. Defined.
