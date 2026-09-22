; $0983DC..$098429 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A0=train record. Match train ID and floor, choose next contiguous same-ID route row or wrap to first matching ID; copy five bytes. A0 returns advanced by four. No valid missing-ID fallback.
        ifne *-$983DC
        fail "ROM start moved"
        endif

AdvanceTrainRoute:
; A0=train record. Match train ID and floor, choose next contiguous same-ID route row or wrap to first matching ID; copy five bytes. A0 returns advanced by four. No valid missing-ID fallback.
        movea.l      rTrainRouteTable(a6), a1                      ; $0983DC
        move.w       (a1)+, d7                                     ; $0983E0
        subq.w       #$1, d7                                       ; $0983E2
        movea.l      #$ffffffff, a2                                ; $0983E4

loc_0983EA:
        move.b       (a1), d1                                      ; $0983EA
        cmp.b        (a0), d1                                      ; $0983EC
        bne.b        loc_098418                                    ; $0983EE
        cmpa.l       #$ffffffff, a2                                ; $0983F0
        bne.b        loc_0983FA                                    ; $0983F6
        movea.l      a1, a2                                        ; $0983F8

loc_0983FA:
        move.b       $1(a1), d2                                    ; $0983FA
        cmp.b        TrainFloor(a0), d2                            ; $0983FE
        bne.b        loc_098418                                    ; $098402
        cmp.b        $5(a1), d1                                    ; $098404
        bne.b        loc_09841E                                    ; $098408
        addq.w       #$5, a1                                       ; $09840A
        move.b       (a1)+, (a0)+                                  ; $09840C
        move.b       (a1)+, (a0)+                                  ; $09840E
        move.b       (a1)+, (a0)+                                  ; $098410
        move.b       (a1)+, (a0)+                                  ; $098412
        move.b       (a1), (a0)                                    ; $098414
        rts                                                        ; $098416

loc_098418:
        addq.w       #$5, a1                                       ; $098418
        dbra         d7, loc_0983EA                                ; $09841A

loc_09841E:
        move.b       (a2)+, (a0)+                                  ; $09841E
        move.b       (a2)+, (a0)+                                  ; $098420
        move.b       (a2)+, (a0)+                                  ; $098422
        move.b       (a2)+, (a0)+                                  ; $098424
        move.b       (a2), (a0)                                    ; $098426
        rts                                                        ; $098428
        ifne *-$9842A
        fail "ROM end moved"
        endif
