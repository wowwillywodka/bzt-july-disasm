; $09787C..$0978BD | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Set the ray-angle step to 1 while stationary, 8 while turning or moving.
; Both SceneColorMode branches write the same step; the renderer consumes it.
        ifne *-$9787C
        fail "ROM start moved"
        endif

SelectSceneRefreshMode:
        tst.w        rPlayerTurnMomentum(a6)                                    ; $09787C
        bne.b        loc_0978A6                                    ; $097880
        tst.w        rPlayerStrafeSpeed(a6)                                    ; $097882
        bne.b        loc_0978A6                                    ; $097886
        tst.w        rPlayerForwardSpeed(a6)                                    ; $097888
        bne.b        loc_0978A6                                    ; $09788C
        cmpi.w       #$0, rSceneColorMode(a6)                      ; $09788E
        beq.b        loc_09789E                                    ; $097894
        move.w       #$1, rVisibleRaySampleStep(a6)                               ; $097896
        rts                                                        ; $09789C

loc_09789E:
        move.w       #$1, rVisibleRaySampleStep(a6)                               ; $09789E
        rts                                                        ; $0978A4

loc_0978A6:
        cmpi.w       #$0, rSceneColorMode(a6)                      ; $0978A6
        beq.b        loc_0978B6                                    ; $0978AC
        move.w       #$8, rVisibleRaySampleStep(a6)                               ; $0978AE
        rts                                                        ; $0978B4

loc_0978B6:
        move.w       #$8, rVisibleRaySampleStep(a6)                               ; $0978B6
        rts                                                        ; $0978BC
        ifne *-$978BE
        fail "ROM end moved"
        endif
