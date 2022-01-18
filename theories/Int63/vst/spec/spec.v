From appliedfm Require Import Int63.model.int63.
From appliedfm Require Import Int63.vst.ast.ast.
From VST Require Import floyd.proofauto.


Definition encode_int63_spec: ident * funspec :=
  DECLARE _encode_int63
  WITH x: Z, gv: globals
  PRE [ tlong ]
      PROP ( )
      PARAMS (Vlong (Int64.repr x))
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z x)))
      SEP ( ).

Definition decode_int63_spec: ident * funspec :=
  DECLARE _decode_int63
  WITH x: Z, gv: globals
  PRE [ tlong ]
      PROP (Int64.min_signed <= encode_Z x <= Int64.max_signed)
      PARAMS (Vlong (Int64.repr (encode_Z x)))
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr x))
      SEP ( ).


Definition int63_zero_spec: ident * funspec :=
  DECLARE _int63_zero
  WITH gv: globals
  PRE [ ]
      PROP ()
      PARAMS ()
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z 0)))
      SEP ( ).

Definition int63_one_spec: ident * funspec :=
  DECLARE _int63_one
  WITH gv: globals
  PRE [ ]
      PROP ()
      PARAMS ()
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z 1)))
      SEP ( ).

Definition int63_neg_spec: ident * funspec :=
  DECLARE _int63_neg
  WITH x: Z, gv: globals
  PRE [ tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z (- x) <= Int64.max_signed
      )
      PARAMS (Vlong (Int64.repr (encode_Z x)))
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (- x))))
      SEP ( ).

Definition int63_abs_spec: ident * funspec :=
  DECLARE _int63_abs
  WITH x: Z, gv: globals
  PRE [ tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z (- x) <= Int64.max_signed
      )
      PARAMS (Vlong (Int64.repr (encode_Z x)))
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (Z.abs x))))
      SEP ( ).

Definition int63_add_spec: ident * funspec :=
  DECLARE _int63_add
  WITH x: Z, y: Z, gv: globals
  PRE [ tlong, tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z y <= Int64.max_signed;
          Int64.min_signed <= encode_Z (x + y) < Int64.max_signed
      )
      PARAMS (
          Vlong (Int64.repr (encode_Z x));
          Vlong (Int64.repr (encode_Z y))
      )
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (x + y))))
      SEP ( ).

Definition int63_sub_spec: ident * funspec :=
  DECLARE _int63_sub
  WITH x: Z, y: Z, gv: globals
  PRE [ tlong, tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z y <= Int64.max_signed;
          Int64.min_signed <= encode_Z (x - y) <= Int64.max_signed
      )
      PARAMS (
          Vlong (Int64.repr (encode_Z x));
          Vlong (Int64.repr (encode_Z y))
      )
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (x - y))))
      SEP ( ).

Definition int63_mul_spec: ident * funspec :=
  DECLARE _int63_mul
  WITH x: Z, y: Z, gv: globals
  PRE [ tlong, tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z y <= Int64.max_signed;
          Int64.min_signed <= encode_Z (x * y) <= Int64.max_signed
      )
      PARAMS (
          Vlong (Int64.repr (encode_Z x));
          Vlong (Int64.repr (encode_Z y))
      )
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (x * y))))
      SEP ( ).

Definition int63_div_spec: ident * funspec :=
  DECLARE _int63_div
  WITH x: Z, y: Z, gv: globals
  PRE [ tlong, tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z y <= Int64.max_signed;
          y <> 0
      )
      PARAMS (
          Vlong (Int64.repr (encode_Z x));
          Vlong (Int64.repr (encode_Z y))
      )
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (Z.quot x y))))
      SEP ( ).

Definition int63_rem_spec: ident * funspec :=
  DECLARE _int63_rem
  WITH x: Z, y: Z, gv: globals
  PRE [ tlong, tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z y <= Int64.max_signed;
          y <> 0
      )
      PARAMS (
          Vlong (Int64.repr (encode_Z x));
          Vlong (Int64.repr (encode_Z y))
      )
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (Z.rem x y))))
      SEP ( ).

Definition int63_shiftl_spec: ident * funspec :=
  DECLARE _int63_shiftl
  WITH x: Z, y: Z, gv: globals
  PRE [ tlong, tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z y <= Int64.max_signed;
          0 <= x;
          0 <= y < Int64.zwordsize
      )
      PARAMS (
          Vlong (Int64.repr (encode_Z x));
          Vlong (Int64.repr (encode_Z y))
      )
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (Z.shiftl x y))))
      SEP ( ).

Definition int63_shiftr_spec: ident * funspec :=
  DECLARE _int63_shiftr
  WITH x: Z, y: Z, gv: globals
  PRE [ tlong, tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z y <= Int64.max_signed;
          0 <= y < Int64.zwordsize
      )
      PARAMS (
          Vlong (Int64.repr (encode_Z x));
          Vlong (Int64.repr (encode_Z y))
      )
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (Z.shiftr x y))))
      SEP ( ).

Definition int63_or_spec: ident * funspec :=
  DECLARE _int63_or
  WITH x: Z, y: Z, gv: globals
  PRE [ tlong, tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z y <= Int64.max_signed
      )
      PARAMS (
          Vlong (Int64.repr (encode_Z x));
          Vlong (Int64.repr (encode_Z y))
      )
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (Z.lor x y))))
      SEP ( ).

Definition int63_and_spec: ident * funspec :=
  DECLARE _int63_and
  WITH x: Z, y: Z, gv: globals
  PRE [ tlong, tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z y <= Int64.max_signed
      )
      PARAMS (
          Vlong (Int64.repr (encode_Z x));
          Vlong (Int64.repr (encode_Z y))
      )
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (Z.land x y))))
      SEP ( ).

Definition int63_xor_spec: ident * funspec :=
  DECLARE _int63_xor
  WITH x: Z, y: Z, gv: globals
  PRE [ tlong, tlong ]
      PROP (
          Int64.min_signed <= encode_Z x <= Int64.max_signed;
          Int64.min_signed <= encode_Z y <= Int64.max_signed
      )
      PARAMS (
          Vlong (Int64.repr (encode_Z x));
          Vlong (Int64.repr (encode_Z y))
      )
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (Z.lxor x y))))
      SEP ( ).

Definition int63_not_spec: ident * funspec :=
  DECLARE _int63_not
  WITH x: Z, gv: globals
  PRE [ tlong ]
      PROP (Int64.min_signed <= encode_Z x <= Int64.max_signed)
      PARAMS (Vlong (Int64.repr (encode_Z x)))
      GLOBALS(gv)
      SEP ( )
  POST [ tlong ]
      PROP ( )
      RETURN (Vlong (Int64.repr (encode_Z (Z.lnot x))))
      SEP ( ).


Definition ASI: funspecs := [
  decode_int63_spec;
  encode_int63_spec;
  int63_zero_spec;
  int63_one_spec;
  int63_neg_spec;
  int63_abs_spec;
  int63_add_spec;
  int63_sub_spec;
  int63_mul_spec;
  int63_div_spec;
  int63_rem_spec;
  int63_shiftl_spec;
  int63_shiftr_spec;
  int63_or_spec;
  int63_and_spec;
  int63_xor_spec;
  int63_not_spec
].
