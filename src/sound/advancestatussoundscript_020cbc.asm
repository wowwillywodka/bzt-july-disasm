; $020CBC..$020D15 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; When the active script step timer is negative, shift the 28-byte queue,
; load the next delay and sound ID, and dispatch it. $FFFF terminates the
; script. An inactive script is marked $FFFF immediately.
        ifne *-$20CBC
        fail "ROM start moved"
        endif

AdvanceStatusSoundScript:
        tst.w        rStatusSoundScriptActive(a6)                                    ; $020CBC
        bne.b        loc_020CCA                                    ; $020CC0
        move.w       #$ffff, rStatusSoundScript(a6)                            ; $020CC2
        rts                                                        ; $020CC8

loc_020CCA:
        cmpi.w       #$ffff, rStatusSoundScript(a6)                            ; $020CCA
        beq.b        loc_020D14                                    ; $020CD0
        tst.w        rStatusSoundScriptStepTicks(a6)                                    ; $020CD2
        bpl.b        loc_020D14                                    ; $020CD6
        lea.l        rStatusSoundScript(a6), a0                                ; $020CD8
        move.l       $4(a0), (a0)+                                 ; $020CDC
        move.l       $4(a0), (a0)+                                 ; $020CE0
        move.l       $4(a0), (a0)+                                 ; $020CE4
        move.l       $4(a0), (a0)+                                 ; $020CE8
        move.l       $4(a0), (a0)+                                 ; $020CEC
        move.l       $4(a0), (a0)+                                 ; $020CF0
        move.l       $4(a0), (a0)+                                 ; $020CF4
        cmpi.w       #$ffff, rStatusSoundScript(a6)                            ; $020CF8
        beq.b        loc_020D10                                    ; $020CFE
        move.w       rStatusSoundScript(a6), rStatusSoundScriptStepTicks(a6)                        ; $020D00
        move.w       rStatusSoundScriptSoundId(a6), d0                                ; $020D06
        jmp          DispatchSoundEventWithIrqMask.l                         ; $020D0A

loc_020D10:
        clr.w        rStatusSoundScriptActive(a6)                                    ; $020D10

loc_020D14:
        rts                                                        ; $020D14
        ifne *-$20D16
        fail "ROM end moved"
        endif
