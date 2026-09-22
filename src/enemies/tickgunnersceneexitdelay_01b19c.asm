; $01B19C..$01B1B1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Decrement Byte52; at zero set rSceneExitRequested=1. Nonzero branch targets a shared RTS $1B7A6 in Denpyder code, not Denpyder behavior.20 UPDATE calls, not proven20 video frames.
        ifne *-$1B19C
        fail "ROM start moved"
        endif

TickGunnerSceneExitDelay:
; Decrement Byte52; at zero set rSceneExitRequested=1. Nonzero branch targets a shared RTS $1B7A6 in Denpyder code, not Denpyder behavior.20 UPDATE calls, not proven20 video frames.
        tst.b        ActorBehaviorByte52(a0)                       ; $01B19C
        beq.b        loc_01B198                                    ; $01B1A0
        subq.b       #$1, ActorBehaviorByte52(a0)                  ; $01B1A2
        bne.w        loc_01B7A6                                    ; $01B1A6
        move.w       #$1, rSceneExitRequested(a6)                  ; $01B1AA
        rts                                                        ; $01B1B0
        ifne *-$1B1B2
        fail "ROM end moved"
        endif
