From VST Require Export floyd.proofauto.
From VST Require Export floyd.library.
From appliedfm Require Export Int63.vst.clightgen.int63.

#[global]Instance CompSpecs : compspecs. make_compspecs prog. Defined.
Definition Vprog : varspecs. mk_varspecs prog. Defined.
