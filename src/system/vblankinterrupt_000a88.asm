; $000A88..$000BCB | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; VBLANK-обработчик: каскад игровых часов, звуковые таймеры и две фазы VDP-передачи через ramVBlankTransferPhasesRemaining.
        ifne *-$A88
        fail "ROM start moved"
        endif

VBlankInterrupt:
        tst.b        rPauseFlags(a6)                               ; $000A88
        bne.b        loc_000AC2                                    ; $000A8C
        addq.b       #$1, rGameClockFrameTicks(a6)                               ; $000A8E
        cmpi.b       #$3c, rGameClockFrameTicks(a6)                              ; $000A92
        bne.b        loc_000AC2                                    ; $000A98
        clr.b        rGameClockFrameTicks(a6)                                    ; $000A9A
        addq.b       #$1, rGameClockSeconds(a6)                               ; $000A9E
        cmpi.b       #$3c, rGameClockSeconds(a6)                              ; $000AA2
        bne.b        loc_000AC2                                    ; $000AA8
        clr.b        rGameClockSeconds(a6)                                    ; $000AAA
        addq.b       #$1, rGameClockMinutes(a6)                               ; $000AAE
        cmpi.b       #$3c, rGameClockMinutes(a6)                              ; $000AB2
        bne.b        loc_000AC2                                    ; $000AB8
        clr.b        rGameClockMinutes(a6)                                    ; $000ABA
        addq.b       #$1, rGameClockHours(a6)                               ; $000ABE

loc_000AC2:
        addq.w       #$1, ramVBlankCounter.l                       ; $000AC2
        addq.w       #$1, ramLinkStallTicks.l                                ; $000AC8
        subq.w       #$1, ramStatusSoundScriptStepTicks.l                                ; $000ACE
        tst.w        ramSoundEffectCooldown.l                                     ; $000AD4
        beq.b        loc_000AE2                                    ; $000ADA
        subq.w       #$1, ramSoundEffectCooldown.l                                ; $000ADC

loc_000AE2:
        tst.w        ramVBlankTransferPhasesRemaining.l                                     ; $000AE2
        beq.w        IgnoreInterrupt                               ; $000AE8
        move.l       a0, -(a7)                                     ; $000AEC
        movea.l      #VDP_CONTROL, a0                              ; $000AEE
        move.w       #$8174, VDP_CONTROL.l                         ; $000AF4
        subq.w       #$1, ramVBlankTransferPhasesRemaining.l                                ; $000AFC
        beq.w        loc_000B8C                                    ; $000B02
        move.l       d0, -(a7)                                     ; $000B06
        jsr          RequestGemsMailbox.l                          ; $000B08
        move.w       #$9300, (a0)                                  ; $000B0E
        move.w       #$940a, (a0)                                  ; $000B12
        move.w       #$9525, (a0)                                  ; $000B16
        move.w       #$96b1, (a0)                                  ; $000B1A
        move.w       #$977f, (a0)                                  ; $000B1E
        move.w       #$4020, (a0)                                  ; $000B22
        move.w       #$80, (a0)                                    ; $000B26
        jsr          StopGemsDriver.l                              ; $000B2A
        move.l       (a7)+, d0                                     ; $000B30
        tst.w        ramPlayerDamageFlashColor.l                                     ; $000B32
        beq.b        loc_000BB8                                    ; $000B38
        tst.w        ramPlayerDeathTicks.l                         ; $000B3A
        beq.b        loc_000B66                                    ; $000B40
        cmpi.w       #$f, ramPlayerDamageFlashColor.l                                ; $000B42
        bhi.b        loc_000B5C                                    ; $000B4A
        subq.w       #$1, ramPlayerDamageFlashColor.l                                ; $000B4C
        bpl.b        loc_000B74                                    ; $000B52
        clr.w        ramPlayerDamageFlashColor.l                                     ; $000B54
        bra.b        loc_000B74                                    ; $000B5A

loc_000B5C:
        subi.w       #$110, ramPlayerDamageFlashColor.l                              ; $000B5C
        bra.b        loc_000B74                                    ; $000B64

loc_000B66:
        subq.w       #$3, ramPlayerDamageFlashColor.l                                ; $000B66
        bpl.b        loc_000B74                                    ; $000B6C
        clr.w        ramPlayerDamageFlashColor.l                                     ; $000B6E

loc_000B74:
        move.l       #$c07e0000, VDP_CONTROL.l                     ; $000B74
        move.w       ramPlayerDamageFlashColor.l, VDP_DATA.l                         ; $000B7E
        bra.w        loc_000BB8                                    ; $000B88

loc_000B8C:
        move.l       d0, -(a7)                                     ; $000B8C
        jsr          RequestGemsMailbox.l                          ; $000B8E
        move.w       #$9300, (a0)                                  ; $000B94
        move.w       #$940a, (a0)                                  ; $000B98
        move.w       #$9525, (a0)                                  ; $000B9C
        move.w       #$96bb, (a0)                                  ; $000BA0
        move.w       #$977f, (a0)                                  ; $000BA4
        move.w       #$5420, (a0)                                  ; $000BA8
        move.w       #$80, (a0)                                    ; $000BAC
        jsr          StopGemsDriver.l                              ; $000BB0
        move.l       (a7)+, d0                                     ; $000BB6

loc_000BB8:
        movea.l      (a7)+, a0                                     ; $000BB8
        move.w       #$8164, VDP_CONTROL.l                         ; $000BBA
        move.l       #$68200002, VDP_CONTROL.l                     ; $000BC2
        ifne *-$BCC
        fail "ROM end moved"
        endif
