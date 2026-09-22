; $01EBBC..$01EDAD | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1EBBC
        fail "ROM start moved"
        endif

loc_01EBBC:
        move.w       d5, -$6f26(a6)                                ; $01EBBC
        move.w       d5, d2                                        ; $01EBC0
        move.w       -$71d8(a6), d3                                ; $01EBC2
        sub.w        -$6e4c(a6), d3                                ; $01EBC6
        addi.w       #$20, d3                                      ; $01EBCA
        muls.w       d3, d2                                        ; $01EBCE
        asr.l        #$6, d2                                       ; $01EBD0
        addi.w       #$28, d2                                      ; $01EBD2
        movea.l      rZoneObjectTiles(a6), a1                      ; $01EBD6
        move.w       rGameTick(a6), d0                             ; $01EBDA
        andi.w       #$1, d0                                       ; $01EBDE
        move.w       d0, -$6f32(a6)                                ; $01EBE2
        clr.w        d0                                            ; $01EBE6
        move.b       ActorRemoteFrame(a0), d0                      ; $01EBE8
        neg.w        d0                                            ; $01EBEC
        addi.w       #$10, d0                                      ; $01EBEE
        muls.w       d0, d5                                        ; $01EBF2
        asr.l        #$4, d5                                       ; $01EBF4
        move.w       d5, d0                                        ; $01EBF6
        sub.w        d5, d2                                        ; $01EBF8
        move.w       d0, d4                                        ; $01EBFA
        asr.w        #$1, d4                                       ; $01EBFC
        move.w       d4, d3                                        ; $01EBFE
        asr.w        #$1, d3                                       ; $01EC00
        sub.w        d3, d1                                        ; $01EC02
        move.l       a0, -(a7)                                     ; $01EC04
        jsr          ScaleAndDrawSoftwareSpriteTile.l              ; $01EC06
        movea.l      (a7)+, a0                                     ; $01EC0C
        rts                                                        ; $01EC0E

loc_01EC10:
        move.w       d5, -$6f26(a6)                                ; $01EC10
        move.w       d5, d2                                        ; $01EC14
        move.w       -$71d8(a6), d3                                ; $01EC16
        sub.w        -$6e4c(a6), d3                                ; $01EC1A
        sub.w        ActorZ(a0), d3                                ; $01EC1E
        muls.w       d3, d2                                        ; $01EC22
        asr.l        #$6, d2                                       ; $01EC24
        addi.w       #$28, d2                                      ; $01EC26
        clr.w        d7                                            ; $01EC2A
        move.b       ActorRemoteFrame(a0), d7                      ; $01EC2C
        move.w       d7, d6                                        ; $01EC30
        movea.l      rZoneObjectTiles(a6), a1                      ; $01EC32
        adda.w       #ObjectTileOffset62_ProjectilePhases12, a1    ; $01EC36
        move.b       ActorLinkId(a0), d0                           ; $01EC3A
        andi.w       #$1, d0                                       ; $01EC3E
        move.w       d0, -$6f32(a6)                                ; $01EC42
        move.w       d5, d0                                        ; $01EC46
        move.w       d5, d4                                        ; $01EC48
        addi.w       #$100, d7                                     ; $01EC4A
        mulu.w       d7, d0                                        ; $01EC4E
        asr.l        #$8, d0                                       ; $01EC50
        neg.w        d6                                            ; $01EC52
        addi.w       #$100, d6                                     ; $01EC54
        mulu.w       d6, d4                                        ; $01EC58
        asr.l        #$8, d4                                       ; $01EC5A
        asr.w        #$3, d0                                       ; $01EC5C
        asr.w        #$4, d4                                       ; $01EC5E
        move.w       d4, d3                                        ; $01EC60
        asr.w        #$1, d3                                       ; $01EC62
        sub.w        d3, d1                                        ; $01EC64
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01EC66

loc_01EC6C:
        move.w       d5, -$6f26(a6)                                ; $01EC6C
        move.w       d5, d2                                        ; $01EC70
        move.w       -$71d8(a6), d3                                ; $01EC72
        sub.w        -$6e4c(a6), d3                                ; $01EC76
        sub.w        ActorZ(a0), d3                                ; $01EC7A
        muls.w       d3, d2                                        ; $01EC7E
        asr.l        #$6, d2                                       ; $01EC80
        addi.w       #$28, d2                                      ; $01EC82
        clr.w        d7                                            ; $01EC86
        move.b       ActorRemoteFrame(a0), d7                      ; $01EC88
        move.w       d7, d6                                        ; $01EC8C
        movea.l      rZoneObjectTiles(a6), a1                      ; $01EC8E
        adda.w       #ObjectTileOffset62_ProjectilePhases12, a1    ; $01EC92
        move.b       ActorLinkId(a0), d0                           ; $01EC96
        andi.w       #$1, d0                                       ; $01EC9A
        move.w       d0, -$6f32(a6)                                ; $01EC9E
        move.w       d5, d0                                        ; $01ECA2
        move.w       d5, d4                                        ; $01ECA4
        addi.w       #$80, d7                                      ; $01ECA6
        mulu.w       d7, d4                                        ; $01ECAA
        asr.l        #$7, d4                                       ; $01ECAC
        neg.w        d6                                            ; $01ECAE
        addi.w       #$100, d6                                     ; $01ECB0
        mulu.w       d6, d0                                        ; $01ECB4
        asr.l        #$8, d0                                       ; $01ECB6
        asr.w        #$4, d0                                       ; $01ECB8
        asr.w        #$3, d4                                       ; $01ECBA
        move.w       d0, d3                                        ; $01ECBC
        asr.w        #$1, d3                                       ; $01ECBE
        sub.w        d3, d2                                        ; $01ECC0
        move.w       d4, d3                                        ; $01ECC2
        asr.w        #$1, d3                                       ; $01ECC4
        sub.w        d3, d1                                        ; $01ECC6
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01ECC8

loc_01ECCE:
        move.w       d5, -$6f26(a6)                                ; $01ECCE
        move.w       d5, d2                                        ; $01ECD2
        move.w       -$71d8(a6), d3                                ; $01ECD4
        sub.w        -$6e4c(a6), d3                                ; $01ECD8
        sub.w        ActorZ(a0), d3                                ; $01ECDC
        muls.w       d3, d2                                        ; $01ECE0
        asr.l        #$6, d2                                       ; $01ECE2
        addi.w       #$28, d2                                      ; $01ECE4
        movea.l      rZoneObjectTiles(a6), a1                      ; $01ECE8
        adda.w       #ObjectTileOffset61_ProjectilePhase0, a1      ; $01ECEC
        move.b       ActorLinkId(a0), d0                           ; $01ECF0
        andi.w       #$1, d0                                       ; $01ECF4
        move.w       d0, -$6f32(a6)                                ; $01ECF8
        move.w       d5, d0                                        ; $01ECFC
        asr.w        #$2, d0                                       ; $01ECFE
        move.w       d0, d4                                        ; $01ED00
        asr.w        #$1, d4                                       ; $01ED02
        sub.w        d4, d2                                        ; $01ED04
        move.w       d4, d3                                        ; $01ED06
        asr.w        #$1, d3                                       ; $01ED08
        sub.w        d3, d1                                        ; $01ED0A
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01ED0C

loc_01ED12:
        move.w       d5, -$6f26(a6)                                ; $01ED12
        move.w       d5, d2                                        ; $01ED16
        move.w       -$71d8(a6), d3                                ; $01ED18
        sub.w        -$6e4c(a6), d3                                ; $01ED1C
        sub.w        ActorZ(a0), d3                                ; $01ED20
        muls.w       d3, d2                                        ; $01ED24
        asr.l        #$6, d2                                       ; $01ED26
        addi.w       #$28, d2                                      ; $01ED28
; Remote impact uses the same byte-subtract/word-shift address formula, but ActorRemoteFrame (+$44) replaces ActorState (+$38).
        movea.l      rZoneObjectTiles(a6), a1                      ; $01ED2C
        adda.w       #ObjectTileOffset63_ImpactFrame0, a1          ; $01ED30
        move.w       #$2, d0                                       ; $01ED34
        sub.b        ActorRemoteFrame(a0), d0                      ; $01ED38
        beq.b        loc_01ED44                                    ; $01ED3C
        lsl.w        #$8, d0                                       ; $01ED3E
        lsl.w        #$1, d0                                       ; $01ED40
        adda.w       d0, a1                                        ; $01ED42

loc_01ED44:
        clr.w        -$6f32(a6)                                    ; $01ED44
        move.w       d5, d0                                        ; $01ED48
        asr.w        #$2, d0                                       ; $01ED4A
        move.w       d0, d4                                        ; $01ED4C
        asr.w        #$1, d4                                       ; $01ED4E
        sub.w        d4, d2                                        ; $01ED50
        move.w       d4, d3                                        ; $01ED52
        asr.w        #$1, d3                                       ; $01ED54
        sub.w        d3, d1                                        ; $01ED56
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01ED58

loc_01ED5E:
        move.w       d5, -$6f26(a6)                                ; $01ED5E
        move.w       d5, d2                                        ; $01ED62
        move.w       -$71d8(a6), d3                                ; $01ED64
        sub.w        -$6e4c(a6), d3                                ; $01ED68
        sub.w        ActorZ(a0), d3                                ; $01ED6C
        muls.w       d3, d2                                        ; $01ED70
        asr.l        #$6, d2                                       ; $01ED72
        addi.w       #$28, d2                                      ; $01ED74
        clr.w        d0                                            ; $01ED78
        move.b       ActorRemoteFrame(a0), d0                      ; $01ED7A
        asr.w        #$1, d0                                       ; $01ED7E
        move.b       ActorRemoteFacingRemap(pc, d0.w), d0          ; $01ED80
        asr.w        d0, d5                                        ; $01ED84
        move.w       d5, d0                                        ; $01ED86
        move.w       d0, d4                                        ; $01ED88
        asr.w        #$1, d4                                       ; $01ED8A
        sub.w        d4, d2                                        ; $01ED8C
        move.w       d4, d3                                        ; $01ED8E
        asr.w        #$1, d3                                       ; $01ED90
        sub.w        d3, d1                                        ; $01ED92
        move.w       rGameTick(a6), d3                             ; $01ED94
        andi.w       #$1, d3                                       ; $01ED98
        move.w       d3, -$6f32(a6)                                ; $01ED9C
        movea.l      rZoneObjectTiles(a6), a1                      ; $01EDA0
        adda.w       #ObjectTileOffset01_FireEffect, a1            ; $01EDA4
        jmp          ScaleAndDrawSoftwareSpriteTile.l              ; $01EDA8
        ifne *-$1EDAE
        fail "ROM end moved"
        endif
