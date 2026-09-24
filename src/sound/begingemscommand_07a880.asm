; $07A880..$07A8B5 | m68k
; Maintained assembly input; no extraction occurs during build.
; Acquire Z80 bus and prepare the host command ring: A0=$A00036 write
; index, A1=$A01B40 data, D1=current write index. The unusual return-
; address save keeps the caller's argument frame available at $8(A6).
        ifne *-$7A880
        fail "ROM start moved"
        endif

BeginGemsCommand:
        movea.l      (a7)+, a0                                     ; $07A880
        link.w       a6, #$0                                       ; $07A882
        movem.l      d1/a1, -(a7)                                  ; $07A886
        move.w       sr, -(a7)                                     ; $07A88A
        move.l       a0, -(a7)                                     ; $07A88C
        lea.l        $a00036.l, a0                                 ; $07A88E
        lea.l        $a01b40.l, a1                                 ; $07A894
        ori.w        #$700, sr                                     ; $07A89A
        move.w       #$100, Z80_BUS_REQUEST.l                      ; $07A89E

loc_07A8A6:
        btst.b       #$0, Z80_BUS_REQUEST.l                        ; $07A8A6
        bne.b        loc_07A8A6                                    ; $07A8AE
        move.b       (a0), d1                                      ; $07A8B0
        ext.w        d1                                            ; $07A8B2
        rts                                                        ; $07A8B4
        ifne *-$7A8B6
        fail "ROM end moved"
        endif
