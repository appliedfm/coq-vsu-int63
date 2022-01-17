From VST Require Import floyd.proofauto.


Definition encode_Z (x: Z): Z := x * 2 + 1.

Module encode_Z.
    Definition min_signed: Z := - 2^62.
    Definition max_signed: Z := 2^62 - 1.

    Lemma bound_iff (x: Z):
        Int64.min_signed <= encode_Z x <= Int64.max_signed <-> min_signed <= x <= max_signed.
    Proof.
        unfold encode_Z.
        unfold min_signed.
        unfold max_signed.
        assert (E: Int64.min_signed = - 2^63). { reflexivity. } rewrite E in * ; clear E.
        assert (E: Int64.max_signed = 2^63 - 1). { reflexivity. } rewrite E in * ; clear E.
        constructor ; lia.
    Qed.

    Lemma bitwise (x: Z):
        encode_Z x = Z.lor 1 (Z.shiftl x 1).
    Proof.
        unfold encode_Z.
        rewrite Z.shiftl_mul_pow2 ; try lia.
        assert (E: 2 ^ 1 = 2). { lia. } rewrite E ; clear E.
        assert (E: x * 2 = 2 * x). { lia. } repeat rewrite E ; clear E.
        assert (E: 2 * x + 1 = 1 + 2 * x). { lia. } repeat rewrite E ; clear E.
        destruct x as [ | x' | x' ] ; try reflexivity.
        destruct x' ; try reflexivity.
    Qed.

    Lemma bound (x: Z) (H: Int64.min_signed <= encode_Z x <= Int64.max_signed):
        Int64.min_signed <= x <= Int64.max_signed.
    Proof.
        unfold encode_Z in *.
        unfold Int64.min_signed in *.
        unfold Int64.max_signed in *.
        constructor ; try lia.
    Qed.

    Lemma tight_bound (x: Z) (Hx: Int64.min_signed <= encode_Z x <= Int64.max_signed):
        Int64.min_signed < encode_Z x <= Int64.max_signed.
    Proof.
        constructor ; try lia.

        destruct Hx as [ Hx_l Hx_h ]. clear Hx_h.
        assert (Hx_l': Int64.min_signed < encode_Z x \/ Int64.min_signed = encode_Z x). { lia. } clear Hx_l. rename Hx_l' into Hx_l.
        destruct Hx_l as [ Hx_l | Hx_l ] ; try assumption.
        unfold encode_Z in *.

        assert (E: x * 2 + 1 = 1 + 2 * x). { lia. } rewrite E in * ; clear E.
        assert (F: Z.even Int64.min_signed = Z.even (1 + 2 * x)). {  congruence. } clear Hx_l.
        rewrite Z.even_add_mul_2 in F.
        inversion F.
    Qed.
End encode_Z.
