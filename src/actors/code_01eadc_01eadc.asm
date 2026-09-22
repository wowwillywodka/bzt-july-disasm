; $01EADC..$01EB4D | m68k
; Maintained assembly input; no extraction occurs during build.
        ifne *-$1EADC
        fail "ROM start moved"
        endif
        tst.b        -$55bd(a6)                                    ; $01EADC
        bne.b        loc_01EB2C                                    ; $01EAE0
        tst.b        -$55be(a6)                                    ; $01EAE2
        bne.b        loc_01EB0A                                    ; $01EAE6
        lea.l        -$6fdc(a6), a1                                ; $01EAE8
        move.b       #$6, (a1)+                                    ; $01EAEC
        move.b       ActorLinkId(a0), (a1)+                        ; $01EAF0
        move.w       d3, (a1)+                                     ; $01EAF4
        move.w       d4, (a1)+                                     ; $01EAF6
        move.w       d0, (a1)+                                     ; $01EAF8
        move.l       a0, -(a7)                                     ; $01EAFA
        lea.l        -$6fdc(a6), a0                                ; $01EAFC
        jsr          QueueLinkCommand.l                            ; $01EB00
        movea.l      (a7)+, a0                                     ; $01EB06
        rts                                                        ; $01EB08

loc_01EB0A:
        lea.l        -$6fdc(a6), a1                                ; $01EB0A
        move.b       #$7, (a1)+                                    ; $01EB0E
        move.b       ActorLinkId(a0), (a1)+                        ; $01EB12
        move.w       d3, (a1)+                                     ; $01EB16
        move.w       d4, (a1)+                                     ; $01EB18
        move.w       d0, (a1)+                                     ; $01EB1A
        move.l       a0, -(a7)                                     ; $01EB1C
        lea.l        -$6fdc(a6), a0                                ; $01EB1E
        jsr          QueueLinkCommand.l                            ; $01EB22
        movea.l      (a7)+, a0                                     ; $01EB28
        rts                                                        ; $01EB2A

loc_01EB2C:
        lea.l        -$6fdc(a6), a1                                ; $01EB2C
        move.b       #$1a, (a1)+                                   ; $01EB30
        move.b       ActorLinkId(a0), (a1)+                        ; $01EB34
        move.w       d3, (a1)+                                     ; $01EB38
        move.w       d4, (a1)+                                     ; $01EB3A
        move.w       d0, (a1)+                                     ; $01EB3C
        move.l       a0, -(a7)                                     ; $01EB3E
        lea.l        -$6fdc(a6), a0                                ; $01EB40
        jsr          QueueLinkCommand.l                            ; $01EB44
        movea.l      (a7)+, a0                                     ; $01EB4A
        rts                                                        ; $01EB4C
        ifne *-$1EB4E
        fail "ROM end moved"
        endif
