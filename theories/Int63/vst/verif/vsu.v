From VST Require Import floyd.proofauto.
From VST Require Import floyd.VSU.

From appliedfm Require Import Int63.vst.clightgen.int63.
From appliedfm Require Import Int63.vst.spec.spec.
From appliedfm Require Import Int63.vst.verif.verif.

#[local] Existing Instance NullExtension.Espec.

Lemma int63__vsu:
  VSU
    int63__specs.externs
    int63__specs.imports
    ltac:(QPprog prog)
    int63__specs.exports
    emp.
Proof.
  mkVSU prog int63__specs.internals.
  - solve_SF_internal body_decode_int63.
  - solve_SF_internal body_encode_int63.
  - solve_SF_internal body_int63_zero.
  - solve_SF_internal body_int63_one.
  - solve_SF_internal body_int63_neg.
  - solve_SF_internal body_int63_abs.
  - solve_SF_internal body_int63_add.
  - solve_SF_internal body_int63_sub.
  - solve_SF_internal body_int63_mul.
  - solve_SF_internal body_int63_div.
  - solve_SF_internal body_int63_rem.
  - solve_SF_internal body_int63_shiftl.
  - solve_SF_internal body_int63_shiftr.
  - solve_SF_internal body_int63_or.
  - solve_SF_internal body_int63_and.
  - solve_SF_internal body_int63_xor.
  - solve_SF_internal body_int63_not.
Qed.
