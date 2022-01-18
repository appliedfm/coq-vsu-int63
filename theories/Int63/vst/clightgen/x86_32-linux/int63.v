From Coq Require Import String List ZArith.
From compcert Require Import Coqlib Integers Floats AST Ctypes Cop Clight Clightdefs.
Import Clightdefs.ClightNotations.
Local Open Scope Z_scope.
Local Open Scope string_scope.
Local Open Scope clight_scope.

Module Info.
  Definition version := "3.9".
  Definition build_number := "".
  Definition build_tag := "".
  Definition build_branch := "".
  Definition arch := "x86".
  Definition model := "32sse2".
  Definition abi := "standard".
  Definition bitsize := 32.
  Definition big_endian := false.
  Definition source_file := "src/c/include/coq-vsu-int63/src/int63.c".
  Definition normalized := true.
End Info.

Definition ___builtin_ais_annot : ident := $"__builtin_ais_annot".
Definition ___builtin_annot : ident := $"__builtin_annot".
Definition ___builtin_annot_intval : ident := $"__builtin_annot_intval".
Definition ___builtin_bswap : ident := $"__builtin_bswap".
Definition ___builtin_bswap16 : ident := $"__builtin_bswap16".
Definition ___builtin_bswap32 : ident := $"__builtin_bswap32".
Definition ___builtin_bswap64 : ident := $"__builtin_bswap64".
Definition ___builtin_clz : ident := $"__builtin_clz".
Definition ___builtin_clzl : ident := $"__builtin_clzl".
Definition ___builtin_clzll : ident := $"__builtin_clzll".
Definition ___builtin_ctz : ident := $"__builtin_ctz".
Definition ___builtin_ctzl : ident := $"__builtin_ctzl".
Definition ___builtin_ctzll : ident := $"__builtin_ctzll".
Definition ___builtin_debug : ident := $"__builtin_debug".
Definition ___builtin_expect : ident := $"__builtin_expect".
Definition ___builtin_fabs : ident := $"__builtin_fabs".
Definition ___builtin_fabsf : ident := $"__builtin_fabsf".
Definition ___builtin_fmadd : ident := $"__builtin_fmadd".
Definition ___builtin_fmax : ident := $"__builtin_fmax".
Definition ___builtin_fmin : ident := $"__builtin_fmin".
Definition ___builtin_fmsub : ident := $"__builtin_fmsub".
Definition ___builtin_fnmadd : ident := $"__builtin_fnmadd".
Definition ___builtin_fnmsub : ident := $"__builtin_fnmsub".
Definition ___builtin_fsqrt : ident := $"__builtin_fsqrt".
Definition ___builtin_membar : ident := $"__builtin_membar".
Definition ___builtin_memcpy_aligned : ident := $"__builtin_memcpy_aligned".
Definition ___builtin_read16_reversed : ident := $"__builtin_read16_reversed".
Definition ___builtin_read32_reversed : ident := $"__builtin_read32_reversed".
Definition ___builtin_sel : ident := $"__builtin_sel".
Definition ___builtin_sqrt : ident := $"__builtin_sqrt".
Definition ___builtin_unreachable : ident := $"__builtin_unreachable".
Definition ___builtin_va_arg : ident := $"__builtin_va_arg".
Definition ___builtin_va_copy : ident := $"__builtin_va_copy".
Definition ___builtin_va_end : ident := $"__builtin_va_end".
Definition ___builtin_va_start : ident := $"__builtin_va_start".
Definition ___builtin_write16_reversed : ident := $"__builtin_write16_reversed".
Definition ___builtin_write32_reversed : ident := $"__builtin_write32_reversed".
Definition ___compcert_i64_dtos : ident := $"__compcert_i64_dtos".
Definition ___compcert_i64_dtou : ident := $"__compcert_i64_dtou".
Definition ___compcert_i64_sar : ident := $"__compcert_i64_sar".
Definition ___compcert_i64_sdiv : ident := $"__compcert_i64_sdiv".
Definition ___compcert_i64_shl : ident := $"__compcert_i64_shl".
Definition ___compcert_i64_shr : ident := $"__compcert_i64_shr".
Definition ___compcert_i64_smod : ident := $"__compcert_i64_smod".
Definition ___compcert_i64_smulh : ident := $"__compcert_i64_smulh".
Definition ___compcert_i64_stod : ident := $"__compcert_i64_stod".
Definition ___compcert_i64_stof : ident := $"__compcert_i64_stof".
Definition ___compcert_i64_udiv : ident := $"__compcert_i64_udiv".
Definition ___compcert_i64_umod : ident := $"__compcert_i64_umod".
Definition ___compcert_i64_umulh : ident := $"__compcert_i64_umulh".
Definition ___compcert_i64_utod : ident := $"__compcert_i64_utod".
Definition ___compcert_i64_utof : ident := $"__compcert_i64_utof".
Definition ___compcert_va_composite : ident := $"__compcert_va_composite".
Definition ___compcert_va_float64 : ident := $"__compcert_va_float64".
Definition ___compcert_va_int32 : ident := $"__compcert_va_int32".
Definition ___compcert_va_int64 : ident := $"__compcert_va_int64".
Definition __x : ident := $"_x".
Definition __y : ident := $"_y".
Definition __z : ident := $"_z".
Definition _decode_int63 : ident := $"decode_int63".
Definition _encode_int63 : ident := $"encode_int63".
Definition _int63_abs : ident := $"int63_abs".
Definition _int63_add : ident := $"int63_add".
Definition _int63_and : ident := $"int63_and".
Definition _int63_div : ident := $"int63_div".
Definition _int63_mul : ident := $"int63_mul".
Definition _int63_neg : ident := $"int63_neg".
Definition _int63_not : ident := $"int63_not".
Definition _int63_one : ident := $"int63_one".
Definition _int63_or : ident := $"int63_or".
Definition _int63_rem : ident := $"int63_rem".
Definition _int63_shiftl : ident := $"int63_shiftl".
Definition _int63_shiftr : ident := $"int63_shiftr".
Definition _int63_sub : ident := $"int63_sub".
Definition _int63_xor : ident := $"int63_xor".
Definition _int63_zero : ident := $"int63_zero".
Definition _main : ident := $"main".
Definition _x : ident := $"x".
Definition _y : ident := $"y".
Definition _t'1 : ident := 128%positive.
Definition _t'2 : ident := 129%positive.
Definition _t'3 : ident := 130%positive.

Definition f_encode_int63 := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Sreturn (Some (Ebinop Oor
                 (Ebinop Oshl (Etempvar _x tlong)
                   (Econst_int (Int.repr 1) tint) tlong)
                 (Econst_int (Int.repr 1) tint) tlong)))
|}.

Definition f_decode_int63 := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Sreturn (Some (Ebinop Oshr (Ecast (Etempvar _x tlong) tlong)
                 (Econst_int (Int.repr 1) tint) tlong)))
|}.

Definition f_int63_zero := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := nil;
  fn_vars := nil;
  fn_temps := ((_t'1, tlong) :: nil);
  fn_body :=
(Ssequence
  (Scall (Some _t'1)
    (Evar _encode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
    ((Econst_int (Int.repr 0) tint) :: nil))
  (Sreturn (Some (Etempvar _t'1 tlong))))
|}.

Definition f_int63_one := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := nil;
  fn_vars := nil;
  fn_temps := ((_t'1, tlong) :: nil);
  fn_body :=
(Ssequence
  (Scall (Some _t'1)
    (Evar _encode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
    ((Econst_int (Int.repr 1) tint) :: nil))
  (Sreturn (Some (Etempvar _t'1 tlong))))
|}.

Definition f_int63_neg := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Sreturn (Some (Ebinop Osub (Econst_int (Int.repr 2) tint)
                 (Etempvar _x tlong) tlong)))
|}.

Definition f_int63_abs := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: nil);
  fn_vars := nil;
  fn_temps := ((_t'2, tlong) :: (_t'1, tlong) :: nil);
  fn_body :=
(Ssequence
  (Sifthenelse (Ebinop Olt (Etempvar _x tlong) (Econst_int (Int.repr 0) tint)
                 tint)
    (Ssequence
      (Scall (Some _t'2)
        (Evar _int63_neg (Tfunction (Tcons tlong Tnil) tlong cc_default))
        ((Etempvar _x tlong) :: nil))
      (Sset _t'1 (Ecast (Etempvar _t'2 tlong) tlong)))
    (Sset _t'1 (Ecast (Etempvar _x tlong) tlong)))
  (Sreturn (Some (Etempvar _t'1 tlong))))
|}.

Definition f_int63_add := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: (_y, tlong) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Sreturn (Some (Ebinop Osub
                 (Ebinop Oadd (Etempvar _x tlong) (Etempvar _y tlong) tlong)
                 (Econst_int (Int.repr 1) tint) tlong)))
|}.

Definition f_int63_sub := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: (_y, tlong) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Sreturn (Some (Ebinop Oadd
                 (Ebinop Osub (Etempvar _x tlong) (Etempvar _y tlong) tlong)
                 (Econst_int (Int.repr 1) tint) tlong)))
|}.

Definition f_int63_mul := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: (_y, tlong) :: nil);
  fn_vars := nil;
  fn_temps := ((__x, tlong) :: (__y, tlong) :: (__z, tlong) ::
               (_t'3, tlong) :: (_t'2, tlong) :: (_t'1, tlong) :: nil);
  fn_body :=
(Ssequence
  (Ssequence
    (Scall (Some _t'1)
      (Evar _decode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
      ((Etempvar _x tlong) :: nil))
    (Sset __x (Etempvar _t'1 tlong)))
  (Ssequence
    (Ssequence
      (Scall (Some _t'2)
        (Evar _decode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
        ((Etempvar _y tlong) :: nil))
      (Sset __y (Etempvar _t'2 tlong)))
    (Ssequence
      (Sset __z
        (Ebinop Omul (Etempvar __x tlong) (Etempvar __y tlong) tlong))
      (Ssequence
        (Scall (Some _t'3)
          (Evar _encode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
          ((Etempvar __z tlong) :: nil))
        (Sreturn (Some (Etempvar _t'3 tlong)))))))
|}.

Definition f_int63_div := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: (_y, tlong) :: nil);
  fn_vars := nil;
  fn_temps := ((__x, tlong) :: (__y, tlong) :: (__z, tlong) ::
               (_t'3, tlong) :: (_t'2, tlong) :: (_t'1, tlong) :: nil);
  fn_body :=
(Ssequence
  (Ssequence
    (Scall (Some _t'1)
      (Evar _decode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
      ((Etempvar _x tlong) :: nil))
    (Sset __x (Etempvar _t'1 tlong)))
  (Ssequence
    (Ssequence
      (Scall (Some _t'2)
        (Evar _decode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
        ((Etempvar _y tlong) :: nil))
      (Sset __y (Etempvar _t'2 tlong)))
    (Ssequence
      (Sset __z
        (Ebinop Odiv (Etempvar __x tlong) (Etempvar __y tlong) tlong))
      (Ssequence
        (Scall (Some _t'3)
          (Evar _encode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
          ((Etempvar __z tlong) :: nil))
        (Sreturn (Some (Etempvar _t'3 tlong)))))))
|}.

Definition f_int63_rem := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: (_y, tlong) :: nil);
  fn_vars := nil;
  fn_temps := ((__x, tlong) :: (__y, tlong) :: (__z, tlong) ::
               (_t'3, tlong) :: (_t'2, tlong) :: (_t'1, tlong) :: nil);
  fn_body :=
(Ssequence
  (Ssequence
    (Scall (Some _t'1)
      (Evar _decode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
      ((Etempvar _x tlong) :: nil))
    (Sset __x (Etempvar _t'1 tlong)))
  (Ssequence
    (Ssequence
      (Scall (Some _t'2)
        (Evar _decode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
        ((Etempvar _y tlong) :: nil))
      (Sset __y (Etempvar _t'2 tlong)))
    (Ssequence
      (Sset __z
        (Ebinop Omod (Etempvar __x tlong) (Etempvar __y tlong) tlong))
      (Ssequence
        (Scall (Some _t'3)
          (Evar _encode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
          ((Etempvar __z tlong) :: nil))
        (Sreturn (Some (Etempvar _t'3 tlong)))))))
|}.

Definition f_int63_shiftl := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: (_y, tlong) :: nil);
  fn_vars := nil;
  fn_temps := ((__x, tlong) :: (__y, tlong) :: (__z, tlong) ::
               (_t'3, tlong) :: (_t'2, tlong) :: (_t'1, tlong) :: nil);
  fn_body :=
(Ssequence
  (Ssequence
    (Scall (Some _t'1)
      (Evar _decode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
      ((Etempvar _x tlong) :: nil))
    (Sset __x (Etempvar _t'1 tlong)))
  (Ssequence
    (Ssequence
      (Scall (Some _t'2)
        (Evar _decode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
        ((Etempvar _y tlong) :: nil))
      (Sset __y (Etempvar _t'2 tlong)))
    (Ssequence
      (Sset __z
        (Ebinop Oshl (Etempvar __x tlong) (Etempvar __y tlong) tlong))
      (Ssequence
        (Scall (Some _t'3)
          (Evar _encode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
          ((Etempvar __z tlong) :: nil))
        (Sreturn (Some (Etempvar _t'3 tlong)))))))
|}.

Definition f_int63_shiftr := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: (_y, tlong) :: nil);
  fn_vars := nil;
  fn_temps := ((__x, tlong) :: (__y, tlong) :: (__z, tlong) ::
               (_t'3, tlong) :: (_t'2, tlong) :: (_t'1, tlong) :: nil);
  fn_body :=
(Ssequence
  (Ssequence
    (Scall (Some _t'1)
      (Evar _decode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
      ((Etempvar _x tlong) :: nil))
    (Sset __x (Etempvar _t'1 tlong)))
  (Ssequence
    (Ssequence
      (Scall (Some _t'2)
        (Evar _decode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
        ((Etempvar _y tlong) :: nil))
      (Sset __y (Etempvar _t'2 tlong)))
    (Ssequence
      (Sset __z
        (Ebinop Oshr (Etempvar __x tlong) (Etempvar __y tlong) tlong))
      (Ssequence
        (Scall (Some _t'3)
          (Evar _encode_int63 (Tfunction (Tcons tlong Tnil) tlong cc_default))
          ((Etempvar __z tlong) :: nil))
        (Sreturn (Some (Etempvar _t'3 tlong)))))))
|}.

Definition f_int63_or := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: (_y, tlong) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Sreturn (Some (Ebinop Oor (Etempvar _x tlong) (Etempvar _y tlong) tlong)))
|}.

Definition f_int63_and := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: (_y, tlong) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Sreturn (Some (Ebinop Oand (Etempvar _x tlong) (Etempvar _y tlong) tlong)))
|}.

Definition f_int63_xor := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: (_y, tlong) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Sreturn (Some (Ebinop Oor (Ecast (Econst_int (Int.repr 1) tint) tlong)
                 (Ebinop Oxor (Etempvar _x tlong) (Etempvar _y tlong) tlong)
                 tlong)))
|}.

Definition f_int63_not := {|
  fn_return := tlong;
  fn_callconv := cc_default;
  fn_params := ((_x, tlong) :: nil);
  fn_vars := nil;
  fn_temps := nil;
  fn_body :=
(Sreturn (Some (Ebinop Oor (Ecast (Econst_int (Int.repr 1) tint) tlong)
                 (Eunop Onotint (Etempvar _x tlong) tlong) tlong)))
|}.

Definition composites : list composite_definition :=
nil.

Definition global_definitions : list (ident * globdef fundef type) :=
((___builtin_ais_annot,
   Gfun(External (EF_builtin "__builtin_ais_annot"
                   (mksignature (AST.Tint :: nil) AST.Tvoid
                     {|cc_vararg:=(Some 1); cc_unproto:=false; cc_structret:=false|}))
     (Tcons (tptr tschar) Tnil) tvoid
     {|cc_vararg:=(Some 1); cc_unproto:=false; cc_structret:=false|})) ::
 (___builtin_bswap64,
   Gfun(External (EF_builtin "__builtin_bswap64"
                   (mksignature (AST.Tlong :: nil) AST.Tlong cc_default))
     (Tcons tulong Tnil) tulong cc_default)) ::
 (___builtin_bswap,
   Gfun(External (EF_builtin "__builtin_bswap"
                   (mksignature (AST.Tint :: nil) AST.Tint cc_default))
     (Tcons tuint Tnil) tuint cc_default)) ::
 (___builtin_bswap32,
   Gfun(External (EF_builtin "__builtin_bswap32"
                   (mksignature (AST.Tint :: nil) AST.Tint cc_default))
     (Tcons tuint Tnil) tuint cc_default)) ::
 (___builtin_bswap16,
   Gfun(External (EF_builtin "__builtin_bswap16"
                   (mksignature (AST.Tint :: nil) AST.Tint16unsigned
                     cc_default)) (Tcons tushort Tnil) tushort cc_default)) ::
 (___builtin_clz,
   Gfun(External (EF_builtin "__builtin_clz"
                   (mksignature (AST.Tint :: nil) AST.Tint cc_default))
     (Tcons tuint Tnil) tint cc_default)) ::
 (___builtin_clzl,
   Gfun(External (EF_builtin "__builtin_clzl"
                   (mksignature (AST.Tint :: nil) AST.Tint cc_default))
     (Tcons tuint Tnil) tint cc_default)) ::
 (___builtin_clzll,
   Gfun(External (EF_builtin "__builtin_clzll"
                   (mksignature (AST.Tlong :: nil) AST.Tint cc_default))
     (Tcons tulong Tnil) tint cc_default)) ::
 (___builtin_ctz,
   Gfun(External (EF_builtin "__builtin_ctz"
                   (mksignature (AST.Tint :: nil) AST.Tint cc_default))
     (Tcons tuint Tnil) tint cc_default)) ::
 (___builtin_ctzl,
   Gfun(External (EF_builtin "__builtin_ctzl"
                   (mksignature (AST.Tint :: nil) AST.Tint cc_default))
     (Tcons tuint Tnil) tint cc_default)) ::
 (___builtin_ctzll,
   Gfun(External (EF_builtin "__builtin_ctzll"
                   (mksignature (AST.Tlong :: nil) AST.Tint cc_default))
     (Tcons tulong Tnil) tint cc_default)) ::
 (___builtin_fabs,
   Gfun(External (EF_builtin "__builtin_fabs"
                   (mksignature (AST.Tfloat :: nil) AST.Tfloat cc_default))
     (Tcons tdouble Tnil) tdouble cc_default)) ::
 (___builtin_fabsf,
   Gfun(External (EF_builtin "__builtin_fabsf"
                   (mksignature (AST.Tsingle :: nil) AST.Tsingle cc_default))
     (Tcons tfloat Tnil) tfloat cc_default)) ::
 (___builtin_fsqrt,
   Gfun(External (EF_builtin "__builtin_fsqrt"
                   (mksignature (AST.Tfloat :: nil) AST.Tfloat cc_default))
     (Tcons tdouble Tnil) tdouble cc_default)) ::
 (___builtin_sqrt,
   Gfun(External (EF_builtin "__builtin_sqrt"
                   (mksignature (AST.Tfloat :: nil) AST.Tfloat cc_default))
     (Tcons tdouble Tnil) tdouble cc_default)) ::
 (___builtin_memcpy_aligned,
   Gfun(External (EF_builtin "__builtin_memcpy_aligned"
                   (mksignature
                     (AST.Tint :: AST.Tint :: AST.Tint :: AST.Tint :: nil)
                     AST.Tvoid cc_default))
     (Tcons (tptr tvoid)
       (Tcons (tptr tvoid) (Tcons tuint (Tcons tuint Tnil)))) tvoid
     cc_default)) ::
 (___builtin_sel,
   Gfun(External (EF_builtin "__builtin_sel"
                   (mksignature (AST.Tint :: nil) AST.Tvoid
                     {|cc_vararg:=(Some 1); cc_unproto:=false; cc_structret:=false|}))
     (Tcons tbool Tnil) tvoid
     {|cc_vararg:=(Some 1); cc_unproto:=false; cc_structret:=false|})) ::
 (___builtin_annot,
   Gfun(External (EF_builtin "__builtin_annot"
                   (mksignature (AST.Tint :: nil) AST.Tvoid
                     {|cc_vararg:=(Some 1); cc_unproto:=false; cc_structret:=false|}))
     (Tcons (tptr tschar) Tnil) tvoid
     {|cc_vararg:=(Some 1); cc_unproto:=false; cc_structret:=false|})) ::
 (___builtin_annot_intval,
   Gfun(External (EF_builtin "__builtin_annot_intval"
                   (mksignature (AST.Tint :: AST.Tint :: nil) AST.Tint
                     cc_default)) (Tcons (tptr tschar) (Tcons tint Tnil))
     tint cc_default)) ::
 (___builtin_membar,
   Gfun(External (EF_builtin "__builtin_membar"
                   (mksignature nil AST.Tvoid cc_default)) Tnil tvoid
     cc_default)) ::
 (___builtin_va_start,
   Gfun(External (EF_builtin "__builtin_va_start"
                   (mksignature (AST.Tint :: nil) AST.Tvoid cc_default))
     (Tcons (tptr tvoid) Tnil) tvoid cc_default)) ::
 (___builtin_va_arg,
   Gfun(External (EF_builtin "__builtin_va_arg"
                   (mksignature (AST.Tint :: AST.Tint :: nil) AST.Tvoid
                     cc_default)) (Tcons (tptr tvoid) (Tcons tuint Tnil))
     tvoid cc_default)) ::
 (___builtin_va_copy,
   Gfun(External (EF_builtin "__builtin_va_copy"
                   (mksignature (AST.Tint :: AST.Tint :: nil) AST.Tvoid
                     cc_default))
     (Tcons (tptr tvoid) (Tcons (tptr tvoid) Tnil)) tvoid cc_default)) ::
 (___builtin_va_end,
   Gfun(External (EF_builtin "__builtin_va_end"
                   (mksignature (AST.Tint :: nil) AST.Tvoid cc_default))
     (Tcons (tptr tvoid) Tnil) tvoid cc_default)) ::
 (___compcert_va_int32,
   Gfun(External (EF_external "__compcert_va_int32"
                   (mksignature (AST.Tint :: nil) AST.Tint cc_default))
     (Tcons (tptr tvoid) Tnil) tuint cc_default)) ::
 (___compcert_va_int64,
   Gfun(External (EF_external "__compcert_va_int64"
                   (mksignature (AST.Tint :: nil) AST.Tlong cc_default))
     (Tcons (tptr tvoid) Tnil) tulong cc_default)) ::
 (___compcert_va_float64,
   Gfun(External (EF_external "__compcert_va_float64"
                   (mksignature (AST.Tint :: nil) AST.Tfloat cc_default))
     (Tcons (tptr tvoid) Tnil) tdouble cc_default)) ::
 (___compcert_va_composite,
   Gfun(External (EF_external "__compcert_va_composite"
                   (mksignature (AST.Tint :: AST.Tint :: nil) AST.Tint
                     cc_default)) (Tcons (tptr tvoid) (Tcons tuint Tnil))
     (tptr tvoid) cc_default)) ::
 (___builtin_unreachable,
   Gfun(External (EF_builtin "__builtin_unreachable"
                   (mksignature nil AST.Tvoid cc_default)) Tnil tvoid
     cc_default)) ::
 (___builtin_expect,
   Gfun(External (EF_builtin "__builtin_expect"
                   (mksignature (AST.Tint :: AST.Tint :: nil) AST.Tint
                     cc_default)) (Tcons tint (Tcons tint Tnil)) tint
     cc_default)) ::
 (___compcert_i64_dtos,
   Gfun(External (EF_runtime "__compcert_i64_dtos"
                   (mksignature (AST.Tfloat :: nil) AST.Tlong cc_default))
     (Tcons tdouble Tnil) tlong cc_default)) ::
 (___compcert_i64_dtou,
   Gfun(External (EF_runtime "__compcert_i64_dtou"
                   (mksignature (AST.Tfloat :: nil) AST.Tlong cc_default))
     (Tcons tdouble Tnil) tulong cc_default)) ::
 (___compcert_i64_stod,
   Gfun(External (EF_runtime "__compcert_i64_stod"
                   (mksignature (AST.Tlong :: nil) AST.Tfloat cc_default))
     (Tcons tlong Tnil) tdouble cc_default)) ::
 (___compcert_i64_utod,
   Gfun(External (EF_runtime "__compcert_i64_utod"
                   (mksignature (AST.Tlong :: nil) AST.Tfloat cc_default))
     (Tcons tulong Tnil) tdouble cc_default)) ::
 (___compcert_i64_stof,
   Gfun(External (EF_runtime "__compcert_i64_stof"
                   (mksignature (AST.Tlong :: nil) AST.Tsingle cc_default))
     (Tcons tlong Tnil) tfloat cc_default)) ::
 (___compcert_i64_utof,
   Gfun(External (EF_runtime "__compcert_i64_utof"
                   (mksignature (AST.Tlong :: nil) AST.Tsingle cc_default))
     (Tcons tulong Tnil) tfloat cc_default)) ::
 (___compcert_i64_sdiv,
   Gfun(External (EF_runtime "__compcert_i64_sdiv"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil) AST.Tlong
                     cc_default)) (Tcons tlong (Tcons tlong Tnil)) tlong
     cc_default)) ::
 (___compcert_i64_udiv,
   Gfun(External (EF_runtime "__compcert_i64_udiv"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil) AST.Tlong
                     cc_default)) (Tcons tulong (Tcons tulong Tnil)) tulong
     cc_default)) ::
 (___compcert_i64_smod,
   Gfun(External (EF_runtime "__compcert_i64_smod"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil) AST.Tlong
                     cc_default)) (Tcons tlong (Tcons tlong Tnil)) tlong
     cc_default)) ::
 (___compcert_i64_umod,
   Gfun(External (EF_runtime "__compcert_i64_umod"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil) AST.Tlong
                     cc_default)) (Tcons tulong (Tcons tulong Tnil)) tulong
     cc_default)) ::
 (___compcert_i64_shl,
   Gfun(External (EF_runtime "__compcert_i64_shl"
                   (mksignature (AST.Tlong :: AST.Tint :: nil) AST.Tlong
                     cc_default)) (Tcons tlong (Tcons tint Tnil)) tlong
     cc_default)) ::
 (___compcert_i64_shr,
   Gfun(External (EF_runtime "__compcert_i64_shr"
                   (mksignature (AST.Tlong :: AST.Tint :: nil) AST.Tlong
                     cc_default)) (Tcons tulong (Tcons tint Tnil)) tulong
     cc_default)) ::
 (___compcert_i64_sar,
   Gfun(External (EF_runtime "__compcert_i64_sar"
                   (mksignature (AST.Tlong :: AST.Tint :: nil) AST.Tlong
                     cc_default)) (Tcons tlong (Tcons tint Tnil)) tlong
     cc_default)) ::
 (___compcert_i64_smulh,
   Gfun(External (EF_runtime "__compcert_i64_smulh"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil) AST.Tlong
                     cc_default)) (Tcons tlong (Tcons tlong Tnil)) tlong
     cc_default)) ::
 (___compcert_i64_umulh,
   Gfun(External (EF_runtime "__compcert_i64_umulh"
                   (mksignature (AST.Tlong :: AST.Tlong :: nil) AST.Tlong
                     cc_default)) (Tcons tulong (Tcons tulong Tnil)) tulong
     cc_default)) ::
 (___builtin_fmax,
   Gfun(External (EF_builtin "__builtin_fmax"
                   (mksignature (AST.Tfloat :: AST.Tfloat :: nil) AST.Tfloat
                     cc_default)) (Tcons tdouble (Tcons tdouble Tnil))
     tdouble cc_default)) ::
 (___builtin_fmin,
   Gfun(External (EF_builtin "__builtin_fmin"
                   (mksignature (AST.Tfloat :: AST.Tfloat :: nil) AST.Tfloat
                     cc_default)) (Tcons tdouble (Tcons tdouble Tnil))
     tdouble cc_default)) ::
 (___builtin_fmadd,
   Gfun(External (EF_builtin "__builtin_fmadd"
                   (mksignature
                     (AST.Tfloat :: AST.Tfloat :: AST.Tfloat :: nil)
                     AST.Tfloat cc_default))
     (Tcons tdouble (Tcons tdouble (Tcons tdouble Tnil))) tdouble
     cc_default)) ::
 (___builtin_fmsub,
   Gfun(External (EF_builtin "__builtin_fmsub"
                   (mksignature
                     (AST.Tfloat :: AST.Tfloat :: AST.Tfloat :: nil)
                     AST.Tfloat cc_default))
     (Tcons tdouble (Tcons tdouble (Tcons tdouble Tnil))) tdouble
     cc_default)) ::
 (___builtin_fnmadd,
   Gfun(External (EF_builtin "__builtin_fnmadd"
                   (mksignature
                     (AST.Tfloat :: AST.Tfloat :: AST.Tfloat :: nil)
                     AST.Tfloat cc_default))
     (Tcons tdouble (Tcons tdouble (Tcons tdouble Tnil))) tdouble
     cc_default)) ::
 (___builtin_fnmsub,
   Gfun(External (EF_builtin "__builtin_fnmsub"
                   (mksignature
                     (AST.Tfloat :: AST.Tfloat :: AST.Tfloat :: nil)
                     AST.Tfloat cc_default))
     (Tcons tdouble (Tcons tdouble (Tcons tdouble Tnil))) tdouble
     cc_default)) ::
 (___builtin_read16_reversed,
   Gfun(External (EF_builtin "__builtin_read16_reversed"
                   (mksignature (AST.Tint :: nil) AST.Tint16unsigned
                     cc_default)) (Tcons (tptr tushort) Tnil) tushort
     cc_default)) ::
 (___builtin_read32_reversed,
   Gfun(External (EF_builtin "__builtin_read32_reversed"
                   (mksignature (AST.Tint :: nil) AST.Tint cc_default))
     (Tcons (tptr tuint) Tnil) tuint cc_default)) ::
 (___builtin_write16_reversed,
   Gfun(External (EF_builtin "__builtin_write16_reversed"
                   (mksignature (AST.Tint :: AST.Tint :: nil) AST.Tvoid
                     cc_default)) (Tcons (tptr tushort) (Tcons tushort Tnil))
     tvoid cc_default)) ::
 (___builtin_write32_reversed,
   Gfun(External (EF_builtin "__builtin_write32_reversed"
                   (mksignature (AST.Tint :: AST.Tint :: nil) AST.Tvoid
                     cc_default)) (Tcons (tptr tuint) (Tcons tuint Tnil))
     tvoid cc_default)) ::
 (___builtin_debug,
   Gfun(External (EF_external "__builtin_debug"
                   (mksignature (AST.Tint :: nil) AST.Tvoid
                     {|cc_vararg:=(Some 1); cc_unproto:=false; cc_structret:=false|}))
     (Tcons tint Tnil) tvoid
     {|cc_vararg:=(Some 1); cc_unproto:=false; cc_structret:=false|})) ::
 (_encode_int63, Gfun(Internal f_encode_int63)) ::
 (_decode_int63, Gfun(Internal f_decode_int63)) ::
 (_int63_zero, Gfun(Internal f_int63_zero)) ::
 (_int63_one, Gfun(Internal f_int63_one)) ::
 (_int63_neg, Gfun(Internal f_int63_neg)) ::
 (_int63_abs, Gfun(Internal f_int63_abs)) ::
 (_int63_add, Gfun(Internal f_int63_add)) ::
 (_int63_sub, Gfun(Internal f_int63_sub)) ::
 (_int63_mul, Gfun(Internal f_int63_mul)) ::
 (_int63_div, Gfun(Internal f_int63_div)) ::
 (_int63_rem, Gfun(Internal f_int63_rem)) ::
 (_int63_shiftl, Gfun(Internal f_int63_shiftl)) ::
 (_int63_shiftr, Gfun(Internal f_int63_shiftr)) ::
 (_int63_or, Gfun(Internal f_int63_or)) ::
 (_int63_and, Gfun(Internal f_int63_and)) ::
 (_int63_xor, Gfun(Internal f_int63_xor)) ::
 (_int63_not, Gfun(Internal f_int63_not)) :: nil).

Definition public_idents : list ident :=
(_int63_not :: _int63_xor :: _int63_and :: _int63_or :: _int63_shiftr ::
 _int63_shiftl :: _int63_rem :: _int63_div :: _int63_mul :: _int63_sub ::
 _int63_add :: _int63_abs :: _int63_neg :: _int63_one :: _int63_zero ::
 _decode_int63 :: _encode_int63 :: ___builtin_debug ::
 ___builtin_write32_reversed :: ___builtin_write16_reversed ::
 ___builtin_read32_reversed :: ___builtin_read16_reversed ::
 ___builtin_fnmsub :: ___builtin_fnmadd :: ___builtin_fmsub ::
 ___builtin_fmadd :: ___builtin_fmin :: ___builtin_fmax ::
 ___compcert_i64_umulh :: ___compcert_i64_smulh :: ___compcert_i64_sar ::
 ___compcert_i64_shr :: ___compcert_i64_shl :: ___compcert_i64_umod ::
 ___compcert_i64_smod :: ___compcert_i64_udiv :: ___compcert_i64_sdiv ::
 ___compcert_i64_utof :: ___compcert_i64_stof :: ___compcert_i64_utod ::
 ___compcert_i64_stod :: ___compcert_i64_dtou :: ___compcert_i64_dtos ::
 ___builtin_expect :: ___builtin_unreachable :: ___compcert_va_composite ::
 ___compcert_va_float64 :: ___compcert_va_int64 :: ___compcert_va_int32 ::
 ___builtin_va_end :: ___builtin_va_copy :: ___builtin_va_arg ::
 ___builtin_va_start :: ___builtin_membar :: ___builtin_annot_intval ::
 ___builtin_annot :: ___builtin_sel :: ___builtin_memcpy_aligned ::
 ___builtin_sqrt :: ___builtin_fsqrt :: ___builtin_fabsf ::
 ___builtin_fabs :: ___builtin_ctzll :: ___builtin_ctzl :: ___builtin_ctz ::
 ___builtin_clzll :: ___builtin_clzl :: ___builtin_clz ::
 ___builtin_bswap16 :: ___builtin_bswap32 :: ___builtin_bswap ::
 ___builtin_bswap64 :: ___builtin_ais_annot :: nil).

Definition prog : Clight.program := 
  mkprogram composites global_definitions public_idents _main Logic.I.


(*
Input hashes (sha256):

41c9d05a4518bbf0c887dd95f8a09c4f97556e3cabf478295956af4818c55b46  src/c/include/coq-vsu-int63/src/int63.c
892b6571e863cb21ee031a66c13bcb86dc9fa0a56459a11130ab0087ec75de75  src/c/include/coq-vsu-int63/int63.h
*)
