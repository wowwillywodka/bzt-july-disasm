; $07AC32..$07ACD3 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$7AC32
        fail "ROM start moved"
        endif

RetainedSoundStateReset:
        movea.l      (a7)+, a6                                     ; $07AC32
        move.l       a6, -(a6)                                     ; $07AC34
        move.l       #$ffffffff, $ff2a56.l                         ; $07AC36
        move.l       #$ffffffff, $ff2a5a.l                         ; $07AC40
        clr.w        ramStatusSoundScriptActive.l                                     ; $07AC4A

loc_07AC50:
        move.l       #$4, -(a7)                                    ; $07AC50
        move.l       #$f, -(a7)                                    ; $07AC56
        jsr          GemsSetDacRate(pc)                       ; $07AC5C
        addq.l       #$4, a7                                       ; $07AC60
        jsr          GemsReserveChannel(pc)                       ; $07AC62
        addq.l       #$4, a7                                       ; $07AC66
        lea.l        SoundEventRecords(pc), a0                     ; $07AC68
        clr.l        d0                                            ; $07AC6C
        move.w       #$5b, d0                                      ; $07AC6E
        lsl.w        #$1, d0                                       ; $07AC72
        addi.w       #$5c, d0                                      ; $07AC74
        move.b       (a0, d0.w), d0                                ; $07AC78
        move.l       d0, -(a7)                                     ; $07AC7C
        move.l       #$f, -(a7)                                    ; $07AC7E
        jsr          GemsSetChannelPatch(pc)                       ; $07AC84
        addq.l       #$8, a7                                       ; $07AC88
        lea.l        SoundChannelConfiguration(pc), a0             ; $07AC8A
        clr.l        d7                                            ; $07AC8E

loc_07AC90:
        clr.l        d0                                            ; $07AC90
        move.b       (a0)+, d0                                     ; $07AC92
        movem.l      d7/a0, -(a7)                                  ; $07AC94
        move.l       d0, -(a7)                                     ; $07AC98
        move.l       d7, -(a7)                                     ; $07AC9A
        addq.w       #$8, a7                                       ; $07AC9C
        movem.l      (a7)+, d7/a0                                  ; $07AC9E
        addq.l       #$1, d7                                       ; $07ACA2
        cmpi.w       #$10, d7                                      ; $07ACA4
        bcs.b        loc_07AC90                                    ; $07ACA8
        move.w       #$d, $ff2a54.l                                ; $07ACAA
        move.w       #$1, d0                                       ; $07ACB2

loc_07ACB6:
        move.w       d0, -(a7)                                     ; $07ACB6
        andi.l       #$ff, d0                                      ; $07ACB8
        addi.w       #$d, d0                                       ; $07ACBE
        move.l       d0, -(a7)                                     ; $07ACC2
        jsr          GemsReserveChannel(pc)                       ; $07ACC4
        addq.l       #$4, a7                                       ; $07ACC8
        move.w       (a7)+, d0                                     ; $07ACCA
        dbra         d0, loc_07ACB6                                ; $07ACCC
        movea.l      (a7)+, a6                                     ; $07ACD0
        rts                                                        ; $07ACD2
        ifne *-$7ACD4
        fail "ROM end moved"
        endif
