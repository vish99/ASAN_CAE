; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel  -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32

define i8 @select_i8(i1 %test, i8 %a, i8 %b) {
; MIPS32-LABEL: select_i8:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    andi $1, $4, 1
; MIPS32-NEXT:    movn $6, $5, $1
; MIPS32-NEXT:    move $2, $6
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %cond = select i1 %test, i8 %a, i8 %b
  ret i8 %cond
}

define i16 @select_i16(i1 %test, i16 %a, i16 %b) {
; MIPS32-LABEL: select_i16:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    andi $1, $4, 1
; MIPS32-NEXT:    movn $6, $5, $1
; MIPS32-NEXT:    move $2, $6
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %cond = select i1 %test, i16 %a, i16 %b
  ret i16 %cond
}

define i32 @select_i32(i1 %test, i32 %a, i32 %b) {
; MIPS32-LABEL: select_i32:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    andi $1, $4, 1
; MIPS32-NEXT:    movn $6, $5, $1
; MIPS32-NEXT:    move $2, $6
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %cond = select i1 %test, i32 %a, i32 %b
  ret i32 %cond
}

define i32* @select_ptr(i1 %test, i32* %a, i32* %b) {
; MIPS32-LABEL: select_ptr:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    andi $1, $4, 1
; MIPS32-NEXT:    movn $6, $5, $1
; MIPS32-NEXT:    move $2, $6
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %cond = select i1 %test, i32* %a, i32* %b
  ret i32* %cond
}

define i32 @select_with_negation(i32 %a, i32 %b, i32 %x, i32 %y) {
; MIPS32-LABEL: select_with_negation:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    ori $1, $zero, 1
; MIPS32-NEXT:    slt $2, $4, $5
; MIPS32-NEXT:    xor $1, $2, $1
; MIPS32-NEXT:    andi $1, $1, 1
; MIPS32-NEXT:    movn $7, $6, $1
; MIPS32-NEXT:    move $2, $7
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %cmp = icmp slt i32 %a, %b
  %lneg = xor i1 %cmp, true
  %cond = select i1 %lneg, i32 %x, i32 %y
  ret i32 %cond
}

define i64 @select_i64(i1 %test, i64 %a, i64 %b) {
; MIPS32-LABEL: select_i64:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $sp, $sp, -8
; MIPS32-NEXT:    .cfi_def_cfa_offset 8
; MIPS32-NEXT:    addiu $1, $sp, 24
; MIPS32-NEXT:    lw $1, 0($1)
; MIPS32-NEXT:    addiu $2, $sp, 28
; MIPS32-NEXT:    lw $2, 0($2)
; MIPS32-NEXT:    andi $3, $4, 1
; MIPS32-NEXT:    movn $1, $6, $3
; MIPS32-NEXT:    movn $2, $7, $3
; MIPS32-NEXT:    sw $2, 4($sp) # 4-byte Folded Spill
; MIPS32-NEXT:    move $2, $1
; MIPS32-NEXT:    lw $3, 4($sp) # 4-byte Folded Reload
; MIPS32-NEXT:    addiu $sp, $sp, 8
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %cond = select i1 %test, i64 %a, i64 %b
  ret i64 %cond
}

define void @select_ambiguous_i64_in_fpr(i1 %test, i64* %i64_ptr_a, i64* %i64_ptr_b, i64* %i64_ptr_c) {
; MIPS32-LABEL: select_ambiguous_i64_in_fpr:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    ldc1 $f0, 0($5)
; MIPS32-NEXT:    ldc1 $f2, 0($6)
; MIPS32-NEXT:    andi $1, $4, 1
; MIPS32-NEXT:    movn.d $f2, $f0, $1
; MIPS32-NEXT:    sdc1 $f2, 0($7)
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %0 = load i64, i64* %i64_ptr_a, align 8
  %1 = load i64, i64* %i64_ptr_b, align 8
  %cond = select i1 %test, i64 %0, i64 %1
  store i64 %cond, i64* %i64_ptr_c, align 8
  ret void
}

define float @select_float(i1 %test, float %a, float %b) {
; MIPS32-LABEL: select_float:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mtc1 $5, $f0
; MIPS32-NEXT:    mtc1 $6, $f1
; MIPS32-NEXT:    andi $1, $4, 1
; MIPS32-NEXT:    movn.s $f1, $f0, $1
; MIPS32-NEXT:    mov.s $f0, $f1
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %cond = select i1 %test, float %a, float %b
  ret float %cond
}

define void @select_ambiguous_float_in_gpr(i1 %test, float* %f32_ptr_a, float* %f32_ptr_b, float* %f32_ptr_c) {
; MIPS32-LABEL: select_ambiguous_float_in_gpr:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    lw $1, 0($5)
; MIPS32-NEXT:    lw $2, 0($6)
; MIPS32-NEXT:    andi $3, $4, 1
; MIPS32-NEXT:    movn $2, $1, $3
; MIPS32-NEXT:    sw $2, 0($7)
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %0 = load float, float* %f32_ptr_a, align 4
  %1 = load float, float* %f32_ptr_b, align 4
  %cond = select i1 %test, float %0, float %1
  store float %cond, float* %f32_ptr_c, align 4
  ret void
}

define double @select_double(double %a, double %b, i1 %test) {
; MIPS32-LABEL: select_double:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $1, $sp, 16
; MIPS32-NEXT:    lw $1, 0($1)
; MIPS32-NEXT:    andi $1, $1, 1
; MIPS32-NEXT:    movn.d $f14, $f12, $1
; MIPS32-NEXT:    mov.d $f0, $f14
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %cond = select i1 %test, double %a, double %b
  ret double %cond
}
