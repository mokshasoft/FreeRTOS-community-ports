#include "print.h"
#include "math.h"
#include "idris_rts.h"
#include "idris_bitstring.h"
#include "idris_stdfgn.h"
void* _idris_assert_95_unreachable(VM*, VAL*);
void* _idris_call_95__95_IO(VM*, VAL*);
void* _idris_idris_95_crash(VM*, VAL*);
void* _idris_io_95_bind(VM*, VAL*);
void* _idris_Main_46_main(VM*, VAL*);
void* _idris_mkForeignPrim(VM*, VAL*);
void* _idris_prim_95__95_asPtr(VM*, VAL*);
void* _idris_prim_95__95_eqManagedPtr(VM*, VAL*);
void* _idris_prim_95__95_eqPtr(VM*, VAL*);
void* _idris_prim_95__95_managedNull(VM*, VAL*);
void* _idris_prim_95__95_null(VM*, VAL*);
void* _idris_prim_95__95_peek16(VM*, VAL*);
void* _idris_prim_95__95_peek32(VM*, VAL*);
void* _idris_prim_95__95_peek64(VM*, VAL*);
void* _idris_prim_95__95_peek8(VM*, VAL*);
void* _idris_prim_95__95_peekDouble(VM*, VAL*);
void* _idris_prim_95__95_peekPtr(VM*, VAL*);
void* _idris_prim_95__95_peekSingle(VM*, VAL*);
void* _idris_prim_95__95_poke16(VM*, VAL*);
void* _idris_prim_95__95_poke32(VM*, VAL*);
void* _idris_prim_95__95_poke64(VM*, VAL*);
void* _idris_prim_95__95_poke8(VM*, VAL*);
void* _idris_prim_95__95_pokeDouble(VM*, VAL*);
void* _idris_prim_95__95_pokePtr(VM*, VAL*);
void* _idris_prim_95__95_pokeSingle(VM*, VAL*);
void* _idris_prim_95__95_ptrOffset(VM*, VAL*);
void* _idris_prim_95__95_readChars(VM*, VAL*);
void* _idris_prim_95__95_readFile(VM*, VAL*);
void* _idris_prim_95__95_registerPtr(VM*, VAL*);
void* _idris_prim_95__95_sizeofPtr(VM*, VAL*);
void* _idris_prim_95__95_stderr(VM*, VAL*);
void* _idris_prim_95__95_stdin(VM*, VAL*);
void* _idris_prim_95__95_stdout(VM*, VAL*);
void* _idris_prim_95__95_vm(VM*, VAL*);
void* _idris_prim_95__95_writeFile(VM*, VAL*);
void* _idris_prim_95_io_95_bind(VM*, VAL*);
void* _idris_Utils_46_printInit(VM*, VAL*);
void* _idris_run_95__95_IO(VM*, VAL*);
void* _idris_unsafePerformPrimIO(VM*, VAL*);
void* _idris_Utils_46_vDirectPrintMsg(VM*, VAL*);
void* _idris__123_APPLY_95_0_125_(VM*, VAL*);
void* _idris__123_APPLY2_95_0_125_(VM*, VAL*);
void* _idris__123_EVAL_95_0_125_(VM*, VAL*);
void* _idris__123_runMain_95_0_125_(VM*, VAL*);
void* _idris_io_95_bind_95_IO_95__95_idr_95_108_95_34_95_108_95_36_95_case(VM*, VAL*);
void* _idris_assert_95_unreachable(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = NULL;
    TOPBASE(0);
    REBASE;
}

void* _idris_call_95__95_IO(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    LOC(3) = NULL_CON(0);
    RESERVE(2);
    TOP(0) = LOC(2);
    TOP(1) = LOC(3);
    SLIDE(vm, 2);
    TOPBASE(2);
    TAILCALL(_idris__123_APPLY_95_0_125_);
}

void* _idris_idris_95_crash(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = NULL;
    TOPBASE(0);
    REBASE;
}

void* _idris_io_95_bind(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RESERVE(2);
    TOP(0) = LOC(3);
    TOP(1) = LOC(5);
    STOREOLD;
    BASETOP(0);
    ADDTOP(2);
    CALL(_idris__123_APPLY_95_0_125_);
    LOC(6) = RVAL;
    RESERVE(2);
    TOP(0) = LOC(4);
    TOP(1) = LOC(6);
    STOREOLD;
    BASETOP(0);
    ADDTOP(2);
    CALL(_idris__123_APPLY_95_0_125_);
    LOC(6) = RVAL;
    RESERVE(2);
    TOP(0) = LOC(6);
    TOP(1) = LOC(5);
    SLIDE(vm, 2);
    TOPBASE(2);
    TAILCALL(_idris__123_APPLY_95_0_125_);
}

void* _idris_Main_46_main(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(2);
    ADDTOP(2);
    LOC(1) = MKINT(0);
    RESERVE(2);
    TOP(0) = LOC(1);
    TOP(1) = LOC(0);
    STOREOLD;
    BASETOP(0);
    ADDTOP(2);
    CALL(_idris_Utils_46_printInit);
    LOC(1) = RVAL;
    LOC(2) = MKSTR(vm, "Hello, Idris Unikernel""\x0a""");
    RESERVE(2);
    TOP(0) = LOC(2);
    TOP(1) = LOC(0);
    SLIDE(vm, 2);
    TOPBASE(2);
    TAILCALL(_idris_Utils_46_vDirectPrintMsg);
}

void* _idris_mkForeignPrim(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = NULL;
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_asPtr(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKPTR(vm, GETMPTR(LOC(0)));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_eqManagedPtr(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKINT((i_int)(GETMPTR(LOC(0)) == GETMPTR(LOC(1))));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_eqPtr(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKINT((i_int)(GETPTR(LOC(0)) == GETPTR(LOC(1))));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_managedNull(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKPTR(vm, NULL);
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_null(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKPTR(vm, NULL);
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_peek16(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_peekB16(vm,LOC(1),LOC(2));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_peek32(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_peekB32(vm,LOC(1),LOC(2));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_peek64(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_peekB64(vm,LOC(1),LOC(2));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_peek8(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_peekB8(vm,LOC(1),LOC(2));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_peekDouble(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_peekDouble(vm,LOC(1),LOC(2));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_peekPtr(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_peekPtr(vm,LOC(1),LOC(2));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_peekSingle(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_peekSingle(vm,LOC(1),LOC(2));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_poke16(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_pokeB16(LOC(1),LOC(2),LOC(3));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_poke32(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_pokeB32(LOC(1),LOC(2),LOC(3));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_poke64(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_pokeB64(LOC(1),LOC(2),LOC(3));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_poke8(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_pokeB8(LOC(1),LOC(2),LOC(3));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_pokeDouble(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_pokeDouble(LOC(1),LOC(2),LOC(3));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_pokePtr(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_pokePtr(LOC(1),LOC(2),LOC(3));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_pokeSingle(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_pokeSingle(LOC(1),LOC(2),LOC(3));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_ptrOffset(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKPTR(vm, (void *)((char *)GETPTR(LOC(0)) + GETINT(LOC(1))));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_readChars(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_readChars(vm, GETINT(LOC(1)), GETPTR(LOC(2)));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_readFile(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = idris_readStr(vm, GETPTR(LOC(1)));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_registerPtr(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKMPTR(vm, GETPTR(LOC(0)), GETINT(LOC(1)));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_sizeofPtr(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKINT(sizeof(void*));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_stderr(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKPTR(vm, stderr);
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_stdin(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKPTR(vm, stdin);
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_stdout(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKPTR(vm, stdout);
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_vm(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKPTR(vm, vm);
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95__95_writeFile(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKINT((i_int)(idris_writeStr(GETPTR(LOC(1)),GETSTR(LOC(2)))));
    TOPBASE(0);
    REBASE;
}

void* _idris_prim_95_io_95_bind(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RESERVE(2);
    TOP(0) = LOC(3);
    TOP(1) = LOC(2);
    SLIDE(vm, 2);
    TOPBASE(2);
    TAILCALL(_idris__123_APPLY_95_0_125_);
}

void* _idris_Utils_46_printInit(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = MKINT((i_int)(printInit(GETINT(LOC(0)))));
    TOPBASE(0);
    REBASE;
}

void* _idris_run_95__95_IO(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    LOC(2) = NULL_CON(0);
    RESERVE(2);
    TOP(0) = LOC(1);
    TOP(1) = LOC(2);
    SLIDE(vm, 2);
    TOPBASE(2);
    TAILCALL(_idris__123_APPLY_95_0_125_);
}

void* _idris_unsafePerformPrimIO(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = NULL;
    TOPBASE(0);
    REBASE;
}

void* _idris_Utils_46_vDirectPrintMsg(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    vDirectPrintMsg(GETSTR(LOC(0)));
    TOPBASE(0);
    REBASE;
}

void* _idris__123_APPLY_95_0_125_(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = NULL;
    TOPBASE(0);
    REBASE;
}

void* _idris__123_APPLY2_95_0_125_(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RVAL = NULL;
    TOPBASE(0);
    REBASE;
}

void* _idris__123_EVAL_95_0_125_(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    switch(TAG(LOC(0))) {
    default:
        RVAL = LOC(0);
        TOPBASE(0);
        REBASE;
        break;
    }
}

void* _idris__123_runMain_95_0_125_(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(3);
    ADDTOP(3);
    LOC(0) = MKINT(0);
    LOC(1) = NULL_CON(0);
    RESERVE(2);
    TOP(0) = LOC(0);
    TOP(1) = LOC(1);
    STOREOLD;
    BASETOP(0);
    ADDTOP(2);
    CALL(_idris_Utils_46_printInit);
    LOC(0) = RVAL;
    LOC(1) = MKSTR(vm, "Hello, Idris Unikernel""\x0a""");
    LOC(2) = NULL_CON(0);
    RESERVE(2);
    TOP(0) = LOC(1);
    TOP(1) = LOC(2);
    STOREOLD;
    BASETOP(0);
    ADDTOP(2);
    CALL(_idris_Utils_46_vDirectPrintMsg);
    LOC(0) = RVAL;
    RESERVE(1);
    TOP(0) = LOC(0);
    SLIDE(vm, 1);
    TOPBASE(1);
    TAILCALL(_idris__123_EVAL_95_0_125_);
}

void* _idris_io_95_bind_95_IO_95__95_idr_95_108_95_34_95_108_95_36_95_case(VM* vm, VAL* oldbase) {
    INITFRAME;
loop:
    RESERVE(1);
    ADDTOP(1);
    RESERVE(2);
    TOP(0) = LOC(7);
    TOP(1) = LOC(5);
    SLIDE(vm, 2);
    TOPBASE(2);
    TAILCALL(_idris__123_APPLY_95_0_125_);
}

