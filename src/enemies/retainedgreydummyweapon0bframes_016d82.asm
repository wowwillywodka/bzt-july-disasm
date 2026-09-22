; $016D82..$016DEB | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed code: $16D82..$16DEB is a retained weapon-death draw body behind RTS $16D80; $16DEC..$16E51 is live Grey Dummy attack drawing, reached from $16CC8. See docs/GREY_GREEN_DUMMY.md.
; JULY LOCAL REVIEW:
; Retained weapon0B frames4/1..5. Normal state6 draw branches to RTS $16D80, not here. No external direct control edge found into this body.
        ifne *-$16D82
        fail "ROM start moved"
        endif

RetainedGreyDummyWeapon0BFrames:
; Retained weapon0B frames4/1..5. Normal state6 draw branches to RTS $16D80, not here. No external direct control edge found into this body.
        move.b       ActorStateCounter(a0), d7                     ; $016D82
        cmpi.b       #$5, d7                                       ; $016D86
        beq.b        loc_016DA6                                    ; $016D8A
        cmpi.b       #$4, d7                                       ; $016D8C
        beq.b        loc_016DB4                                    ; $016D90
        cmpi.b       #$3, d7                                       ; $016D92
        beq.b        loc_016DC2                                    ; $016D96
        cmpi.b       #$2, d7                                       ; $016D98
        beq.b        loc_016DD0                                    ; $016D9C
        cmpi.b       #$1, d7                                       ; $016D9E
        beq.b        loc_016DDE                                    ; $016DA2
        rts                                                        ; $016DA4

loc_016DA6:
        move.w       #$4, d0                                       ; $016DA6
        move.w       #$1, d2                                       ; $016DAA
        jmp          DrawActorAnimation.l                          ; $016DAE

loc_016DB4:
        move.w       #$4, d0                                       ; $016DB4
        move.w       #$2, d2                                       ; $016DB8
        jmp          DrawActorAnimation.l                          ; $016DBC

loc_016DC2:
        move.w       #$4, d0                                       ; $016DC2
        move.w       #$3, d2                                       ; $016DC6
        jmp          DrawActorAnimation.l                          ; $016DCA

loc_016DD0:
        move.w       #$4, d0                                       ; $016DD0
        move.w       #$4, d2                                       ; $016DD4
        jmp          DrawActorAnimation.l                          ; $016DD8

loc_016DDE:
        move.w       #$4, d0                                       ; $016DDE
        move.w       #$5, d2                                       ; $016DE2
        jmp          DrawActorAnimation.l                          ; $016DE6
        ifne *-$16DEC
        fail "ROM end moved"
        endif
