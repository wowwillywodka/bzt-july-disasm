; $00256C..$002579 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 253A] step-on ct 0x27/0x28: эффект с флагами -0x6F59/-0x6F5C (тик-затухание)
        ifne *-$256C
        fail "ROM start moved"
        endif

LevelsRoutine_00256C:
        tst.b        -$6f53(a6)                                    ; $00256C
        beq.b        loc_002578                                    ; $002570
        tst.b        -$6f56(a6)                                    ; $002572
        beq.b        VideoRoutine_00257A                           ; $002576

loc_002578:
        rts                                                        ; $002578
        ifne *-$257A
        fail "ROM end moved"
        endif
