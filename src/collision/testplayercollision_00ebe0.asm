; $00EBE0..$00EC43 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; КОЛЛИЗИЯ игрока (noclip = патч 4243 4E75)
        ifne *-$EBE0
        fail "ROM start moved"
        endif

TestPlayerCollision:
        movem.w      d0/d4, -(a7)                                  ; $00EBE0
        asr.w        #$8, d0                                       ; $00EBE4
        clr.b        d4                                            ; $00EBE6
        asr.w        #$3, d4                                       ; $00EBE8
        add.w        d4, d0                                        ; $00EBEA
        move.b       (a1, d0.w), d3                                ; $00EBEC
        movem.w      (a7)+, d0/d4                                  ; $00EBF0
        move.b       (a5, d3.w), d3                                ; $00EBF4
        beq.b        loc_00EC40                                    ; $00EBF8
        bsr.w        GetCellCollisionClass                         ; $00EBFA
        cmpi.b       #$6, d3                                       ; $00EBFE
        bcc.b        loc_00EC40                                    ; $00EC02
        cmpi.b       #$1, d3                                       ; $00EC04
        beq.b        loc_00EC22                                    ; $00EC08
        cmpi.b       #$2, d3                                       ; $00EC0A
        beq.b        loc_00EC30                                    ; $00EC0E
        cmpi.b       #$3, d3                                       ; $00EC10
        beq.b        loc_00EC26                                    ; $00EC14
        cmpi.b       #$4, d3                                       ; $00EC16
        beq.b        loc_00EC38                                    ; $00EC1A
        not.b        d4                                            ; $00EC1C
        cmp.b        d4, d0                                        ; $00EC1E
        bhi.b        loc_00EC40                                    ; $00EC20

loc_00EC22:
        tst.b        d3                                            ; $00EC22
        rts                                                        ; $00EC24

loc_00EC26:
        not.b        d4                                            ; $00EC26
        cmp.b        d4, d0                                        ; $00EC28
        bcs.b        loc_00EC40                                    ; $00EC2A
        tst.b        d3                                            ; $00EC2C
        rts                                                        ; $00EC2E

loc_00EC30:
        cmp.b        d4, d0                                        ; $00EC30
        bcs.b        loc_00EC40                                    ; $00EC32
        tst.b        d3                                            ; $00EC34
        rts                                                        ; $00EC36

loc_00EC38:
        cmp.b        d4, d0                                        ; $00EC38
        bhi.b        loc_00EC40                                    ; $00EC3A
        tst.b        d3                                            ; $00EC3C
        rts                                                        ; $00EC3E

loc_00EC40:
        clr.w        d3                                            ; $00EC40
        rts                                                        ; $00EC42
        ifne *-$EC44
        fail "ROM end moved"
        endif
