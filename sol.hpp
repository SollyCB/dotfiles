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
#include <stdio.h> // @Todo implement my own streaming to stdout and get rid of printf
#include <iostream> // see ASSERT() macro
#include <string.h>
#include <assert.h> // @Todo get rid of this asserting
#include <cstdarg>

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

    /* Sorting */
void sort_high_low(int *array, int start, int end) {
    if (start < end) {
        int x = start - 1;
        int tmp;
        for(int i = start; i <= end; ++i) {
            if (array[i] > array[end]) {
                tmp = array[i];
                x++;
                array[i] = array[x];
                array[x] = tmp;
            }
        }
        x++;
        tmp = array[end];
        array[end] = array[x];
        array[x] = tmp;
        sort_high_low(array, start, x - 1);
        sort_high_low(array, x + 1, end);
    }
}
void sort_low_high(int *array, int start, int end) {
    if (start < end) {
        int x = start - 1;
        int tmp;
        for(int i = start; i <= end; ++i) {
            if (array[i] < array[end]) {
                tmp = array[i];
                x++;
                array[i] = array[x];
                array[x] = tmp;
            }
        }
        x++;
        tmp = array[end];
        array[end] = array[x];
        array[x] = tmp;
        sort_low_high(array, start, x - 1);
        sort_low_high(array, x + 1, end);
    }
}

    /* print */
static const u64 PRINT_FORMATTER_BUF_LEN = 1024;

static inline s32 print_parse_signed_int(const char *str, u32 len, char *buf, s64 num) {
    u32 end = 0;
    char rev[200];

    if (num == 0) {
        rev[0] = '0';
        end++;
        goto loop_end; // @Hack
    }

    if (num < 0) {
        buf[0] = '-';
        buf++;
        end++;
        num = -num;
    }

    char c;
    u8 val;
    while(num > 0) {
        val = num % 10;
        num /= 10;
        switch(val) {
        case 0:
        {
            c = '0';
            break;
        }
        case 1:
        {
            c = '1';
            break;
        }
        case 2:
        {
            c = '2';
            break;
        }
        case 3:
        {
            c = '3';
            break;
        }
        case 4:
        {
            c = '4';
            break;
        }
        case 5:
        {
            c = '5';
            break;
        }
        case 6:
        {
            c = '6';
            break;
        }
        case 7:
        {
            c = '7';
            break;
        }
        case 8:
        {
            c = '8';
            break;
        }
        case 9:
        {
            c = '9';
            break;
        }
        default:
            assert(false && "this is not a number i can use");
        }
        rev[end] = c;
        end++;
    }

    loop_end:
    for(int i = 0; i < end; ++i) {
        buf[i] = rev[(end - 1) - i];
    }
    return end;
}
static inline s32 print_parse_unsigned_int(const char *str, u32 len, char *buf, u64 num) {
    u32 end = 0;

    char rev[200];

    char c;
    u8 val;
    if (num == 0) {
        rev[0] = '0';
        end++;
        goto loop_end; // @Hack
    }

    while(num > 0) {
        val = num % 10;
        num /= 10;
        switch(val) {
        case 0:
        {
            c = '0';
            break;
        }
        case 1:
        {
            c = '1';
            break;
        }
        case 2:
        {
            c = '2';
            break;
        }
        case 3:
        {
            c = '3';
            break;
        }
        case 4:
        {
            c = '4';
            break;
        }
        case 5:
        {
            c = '5';
            break;
        }
        case 6:
        {
            c = '6';
            break;
        }
        case 7:
        {
            c = '7';
            break;
        }
        case 8:
        {
            c = '8';
            break;
        }
        case 9:
        {
            c = '9';
            break;
        }
        default:
            assert(false && "this is not a number i can use");
        }
        rev[end] = c;
        end++;
    }

    loop_end: // goto label
    for(int i = 0; i < end; ++i) {
        buf[i] = rev[(end - 1) - i];
    }

    return end;
}
static inline u64 print_parse_string(const char *str, u32 len, char *buf, const char* cstr) {
    u64 str_len = strlen(cstr);
    strcpy(buf, cstr);
    return str_len;
}

static void println(const char* str, ...) {
    va_list args;
    va_start(args, str);

    char buf[PRINT_FORMATTER_BUF_LEN];
    u32 buf_index = 0;

    u64 len = strlen(str);
    s32 size;

    s64 s;
    u64 u;
    const char *cstr;

    bool skip = false;
    for(int i = 0; i < len; ++i) {

        if (str[i] == '\\' && skip) {
            buf[buf_index] = '\\';
            buf_index++;
            skip = false;
            continue;
        }
        if (str[i] == '\\') {
            skip = true;
            //buf_index++;
            continue;
        }
        if (str[i] == '%' && skip) {
            buf[buf_index] = str[i];
            buf_index++;
            skip = false;
            continue;
        }
        if (str[i] != '%') {
            buf[buf_index] = str[i];
            buf_index++;
            skip = false;
            continue;
        }
        skip = false;

        i++;
        switch(str[i]) {
        case 's':
        {
            s = va_arg(args, s64);
            size = print_parse_signed_int(str + i, len - i, buf + buf_index, s);
            buf_index += size;
            break;
        }
        case 'u':
        {
            u = va_arg(args, u64);
            size = print_parse_unsigned_int(str + i, len - i, buf + buf_index, u);
            buf_index += size;
            break;
        }
        case 'c':
        {
            cstr = va_arg(args, const char*);
            size = print_parse_string(str + i, len - i, buf + buf_index, cstr);
            buf_index += size;
            break;
        }
        default:
            assert(false && "Cannot understand print statement");
        } // switch str[i]
    }

    va_end(args);

    buf[buf_index] = '\n';
    buf[buf_index + 1] = '\0';
    printf("%s", buf);
}

static void print(const char* str, ...) {
    va_list args;
    va_start(args, str);

    char buf[PRINT_FORMATTER_BUF_LEN];
    u32 buf_index = 0;

    u64 len = strlen(str);
    s32 size;

    s64 s;
    u64 u;
    const char *cstr;

    bool skip = false;
    for(int i = 0; i < len; ++i) {

        if (str[i] == '\\' && skip) {
            buf[buf_index] = '\\';
            skip = false;
            buf_index++;
            continue;
        }
        if (str[i] == '\\') {
            skip = true;
            buf_index++;
            continue;
        }
        if (str[i] != '%') {
            buf[buf_index] = str[i];
            buf_index++;
            skip = false;
            continue;
        }
        if (str[i] == '%' && skip) {
            buf[buf_index] = '%';
            buf_index++;
            skip = false;
            continue;
        }
        skip = false;

        i++;
        switch(str[i]) {
        case 's':
        {
            s = va_arg(args, s64);
            size = print_parse_signed_int(str + i, len - i, buf + buf_index, s);
            buf_index += size;
            break;
        }
        case 'u':
        {
            u = va_arg(args, u64);
            size = print_parse_unsigned_int(str + i, len - i, buf + buf_index, u);
            buf_index += size;
            break;
        }
        case 'c':
        {
            cstr = va_arg(args, const char*);
            size = print_parse_string(str + i, len - i, buf + buf_index, cstr);
            buf_index += size;
            break;
        }
        default:
            assert(false && "Cannot understand print statement");
        } // switch str[i]
    }

    va_end(args);

    buf[buf_index] = '\0';
    printf("%s", buf);
}

#if DEBUG
static void dbg_println(const char* str, ...) {
    va_list args;
    va_start(args, str);

    char buf[PRINT_FORMATTER_BUF_LEN];
    u32 buf_index = 0;

    u64 len = strlen(str);
    s32 size;

    s64 s;
    u64 u;
    const char *cstr;

    bool skip = false;
    for(int i = 0; i < len; ++i) {

        if (str[i] == '\\' && skip) {
            buf[buf_index] = '\\';
            skip = false;
            buf_index++;
            continue;
        }
        if (str[i] == '\\') {
            skip = true;
            buf_index++;
            continue;
        }
        if (str[i] != '%') {
            buf[buf_index] = str[i];
            buf_index++;
            skip = false;
            continue;
        }
        if (str[i] == '%' && skip) {
            buf[buf_index] = '%';
            buf_index++;
            skip = false;
            continue;
        }
        skip = false;

        i++;
        switch(str[i]) {
        case 's':
        {
            s = va_arg(args, s64);
            size = print_parse_signed_int(str + i, len - i, buf + buf_index, s);
            buf_index += size;
            break;
        }
        case 'u':
        {
            u = va_arg(args, u64);
            size = print_parse_unsigned_int(str + i, len - i, buf + buf_index, u);
            buf_index += size;
            break;
        }
        case 'c':
        {
            cstr = va_arg(args, const char*);
            size = print_parse_string(str + i, len - i, buf + buf_index, cstr);
            buf_index += size;
            break;
        }
        default:
            assert(false && "Cannot understand print statement");
        } // switch str[i]
    }

    va_end(args);

    buf[buf_index] = '\0';
    printf("%s\n", buf);
}
#else
#define dbg_println(str, ...)
#endif

#ifndef _WIN32
    #define HALT_EXECUTION() __builtin_trap()
#else
    #define HALT_EXECUTION() abort() // @Todo get rid of abort on windows
#endif
#if DEBUG
    // For some reason if I dont use the cout lameness, avx strcmp fails on the compiler pos builtins.
    #define ASSERT(predicate, fmt) if (!(predicate)) { \
        std::cout << "Assert Failed in " << __FILE__ << ", " << __FUNCTION__ << "(...), Line " \
        << __LINE__ << ": " << #predicate << ", " << fmt << '\n'; \
        HALT_EXECUTION(); \
    }
    //#define ASSERT(predicate, fmt) if (!(predicate)) { \
        //println("Assert Failed in %c, %c(..), Line %c: %c, %c", __FILE__, __FUNCTION__, __LINE__, #predicate, fmt); \
        //HALT_EXECUTION(); \
    //}
#else
    #define ASSERT(predicate, fmt, ...) {}
#endif

// @Todo Allocator - BIG TIME, omg... look at how lame this is...
#define malloc_h(sz, a) malloc(sz)
#define free_h(ptr) free(ptr)
#define malloc_t(sz, a) malloc(sz)
static inline size_t align(size_t size, size_t alignment) {
  const size_t alignment_mask = alignment - 1;
  return (size + alignment_mask) & ~alignment_mask;
}

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

// SIMD -- @Todo @Note find_flags + update flags function are out of date, having an overlap bug
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

    /* File */
const u8* file_read_char(const char *file_name, u64 *size);

#ifdef SOL_HPP_IMPLEMENTATION

    /* File Impl */
const u8* file_read_char(const char *file_name, u64 *size) {
    FILE *file = fopen(file_name, "r");

    if (!file) {
        println("FAILED TO READ FILE %c", file_name);
        return nullptr;
    }

    fseek(file, 0, SEEK_END);
    *size = ftell(file);
    fseek(file, 0, SEEK_SET);

    void *contents = malloc_h(*size, 8); // 8 byte aligned as contents of file may need to be aligned

    // idk if it is worth checking the returned size? It seems to be wrong on windows
    //fread(contents, 1, *size, file);
    size_t read = fread(contents, 1, *size, file);

    if (*size != read) {
        println("Failed to read entire file, %c", file_name);
        println("    File Size: %u, Size Read: %u", *size, read);
    }

    //ASSERT(read == *byte_count, "Failed to read entire file: read = %i, file_len = %i", read, *byte_count);
    fclose(file);

    return (u8*)contents;
}


#endif // implementation guard
#endif // include guard
