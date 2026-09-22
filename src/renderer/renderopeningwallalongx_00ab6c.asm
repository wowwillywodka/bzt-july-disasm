; $00AB6C..$00ABA1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Render type $2D opening: slide two half spans along X using the transient amount. At $80 omit the face. This list is not the actor pool.
        ifne *-$AB6C
        fail "ROM start moved"
        endif

RenderOpeningWallAlongX:
; Render type $2D opening: slide two half spans along X using the transient amount. At $80 omit the face. This list is not the actor pool.
        lea.l        -$7030(a6), a3                                ; $00AB6C
        cmpa.l       -$711c(a6), a3                                ; $00AB70
        beq.b        loc_00AB82                                    ; $00AB74

loc_00AB76:
        cmpa.l       (a3)+, a0                                     ; $00AB76
        beq.w        loc_00AC26                                    ; $00AB78
        cmpa.l       -$711c(a6), a3                                ; $00AB7C
        bne.b        loc_00AB76                                    ; $00AB80

loc_00AB82:
        move.l       a0, (a3)+                                     ; $00AB82
        move.l       a3, -$711c(a6)                                ; $00AB84
        clr.l        -$6e46(a6)                                    ; $00AB88
        clr.l        -$6e42(a6)                                    ; $00AB8C
        clr.w        -$6e48(a6)                                    ; $00AB90
        bsr.w        FindTransientWallOpeningAmount                ; $00AB94
        cmpi.w       #$80, d3                                      ; $00AB98
        bne.b        RendererRoutine_00ABA2                        ; $00AB9C
        clr.w        d3                                            ; $00AB9E
        rts                                                        ; $00ABA0
        ifne *-$ABA2
        fail "ROM end moved"
        endif
