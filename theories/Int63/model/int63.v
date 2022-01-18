From Coq Require Import micromega.Lia.
From Coq Require Import ZArith.ZArith.

Local Open Scope Z.

Definition encode_Z (z: Z): Z := z * 2 + 1.

Lemma encode_Z__bitwise (x: Z):
    encode_Z x = Z.lor 1 (Z.shiftl x 1).
Proof.
    unfold encode_Z.
    rewrite Z.shiftl_mul_pow2 ; try lia.
    change (2^1) with 2.
    replace (x * 2) with (2 * x) by lia.
    replace (2 * x + 1) with (1 + 2 * x) by lia.
    now destruct x as [|x'|[x'|x'|]].
Qed.

Lemma encode_Z__odd (z: Z):
    Z.odd (encode_Z z) = true.
Proof.
    unfold encode_Z.
    replace (z * 2 + 1) with (1 + 2 * z) by lia.
    now rewrite Z.odd_add_mul_2.
Qed.

Lemma encode_Z__bounds (b z: Z) (Hb: 0 <= b):
    (- 2^(b + 1) <= encode_Z z <= 2^(b + 1) - 1) <-> (- 2^b <= z <= 2^b - 1).
Proof.
    unfold encode_Z.
    rewrite (Z.pow_add_r 2 b 1) ; try lia.
Qed.

Lemma encode_Z__tight_lower_bound (b z: Z) (Hb: 1 <= b) (Hz: - 2^b <= encode_Z z):
    - 2^b < encode_Z z.
Proof.
    apply Zle_lt_or_eq in Hz.
    destruct Hz as [Hz|F]; try lia.
    exfalso.
    apply (f_equal Z.odd) in F.
    rewrite encode_Z__odd in F by lia.
    rewrite Z.odd_opp in F.
    rewrite Z.odd_pow in F by lia.
    inversion F.
Qed.
