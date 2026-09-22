; $07AA50..$07AA71 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$7AA50
        fail "ROM start moved"
        endif

GemsReadStatusStackArgument:
        move.w       sr, -(a7)                                     ; $07AA50
        ori.w        #$700, sr                                     ; $07AA52
        jsr          AcquireZ80Bus(pc)                             ; $07AA56
        moveq        #$0, d0                                       ; $07AA5A
        move.b       $b(a7), d0                                    ; $07AA5C
        lea.l        $a01b22.l, a0                                 ; $07AA60
        move.b       (a0, d0.w), d0                                ; $07AA66
        jsr          ReleaseZ80Bus(pc)                             ; $07AA6A
        move.w       (a7)+, sr                                     ; $07AA6E
        rts                                                        ; $07AA70
        ifne *-$7AA72
        fail "ROM end moved"
        endif
