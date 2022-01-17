#ifndef COQ_VSU_INT63__INT63_H
#define COQ_VSU_INT63__INT63_H

#include <stdint.h>

typedef int64_t int63_t;

int63_t encode_int63(int64_t x);
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
