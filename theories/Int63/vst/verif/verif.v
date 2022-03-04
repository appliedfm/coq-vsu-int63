From VST Require Import floyd.proofauto.

From appliedfm Require Import Int63.model.int63.
From appliedfm Require Import Int63.vst.ast.ast.
From appliedfm Require Import Int63.vst.clightgen.int63.
From appliedfm Require Import Int63.vst.spec.spec.


Module Facts.
  Lemma encode_Z_bounds (x: Z) (Hx: Int64.min_signed <= encode_Z x <= Int64.max_signed):
    Int64.min_signed <= x <= Int64.max_signed.
  Proof.
    change Int64.min_signed with (- 2^63) in *.
    change Int64.max_signed with (2^63 - 1) in *.
    apply encode_Z__bounds ; lia.
  Qed.


  Lemma encode_Z_bitwise (x: Z):
    Int64.repr (encode_Z x) = Int64.or (Int64.shl (Int64.repr x) (Int64.repr 1)) (Int64.repr 1).
  Proof.
    rewrite Int64.shifted_or_is_add.
    2: { constructor ; try lia ; try constructor. }
    2: { constructor. }
    assert (E: two_p 1 = Int64.unsigned (Int64.repr 2)). { reflexivity. } rewrite E ; clear E.

    unfold encode_Z.
    repeat rewrite <- add64_repr.
    repeat rewrite <- mul64_repr.
    assert (E: forall z, Int64.repr (Int64.unsigned (Int64.repr z)) = Int64.repr z).
    {
      intro z.
      symmetry.
      apply Int64.eqm_samerepr.
      apply Int64.eqm_unsigned_repr.
    } repeat rewrite E ; clear E.
    reflexivity.
  Qed.

  Lemma decode_Z_sign_bit (x: Z) (Hx: Int64.min_signed <= encode_Z x <= Int64.max_signed):
    Int64.testbit (Int64.repr x) (Int64.zwordsize - 1) =
    Int64.testbit (Int64.repr x) (Int64.zwordsize - 1 - 1).
  Proof.
    repeat rewrite Int64.testbit_repr.
    2: { cbv. constructor ; congruence. }
    2: { cbv. constructor ; congruence. }
    destruct x as [ | x' | x' ] ; try reflexivity.
    {
      assert (H': Z.log2 (Z.pos x') < Int64.zwordsize - 1 - 1).
      2: { repeat rewrite Z.bits_above_log2 ; try lia. }
      destruct Hx as [ Hx_l Hx_h ].
      clear Hx_l.
      apply Z.log2_le_mono in Hx_h.

      assert (E: Int64.zwordsize - 1 - 1 = 62). { reflexivity. } rewrite E in * ; clear E.
      assert (E: Z.log2 Int64.max_signed = 62). { reflexivity. } rewrite E in * ; clear E.

      assert (E: Z.log2 (Z.pos x') = Z.log2 (encode_Z (Z.pos x')) - 1).
      2: { rewrite E. lia. }

      rewrite encode_Z__bitwise.
      simpl Z.shiftl.
      simpl Z.lor.

      transitivity (Z.pos (Pos.size x') - 1).
      2: { reflexivity. }
      clear Hx_h.
      destruct x' ; try reflexivity.
      all: simpl Pos.size ; simpl Z.log2 ; lia.
    }
    {
      assert (Hx_l: Int64.min_signed < encode_Z (Z.neg x')).
      {
        change Int64.min_signed with (- 2^63) in *.
        apply encode_Z__tight_lower_bound ; try lia.
      }
      unfold encode_Z in Hx_l.
      assert (H': Z.pos x' * 2 - 1 <= - Int64.min_signed - 1) by lia.
      clear Hx_l. rename H' into Hx_l.

      apply Z.log2_le_mono in Hx_l.

      change (Int64.zwordsize - 1 - 1) with 62 in *.
      change (Int64.zwordsize - 1) with 63 in *.
      change (Z.log2 (- Int64.min_signed - 1)) with 62 in *.

      assert (H'': Z.log2 (Z.pos x') <= Z.log2 (Z.pos x' * 2 - 1)).
      {
        apply Z.log2_le_mono.
        lia.  
      }

      transitivity true.
      { apply Z.bits_iff_neg ; try simpl Z.abs ; try lia. }
      symmetry.

      assert (Hx': Z.pos x' <= two_power_nat 62).
      {
        change Int64.min_signed with (- ((two_power_nat 62) * 2)) in *.
        unfold encode_Z in Hx.
        lia.
      }
      clear Hx. rename Hx' into Hx.
      assert (Hx': Z.pos x' < two_power_nat 62 \/ Z.pos x' = two_power_nat 62). { lia. }
      clear Hx. rename Hx' into Hx.

      destruct Hx as [ Hx | Hx ].
      {
        apply Z.bits_iff_neg ; try lia.
        simpl Z.abs.
        assert (Hx': Z.pos x' <= two_power_nat 62 - 1). { lia. } clear Hx. rename Hx' into Hx.
        apply Z.log2_le_mono in Hx.
        change (Z.log2 (two_power_nat 62 - 1)) with 61 in *.
        lia.
      }
      {
        inversion Hx.
        reflexivity.
      }
    }
  Qed.

  Lemma decode_Z_sign_ext (x: Z) (Hx: Int64.min_signed <= encode_Z x <= Int64.max_signed):
    Int64.repr x =
    Int64.sign_ext (Int64.zwordsize - Int64.unsigned (Int64.repr 1)) (Int64.repr x).
  Proof.
    apply Int64.same_bits_eq. intros i Hi.
    assert (E: Int64.unsigned (Int64.repr 1) = 1). { reflexivity. } rewrite E ; clear E.
    rewrite Int64.bits_sign_ext ; try assumption.
    destruct (zlt i (Int64.zwordsize - 1)) as [ _ | Hi' ] ; try reflexivity.
    assert (Hi'': forall z, i >= z -> i > z \/ i = z). { lia. } apply Hi'' in Hi' ; clear Hi''.
    destruct Hi' as [ Hi' | Hi' ] ; try lia.
    subst.
    apply decode_Z_sign_bit.
    assumption.
  Qed.

  Lemma decode_Z_bitwise (x: Z) (Hx: Int64.min_signed <= encode_Z x <= Int64.max_signed):
    Int64.repr x = Int64.shr (Int64.repr (encode_Z x)) (Int64.repr 1).
  Proof.
    rewrite encode_Z_bitwise.
    rewrite <- Int64.or_shr.
    assert (E: Int64.shr (Int64.repr 1) (Int64.repr 1) = Int64.zero). { reflexivity. } rewrite E ; clear E.
    rewrite Int64.or_zero.
    rewrite Int64.shr_shl.
    2: { reflexivity. }
    2: { reflexivity. }
    assert (E: Int64.ltu (Int64.repr 1) (Int64.repr 1) = false). { reflexivity. } rewrite E ; clear E.
    assert (E: Int64.sub (Int64.repr 1) (Int64.repr 1) = Int64.zero). { reflexivity. } rewrite E ; clear E.
    rewrite Int64.shr_zero.
    apply decode_Z_sign_ext.
    assumption.
  Qed.
End Facts.


Lemma body_encode_int63: semax_body Vprog int63__specs.all f_encode_int63 encode_int63_spec.
  leaf_function.
  start_function.
  repeat forward ; entailer!.
  rewrite Facts.encode_Z_bitwise ; trivial.
Qed.

Lemma body_decode_int63: semax_body Vprog int63__specs.all f_decode_int63 decode_int63_spec.
  leaf_function.
  start_function.
  repeat forward ; entailer!.
  symmetry.
  rewrite Facts.decode_Z_bitwise ; trivial.
Qed.

Lemma body_int63_zero: semax_body Vprog int63__specs.all f_int63_zero int63_zero_spec.
Proof.
  start_function.
  repeat step.
Qed.

Lemma body_int63_one: semax_body Vprog int63__specs.all f_int63_one int63_one_spec.
Proof.
  start_function.
  repeat step.
Qed.

Lemma body_int63_neg: semax_body Vprog int63__specs.all f_int63_neg int63_neg_spec.
Proof.
  start_function.
  repeat step ; entailer!.
  {
    unfold encode_Z in *.
    lia.
  }
  simpl.
  repeat f_equal.
  unfold encode_Z.
  lia.
Qed.

Lemma body_int63_abs: semax_body Vprog int63__specs.all f_int63_abs int63_abs_spec.
Proof.
  start_function.
  forward_if (PROP () LOCAL (temp _t'1 (Vlong (Int64.repr (encode_Z (Z.abs x))))) SEP ()).
  {
    repeat step.
    entailer!.
    repeat f_equal.
    intros.
    rewrite Int64.signed_repr in H1 ; try lia.
    assert (E: Int64.signed (Int64.repr 0) = 0). { reflexivity. } rewrite E in * ; clear E.
    unfold encode_Z in *.
    rewrite <- Z.abs_opp.
    rewrite Z.abs_eq ; try lia.
  }
  {
    repeat step.
    entailer!.
    repeat f_equal.
    rewrite Int64.signed_repr in H1 ; try lia.
    assert (E: Int64.signed (Int64.repr 0) = 0). { reflexivity. } rewrite E in * ; clear E.
    unfold encode_Z in *.
    apply Z.abs_eq.
    lia.
  }
  repeat step.
Qed.

Lemma body_int63_add: semax_body Vprog int63__specs.all f_int63_add int63_add_spec.
Proof.
  leaf_function.
  start_function.
  repeat step ; try entailer!.
  {
    unfold encode_Z in *.
    repeat rewrite Int64.signed_repr ; try lia.
  }
  {
    repeat f_equal.
    unfold encode_Z.
    lia.
  }
Qed.

Lemma body_int63_sub: semax_body Vprog int63__specs.all f_int63_sub int63_sub_spec.
Proof.
  leaf_function.
  start_function.
  assert (H': Int64.min_signed <= encode_Z (x - y) - 1 <= Int64.max_signed).
  {
    assert (H_tight: Int64.min_signed < encode_Z (x - y)).
    {
      change Int64.min_signed with (-2^63) in *.
      apply encode_Z__tight_lower_bound ; lia.
    }
    lia.
  }
  repeat step ; try entailer!.
  {
    unfold encode_Z in *.
    repeat rewrite Int64.signed_repr ; try lia.
  }
  {
    repeat f_equal.
    unfold encode_Z.
    lia.
  }
Qed.

Lemma body_int63_mul: semax_body Vprog int63__specs.all f_int63_mul int63_mul_spec.
Proof.
  start_function.
  repeat step ; try entailer!.
  repeat rewrite Int64.signed_repr ; apply Facts.encode_Z_bounds ; lia.
Qed.

Lemma body_int63_div: semax_body Vprog int63__specs.all f_int63_div int63_div_spec.
Proof.
  start_function.
  repeat step ; try entailer!.
  {
    constructor.
    {
      intro F.
      apply H1. clear H1.
      transitivity (Int64.signed (Int64.repr y)).
      {
        rewrite Int64.signed_repr ; try apply Facts.encode_Z_bounds ; lia.
      }
      {
        rewrite F ; trivial.
      }
    }
    {
      intro F.
      assert (E: Int64.signed (Int64.repr x) = Int64.signed (Int64.repr Int64.min_signed)).
      { destruct F. congruence. }
      clear F.

      rewrite Int64.signed_repr in E ; try apply Facts.encode_Z_bounds ; try lia.
      rewrite Int64.signed_repr in E ; try lia.

      destruct H as [ H H' ]. clear H'.
      apply H. subst. reflexivity.
    }
  }
  {
    repeat f_equal ; try rewrite Int64.signed_repr ; try apply Facts.encode_Z_bounds ; lia.
  }
Qed.

Lemma body_int63_rem: semax_body Vprog int63__specs.all f_int63_rem int63_rem_spec.
Proof.
  start_function.
  repeat step ; try entailer!.
  {
    constructor.
    {
      intro F.
      apply H1.
      transitivity (Int64.signed (Int64.repr y)).
      {
        rewrite Int64.signed_repr ; try apply Facts.encode_Z_bounds ; trivial.
      }
      {
        rewrite F ; trivial.
      }
    }
    {
      intro F.
      assert (E: Int64.signed (Int64.repr x) = Int64.signed (Int64.repr Int64.min_signed)).
      { destruct F. congruence. }
      clear F.

      rewrite Int64.signed_repr in E ; try apply Facts.encode_Z_bounds ; try lia.
      rewrite Int64.signed_repr in E ; try lia.

      destruct H as [ H H' ]. clear H'.
      apply H. subst. reflexivity.
    }
  }
  {
    repeat f_equal ; try rewrite Int64.signed_repr ; try apply Facts.encode_Z_bounds ; trivial.
  }
Qed.

Lemma body_int63_shiftl: semax_body Vprog int63__specs.all f_int63_shiftl int63_shiftl_spec.
Proof.
  start_function.
  repeat step ; try entailer!.
  {
    unfold Int64.iwordsize.
    rewrite Int64.unsigned_repr ; try lia.
    constructor ; cbv ; congruence.
  }
  {
    apply Facts.encode_Z_bounds in H.
    generalize Int64.max_signed_unsigned. intro.
    generalize (Int64.unsigned_range_2 (Int64.repr y)). intro.
    assert (H': Int64.zwordsize <= Int64.max_signed). { intro F. inversion F. }
    repeat f_equal ; rewrite Int64.unsigned_repr in * ; try lia.
  }
Qed.

Lemma body_int63_shiftr: semax_body Vprog int63__specs.all f_int63_shiftr int63_shiftr_spec.
Proof.
  start_function.
  repeat step ; try entailer!.
  {
    unfold Int64.iwordsize.
    rewrite Int64.unsigned_repr ; try lia.
    constructor ; cbv ; congruence.
  }
  {
    repeat f_equal ; rewrite Int64.signed_repr ; try apply Facts.encode_Z_bounds ; trivial.
  }
Qed.

Lemma body_int63_or: semax_body Vprog int63__specs.all f_int63_or int63_or_spec.
Proof.
  leaf_function.
  start_function.
  repeat step ; try entailer!.
  repeat f_equal.
  repeat rewrite encode_Z__bitwise.

  rewrite <- Z.lor_assoc.
  assert (E: Z.lor (Z.shiftl x 1) (Z.lor 1 (Z.shiftl y 1)) = Z.lor 1 (Z.lor (Z.shiftl x 1) (Z.shiftl y 1))).
  {
    rewrite Z.lor_assoc.
    rewrite Z.lor_assoc.
    assert (E: Z.lor (Z.shiftl x 1) 1 = Z.lor 1 (Z.shiftl x 1)). { apply Z.lor_comm. } rewrite E ; clear E.
    reflexivity.
  } rewrite E ; clear E.
  rewrite Z.lor_assoc.
  rewrite Z.shiftl_lor.
  reflexivity.
Qed.

Lemma body_int63_and: semax_body Vprog int63__specs.all f_int63_and int63_and_spec.
Proof.
  leaf_function.
  start_function.
  repeat step ; try entailer!.
  repeat f_equal.
  repeat rewrite encode_Z__bitwise.

  repeat rewrite Z.land_lor_distr_l.
  repeat rewrite Z.land_lor_distr_r.
  assert (E: Z.land 1 1 = 1). { reflexivity. } repeat rewrite E ; clear E.
  assert (E: forall z, Z.land z 1 = Z.land 1 z). { intros ; apply Z.land_comm. } repeat rewrite E ; clear E.
  assert (E: forall z, Z.land 1 (Z.shiftl z 1) = 0).
  {
    destruct z ; try reflexivity.
    destruct p ; try reflexivity.
  } repeat rewrite E ; clear E.
  f_equal.
  rewrite Z.lor_0_l.
  rewrite Z.shiftl_land.
  reflexivity.
Qed.

Lemma body_int63_xor: semax_body Vprog int63__specs.all f_int63_xor int63_xor_spec.
Proof.
  leaf_function.
  start_function.
  repeat step ; try entailer!.
  repeat rewrite encode_Z__bitwise.
  repeat rewrite <- or64_repr.
  repeat f_equal.

  apply Int64.same_bits_eq.
  intros i Hi.
  rewrite Z.shiftl_lxor.
  repeat rewrite Int64.bits_xor ; try assumption.
  repeat rewrite Int64.bits_or ; try assumption.
  repeat rewrite Int64.testbit_repr ; try assumption.
  repeat rewrite Z.lxor_spec.
  repeat rewrite Z.shiftl_spec ; try lia.
  destruct i as [ | i' | i' ] ; trivial.
Qed.

Lemma body_int63_not: semax_body Vprog int63__specs.all f_int63_not int63_not_spec.
Proof.
  leaf_function.
  start_function.
  repeat step ; try entailer!.
  repeat rewrite encode_Z__bitwise.
  unfold Int64.not.
  repeat rewrite <- or64_repr.
  repeat f_equal.

  apply Int64.same_bits_eq.
  intros i Hi.
  repeat rewrite Int64.bits_xor ; try assumption.
  repeat rewrite Int64.bits_or ; try assumption.
  unfold Int64.mone.
  repeat rewrite Int64.testbit_repr ; try assumption.
  repeat rewrite Z.shiftl_spec ; try lia.
  destruct i as [ | i' | i' ] ; try reflexivity.
  repeat rewrite Z.lnot_spec ; try lia.
  rewrite xorb_true_r.
  reflexivity.
Qed.
