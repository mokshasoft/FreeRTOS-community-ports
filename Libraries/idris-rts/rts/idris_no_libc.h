#ifndef _IDRIS_NO_LIBC_H
#define _IDRIS_NO_LIBC_H

#undef assert
#define assert(...)
#define printf(...)
#define fprintf(...)

#define puts(...)
#define fflush(...)

#define abort(...)
#define exit(...)

#endif
