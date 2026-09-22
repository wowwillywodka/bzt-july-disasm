; $01EB4E..$01EBB5 | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1EB4E
        fail "ROM start moved"
        endif

DispatchRemoteActorUpdate:
        clr.w        d3                                            ; $01EB4E
        move.b       ActorRemoteKind(a0), d3                       ; $01EB50
        lsl.w        #$2, d3                                       ; $01EB54
        lea.l        ActorRemoteUpdateHandlers(pc), a1             ; $01EB56
        movea.l      (a1, d3.w), a1                                ; $01EB5A
        jmp          (a1)                                          ; $01EB5E

loc_01EB60:
        move.w       d5, -$6f26(a6)                                ; $01EB60
        move.w       d5, d2                                        ; $01EB64
        move.w       -$71d8(a6), d3                                ; $01EB66
        sub.w        -$6e4c(a6), d3                                ; $01EB6A
        sub.w        ActorZ(a0), d3                                ; $01EB6E
        muls.w       d3, d2                                        ; $01EB72
        asr.l        #$6, d2                                       ; $01EB74
        addi.w       #$28, d2                                      ; $01EB76
        movea.l      rZoneObjectTiles(a6), a1                      ; $01EB7A
        adda.w       #ObjectTileOffset01_FireEffect, a1            ; $01EB7E
        move.w       rGameTick(a6), d0                             ; $01EB82
        andi.w       #$1, d0                                       ; $01EB86
        move.w       d0, -$6f32(a6)                                ; $01EB8A
        clr.w        d0                                            ; $01EB8E
        move.b       ActorRemoteFrame(a0), d0                      ; $01EB90
        move.b       ActorRemoteDirectionRemap(pc, d0.w), d4       ; $01EB94
        move.w       d5, d0                                        ; $01EB98
        add.w        d5, d0                                        ; $01EB9A
        asr.w        d4, d0                                        ; $01EB9C
        move.w       d0, d4                                        ; $01EB9E
        asr.w        #$1, d4                                       ; $01EBA0
        sub.w        d4, d2                                        ; $01EBA2
        move.w       d4, d3                                        ; $01EBA4
        asr.w        #$1, d3                                       ; $01EBA6
        sub.w        d3, d1                                        ; $01EBA8
        move.l       a0, -(a7)                                     ; $01EBAA
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01EBAC
        movea.l      (a7)+, a0                                     ; $01EBB2
        rts                                                        ; $01EBB4
        ifne *-$1EBB6
        fail "ROM end moved"
        endif
