#ifndef SOL_HPP_INCLUDE_GUARD_
#define SOL_HPP_INCLUDE_GUARD_

/*
    TODOS:
        allocator - reimplement the tlsf stuff
        hash_map  - get wyhash in
        test
        image     - might as well
*/

#include <immintrin.h>

#include <cstring>
#include <cstdint>

// type defs/convenience size defines
typedef unsigned int uint;
typedef unsigned char uchar;

typedef  uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;

typedef   int8_t s8;
typedef  int16_t s16;
typedef  int32_t s32;
typedef  int64_t s64;

typedef u32 bool32;

#define Max_u64 UINT64_MAX
#define Max_u32 UINT32_MAX
#define Max_u16 UINT16_MAX
#define Max_u8  UINT8_MAX
#define Max_s64  INT64_MAX
#define Max_s32  INT32_MAX
#define Max_s16  INT16_MAX
#define Max_s8   INT8_MAX


/* builtin wrappers (why the fuck do they differ between compilers!!! the world is retarded) */
#ifndef _WIN32
    /* bit manipulation */
inline int count_trailing_zeros_u16(unsigned short a) {
    // @Note This has to be copied between compiler directives because gcc will not compile
    // tzcnt16 with only one leading undescore. I assume this is a compiler bug, because tzcnt32
    // and 64 both want one leading underscore...
    return (int)__tzcnt_u16(a);
}
inline int count_trailing_zeros_u32(unsigned int a) {
    return (int)_tzcnt_u32(a);
}
inline int count_trailing_zeros_u64(u64 a) {
    return (int)_tzcnt_u64(a);
}
inline int count_leading_zeros_u16(u16 mask) {
    return __builtin_clzs(mask);
}
inline int count_leading_zeros_u32(u32 mask) {
    return __builtin_clzl(mask);
}
inline int count_leading_zeros_u64(u64 mask) {
    return __builtin_clzll(mask);
}
inline int pop_count16(u16 num) {
    u32 tmp = num;
    tmp &= 0x0000ffff; // just to be sure;
    return (int)__builtin_popcount(tmp);
}
inline int pop_count32(u32 num) {
    return (int)__builtin_popcountl(num);
}
inline int pop_count64(u64 num) {
    return (int)__builtin_popcountll(num);
}

    /* builtin wrapper math */
inline float sqrtf(float num) {
    return __builtin_sqrtf(num); // @Todo add for windows (I cannot find builtin for windows)
}
inline float sinf(float x) {
    return __builtin_sinf(x);
}
inline float asinf(float x) {
    return __builtin_asinf(x);
}
inline float cosf(float x) {
    return __builtin_cosf(x);
}
inline float acosf(float x) {
    return __builtin_acosf(x);
}
#else
inline int count_trailing_zeros_u16(unsigned short a) {
    return (int)_tzcnt_u16(a);
}
inline int count_trailing_zeros_u32(unsigned int a) {
    return (int)_tzcnt_u32(a);
}
inline int count_trailing_zeros_u64(u64 a) {
    return (int)_tzcnt_u64(a);
}
inline int count_leading_zeros_u16(u16 mask) {
    return __lzcnt16(mask);
}
inline int count_leading_zeros_u32(u32 mask) {
    return __lzcnt(mask);
}
inline int count_leading_zeros_u64(u64 mask) {
    return __lzcnt64(mask);
}
inline int pop_count16(u16 num) {
    return (int)__popcnt16(num);
}
inline int pop_count32(u32 num) {
    return (int)__popcnt(num);
}
inline int pop_count64(u64 num) {
    return (int)__popcnt64(num);
}

// math
inline float sinf(float x) {
    return sinf(x);
}
inline float asinf(float x) {
    return asinf(x);
}
inline float cosf(float x) {
    return cosf(x);
}
inline float acosf(float x) {
    return acosf(x);
}
#endif // WIN32 or not

    /* string */
struct String {
    u32 len;
    const char *str;
};
inline static String cstr_to_string(const char *cstr) {
    String string;
    string.str = cstr;
    string.len = strlen(cstr);
    return string;
}

struct String_Buffer {
    char *buf;
    u32 len;
    u32 cap;
};
inline static String_Buffer create_string_buffer(u32 size, bool temp = false) {
    String_Buffer ret;
    ret.len = 0;
    size = align(size, 16); // Just in case of some simd
    ret.cap = size;
    if (temp)
        ret.buf = (char*)malloc_t(size, 16);
    else
        ret.buf = (char*)malloc_h(size, 16); // static predict heap
    return ret;
}
inline static void destroy_string_buffer(String_Buffer *buf) {
    free_h(buf->buf);
    *buf = {};
}
inline static String string_buffer_get_string(String_Buffer *buf, String *str) {
    String ret = {};
    ret.len = str->len;
    ret.str = (const char*)(buf->buf + buf->len);

    buf->len += ret.len + 1; // +1 for null byte
    ASSERT(buf->len <= buf->cap, "String Buffer Overflow");
    memcpy((char*)ret.str, str->str, ret.len); // copy null byte
    char *tmp = (char*)ret.str;
    tmp[ret.len] = '\0';

    return ret;
}
inline static String string_buffer_get_string(String_Buffer *buf, const char *cstr) {
    String ret = {};
    ret.len = strlen(cstr);
    ret.str = (const char*)(buf->buf + buf->len);

    buf->len += ret.len + 1; // +1 for null byte
    ASSERT(buf->len <= buf->cap, "String Buffer Overflow");
    memcpy((char*)ret.str, cstr, ret.len + 1); // copy null byte

    return ret;
}

// SIMD
inline static u32 simd_find_update_flags_u8(u32 count, u8 *flags, u8 find, u8 negate, u8 set, u8 clear, u32 *indices) {
    __m128i a;
    __m128i b = _mm_set1_epi8(find | negate);
    __m128i c = _mm_set1_epi8(find);
    __m128i d;
    __m128i e;
    u16 mask;
    u32 pc;
    u32 tz;
    u32 cnt = 0;
    u32 inc = 0;
    while(inc < count) {
        a = _mm_load_si128((__m128i*)(flags + inc));
        d = _mm_and_si128(a, b);
        d = _mm_cmpeq_epi8(d, c);
        mask = _mm_movemask_epi8(d);

        e = _mm_set1_epi8(clear);
        e = _mm_and_si128(e, d);
        a = _mm_and_si128(a, ~e);
        e = _mm_set1_epi8(set);
        e = _mm_and_si128(e, d);
        a = _mm_or_si128(a, e);
        _mm_store_si128((__m128i*)(flags + inc), a);

        pc = pop_count16(mask);
        for(u32 i = 0; i < pc; ++i) {
            tz = count_trailing_zeros_u16(mask);
            indices[cnt] = tz + inc;
            mask ^= 1 << tz;
            cnt++;
        }
        inc += 16;
    }
    return cnt;
}
inline static u32 simd_find_flags_u8(u32 count, u8 *flags, u8 find, u8 negate, u32 *indices) {
    __m128i a;
    __m128i b = _mm_set1_epi8(find | negate);
    __m128i c = _mm_set1_epi8(find);
    u16 mask;
    u32 pc;
    u32 tz;
    u32 cnt = 0;
    u32 inc = 0;
    while(inc < count) {
        a = _mm_load_si128((__m128i*)(flags + inc));
        a = _mm_and_si128(a, b);
        a = _mm_cmpeq_epi8(a, c);
        mask = _mm_movemask_epi8(a);
        pc = pop_count16(mask);
        for(u32 i = 0; i < pc; ++i) {
            tz = count_trailing_zeros_u16(mask);
            indices[cnt] = tz + inc;
            mask ^= 1 << tz;
            cnt++;
        }
        inc += 16;
    }
    return cnt;
}
#ifdef SOL_HPP_IMPLEMENTATION

#endif // implementation guard
#endif // include guard
