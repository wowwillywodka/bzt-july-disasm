; $021FEC..$021FFF | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
        ifne *-$21FEC
        fail "ROM start moved"
        endif

RetainedSetVramWriteAddress:
        swap         d0                                            ; $021FEC
        clr.w        d0                                            ; $021FEE
        asl.l        #$3, d0                                       ; $021FF0
        add.l        rMenuVramWriteAddressOffset(a6), d0                                ; $021FF2
        move.l       d0, VDP_CONTROL.l                             ; $021FF6
        rts                                                        ; $021FFC

; Reviewed call entry (shared-tail): Branches to the D3/D1/D4/D2 VDP-data writes of WriteHardwareSprite.
WriteHardwareSpriteWordsAtCurrentAddress:
        bra.b        loc_021FD2                                    ; $021FFE
        ifne *-$22000
        fail "ROM end moved"
        endif
