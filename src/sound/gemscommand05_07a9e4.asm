; $07A9E4..$07AA1F | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$7A9E4
        fail "ROM start moved"
        endif

GemsCommand05:
        jsr          BeginGemsCommand(pc)                          ; $07A9E4
        moveq        #$5, d0                                       ; $07A9E8
        jsr          SoundRoutine_07A8C8(pc)                       ; $07A9EA
        move.l       $8(a6), d0                                    ; $07A9EE
        jsr          WriteGemsCommandByte(pc)                      ; $07A9F2
        move.l       $c(a6), d0                                    ; $07A9F6
        jsr          WriteGemsCommandByte(pc)                      ; $07A9FA
        asr.l        #$8, d0                                       ; $07A9FE
        jsr          WriteGemsCommandByte(pc)                      ; $07AA00
        jmp          EndGemsCommand(pc)                            ; $07AA04
        jsr          BeginGemsCommand(pc)                          ; $07AA08
        moveq        #$6, d0                                       ; $07AA0C
        bra.b        loc_07A9B4                                    ; $07AA0E
        jsr          BeginGemsCommand(pc)                          ; $07AA10
        moveq        #$7, d0                                       ; $07AA14
        bra.b        loc_07A9B4                                    ; $07AA16
        jsr          BeginGemsCommand(pc)                          ; $07AA18
        moveq        #$e, d0                                       ; $07AA1C
        bra.b        loc_07A9B4                                    ; $07AA1E
        ifne *-$7AA20
        fail "ROM end moved"
        endif
