; $07A79A..$07A7D7 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; GEMS Z80-bus коммуникация July: захват шины (IO_Z80BUS=0x100, ждёт грант), запись в мейлбокс $A01B20, освобождение (=0)
        ifne *-$7A79A
        fail "ROM start moved"
        endif

RequestGemsMailbox:
        move.w       sr, -(a7)                                     ; $07A79A
        ori.w        #$700, sr                                     ; $07A79C

loc_07A7A0:
        move.w       #$100, Z80_BUS_REQUEST.l                      ; $07A7A0

loc_07A7A8:
        btst.b       #$0, Z80_BUS_REQUEST.l                        ; $07A7A8
        bne.b        loc_07A7A8                                    ; $07A7B0
        move.b       #$1, $a01b20.l                                ; $07A7B2
        move.b       $a01b21.l, d0                                 ; $07A7BA
        move.w       #$0, Z80_BUS_REQUEST.l                        ; $07A7C0
        tst.b        d0                                            ; $07A7C8
        beq.b        loc_07A7D4                                    ; $07A7CA
        moveq        #$44, d0                                      ; $07A7CC

loc_07A7CE:
        dbra         d0, loc_07A7CE                                ; $07A7CE
        bra.b        loc_07A7A0                                    ; $07A7D2

loc_07A7D4:
        move.w       (a7)+, sr                                     ; $07A7D4
        rts                                                        ; $07A7D6
        ifne *-$7A7D8
        fail "ROM end moved"
        endif
