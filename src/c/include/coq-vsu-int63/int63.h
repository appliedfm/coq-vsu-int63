/*! @mainpage
 *
 * @section sec_intro Introduction
 *
 * A <a href="https://github.com/appliedfm/coq-vsu">Verified Software Unit</a> for 63-bit integer arithmetic.
 *
 * Implemented in C, modeled in <a href="https://coq.inria.fr">Coq</a>, and proven correct using the
 * <a href="https://vst.cs.princeton.edu/">Verified Software Toolchain</a>.
 *
 * Compatible with <a href="https://compcert.org/">CompCert</a>.
 *
 * @section sec_using Using the C library
 *
 * To use the library, simply include the header file:
 * @code
 *   #include <coq-vsu-int63/int63.h>
 * @endcode
 *
 * Alternatively, you can include the entire implementation:
 * @code
 *   #include <coq-vsu-int63/src/int63.c>
 * @endcode
 *
 * The library is installed to the location given by `vsu -I`. You can bring this location into your compiler's search path by passing ``-I`vsu -I``` to your compiler at build time.
 *
 * An API reference is provided in int63.h.
 *
 */
#ifndef COQ_VSU_INT63__INT63_H
#define COQ_VSU_INT63__INT63_H

#include <stdint.h>

typedef int64_t int63_t;    ///< An encoded 63-bit integer.

/** @brief Encode an integer.
 *
 *  @param x The integer to encode.
 *  @return The encoded integer.
 */
int63_t encode_int63(int64_t x);

/** @brief Decode an integer.
 *
 *  @param x The integer to decode.
 *  @return The decoded integer.
 */
int64_t decode_int63(int63_t x);

int63_t int63_zero();
int63_t int63_one();
int63_t int63_neg(int63_t x);
int63_t int63_abs(int63_t x);
int63_t int63_add(int63_t x, int63_t y);
int63_t int63_sub(int63_t x, int63_t y);
int63_t int63_mul(int63_t x, int63_t y);
int63_t int63_div(int63_t x, int63_t y);
int63_t int63_rem(int63_t x, int63_t y);
int63_t int63_shiftl(int63_t x, int63_t y);
int63_t int63_shiftr(int63_t x, int63_t y);
int63_t int63_or(int63_t x, int63_t y);
int63_t int63_and(int63_t x, int63_t y);
int63_t int63_xor(int63_t x, int63_t y);
int63_t int63_not(int63_t x);

#endif /* COQ_VSU_INT63__INT63_H */
