; $012904..$0129D5 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Action then switching then draw-driven simulation. New press = controller bit4 set, previous-state byte FF0032 bit4 clear; death or rear view suppress initial action. Draw handlers still run and can emit projectiles. See docs/PLAYER_WEAPONS.md.
        ifne *-$12904
        fail "ROM start moved"
        endif

UpdatePlayerWeaponAndDraw:
; Action then switching then draw-driven simulation. New press = controller bit4 set, previous-state byte FF0032 bit4 clear; death or rear view suppress initial action. Draw handlers still run and can emit projectiles. See docs/PLAYER_WEAPONS.md.
        tst.w        rPlayerDeathTicks(a6)                         ; $012904
        bne.b        WeaponCheckPendingSwitch                      ; $012908
        btst.b       #$4, rControllerState(a6)                     ; $01290A
        beq.b        WeaponCheckPendingSwitch                      ; $012910
        btst.b       #$4, rPreviousControllerState(a6)             ; $012912
        bne.b        WeaponCheckPendingSwitch                      ; $012918
        tst.w        rRearViewActive(a6)                                    ; $01291A
        bne.b        WeaponCheckPendingSwitch                      ; $01291E
        bsr.w        DispatchWeaponAction                          ; $012920

WeaponCheckPendingSwitch:
; Only phase0 can begin a pending switch. Lower by8 per call to32, commit/clamp ID to0..17, queue graphics and RETURN; raising/drawing resumes on following call.
        tst.w        rWeaponActionPhase(a6)                        ; $012924
        bne.w        WeaponRaiseAndDraw                            ; $012928
        clr.w        d0                                            ; $01292C
        move.b       rPendingWeaponId(a6), d0                      ; $01292E
        bmi.w        WeaponRaiseAndDraw                            ; $012932
        cmp.b        rCurrentWeaponId(a6), d0                      ; $012936
        beq.w        ContinuePlayerWeaponSwitchAndDraw             ; $01293A
        addq.w       #$8, rWeaponLoweringOffset(a6)                ; $01293E
        cmpi.w       #$20, rWeaponLoweringOffset(a6)               ; $012942
        bcs.w        WeaponRaiseAndDraw                            ; $012948
        move.w       #$20, rWeaponLoweringOffset(a6)               ; $01294C
        move.b       #$ff, rPendingWeaponId(a6)                    ; $012952
        cmpi.w       #$11, d0                                      ; $012958
        bls.b        WeaponCommitSelection                         ; $01295C
        clr.w        d0                                            ; $01295E

WeaponCommitSelection:
        move.b       d0, rCurrentWeaponId(a6)                      ; $012960
        lsl.w        #$2, d0                                       ; $012964
        lea.l        HeldWeaponGraphicsPointers.l, a0                 ; $012966
        adda.w       d0, a0                                        ; $01296C
        move.l       (a0)+, d4                                     ; $01296E
        move.l       d4, -(a7)                                     ; $012970
        move.w       #$9de0, d5                                    ; $012972
        move.w       #$150, d6                                     ; $012976
        jsr          QueueVramDma.l                                ; $01297A
        cmpi.l       #$15d6d8, (a7)+                               ; $012980
        bne.w        loc_0129D4                                    ; $012986
        movea.l      rDmaQueueTail(a6), a0                         ; $01298A
        move.l       #$ffffffff, (a0)                              ; $01298E
        jsr          FlushDmaQueue.w                               ; $012994
        move.l       #UnarmedHeldWeaponGraphics, d4                              ; $012998
        move.w       #$9de0, d5                                    ; $01299E
        move.w       #$100, d6                                     ; $0129A2
        jsr          QueueVramDma.l                                ; $0129A6
        move.l       #$15d8d8, d4                                  ; $0129AC
        move.w       #$9fe0, d5                                    ; $0129B2
        move.w       #$c0, d6                                      ; $0129B6
        jsr          QueueVramDma.l                                ; $0129BA
        move.l       #$15da58, d4                                  ; $0129C0
        move.w       #$a160, d5                                    ; $0129C6
        move.w       #$90, d6                                      ; $0129CA
        jsr          QueueVramDma.l                                ; $0129CE

loc_0129D4:
        rts                                                        ; $0129D4
        ifne *-$129D6
        fail "ROM end moved"
        endif
