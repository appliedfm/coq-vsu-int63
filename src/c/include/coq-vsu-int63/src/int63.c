#ifndef COQ_VSU_INT63__INT63_C
#define COQ_VSU_INT63__INT63_C

#include "../int63.h"


int63_t encode_int63(int64_t x)
{
    return (x << 1) | 1;
}

int64_t decode_int63(int63_t x)
{
    return (int64_t)x >> 1;
}


int63_t int63_zero()
{
    return encode_int63(0);
}

int63_t int63_one()
{
    return encode_int63(1);
}

int63_t int63_neg(int63_t x)
{
    return 2 - x;
}

int63_t int63_abs(int63_t x)
{
    return x < 0 ? int63_neg(x) : x;
}

int63_t int63_add(int63_t x, int63_t y)
{
    return (x + y) - 1;
}

int63_t int63_sub(int63_t x, int63_t y)
{
    return (x - y) + 1;
}

int63_t int63_mul(int63_t x, int63_t y)
{
    const int64_t _x = decode_int63(x);
    const int64_t _y = decode_int63(y);
    const int64_t _z = _x * _y;
    return encode_int63(_z);
}

int63_t int63_div(int63_t x, int63_t y)
{
    const int64_t _x = decode_int63(x);
    const int64_t _y = decode_int63(y);
    const int64_t _z = _x / _y;
    return encode_int63(_z);
}

int63_t int63_rem(int63_t x, int63_t y)
{
    const int64_t _x = decode_int63(x);
    const int64_t _y = decode_int63(y);
    const int64_t _z = _x % _y;
    return encode_int63(_z);
}

int63_t int63_shiftl(int63_t x, int63_t y)
{
    const int64_t _x = decode_int63(x);
    const int64_t _y = decode_int63(y);
    const int64_t _z = _x << _y;
    return encode_int63(_z);
}

int63_t int63_shiftr(int63_t x, int63_t y)
{
    const int64_t _x = decode_int63(x);
    const int64_t _y = decode_int63(y);
    const int64_t _z = _x >> _y;
    return encode_int63(_z);
}

int63_t int63_or(int63_t x, int63_t y)
{
    return x | y;
}

int63_t int63_and(int63_t x, int63_t y)
{
    return x & y;
}

int63_t int63_xor(int63_t x, int63_t y)
{
    return (int63_t)1 | (x ^ y);
}

int63_t int63_not(int63_t x)
{
    return (int63_t)1 | ~ x;
}

#endif /* COQ_VSU_INT63__INT63_C */
