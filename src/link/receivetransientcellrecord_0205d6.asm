; $0205D6..$020653 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: see docs/LINK_PROCEDURE_CONTRACTS.md for caller and packet contracts.
; [⇐June 1A94C] RAM-реестр -0x7116/-0x711A (список клеток/акторов, аналог реестров обломков)
        ifne *-$205D6
        fail "ROM start moved"
        endif

ReceiveTransientCellRecord:
        subq.w       #$1, a0                                       ; $0205D6
        lea.l        rTransientCellRecords(a6), a3                 ; $0205D8
        cmpa.l       rTransientCellRecordsEnd(a6), a3              ; $0205DC
        beq.b        loc_0205F8                                    ; $0205E0
        move.b       $1(a0), d0                                    ; $0205E2
        movea.l      $4(a0), a1                                    ; $0205E6

loc_0205EA:
        cmpa.l       (a3), a1                                      ; $0205EA
        beq.b        loc_020626                                    ; $0205EC
        adda.w       #$e, a3                                       ; $0205EE
        cmpa.l       rTransientCellRecordsEnd(a6), a3              ; $0205F2
        bne.b        loc_0205EA                                    ; $0205F6

loc_0205F8:
        tst.b        $8(a0)                                        ; $0205F8
        bne.b        loc_020600                                    ; $0205FC
        rts                                                        ; $0205FE

loc_020600:
        movea.l      rTransientCellRecordsEnd(a6), a3              ; $020600
        move.l       a1, (a3)+                                     ; $020604
        clr.b        (a3)+                                         ; $020606
        move.b       $8(a0), (a3)+                                 ; $020608
        clr.w        (a3)+                                         ; $02060C
        move.b       $2(a0), (a3)+                                 ; $02060E
        clr.b        (a3)+                                         ; $020612
        move.b       $3(a0), (a3)+                                 ; $020614
        clr.b        (a3)+                                         ; $020618
        move.b       #$1, (a3)+                                    ; $02061A
        move.b       d0, (a3)+                                     ; $02061E
        move.l       a3, rTransientCellRecordsEnd(a6)              ; $020620
        rts                                                        ; $020624

loc_020626:
        cmpi.b       #$1, $c(a3)                                   ; $020626
        bne.b        loc_020636                                    ; $02062C
        move.b       $8(a0), $5(a3)                                ; $02062E
        beq.b        loc_020638                                    ; $020634

loc_020636:
        rts                                                        ; $020636

loc_020638:
        lea.l        $e(a3), a4                                    ; $020638
        movea.l      a3, a2                                        ; $02063C

loc_02063E:
        cmpa.l       rTransientCellRecordsEnd(a6), a4              ; $02063E
        beq.b        loc_02064E                                    ; $020642
        move.l       (a4)+, (a2)+                                  ; $020644
        move.l       (a4)+, (a2)+                                  ; $020646
        move.l       (a4)+, (a2)+                                  ; $020648
        move.w       (a4)+, (a2)+                                  ; $02064A
        bra.b        loc_02063E                                    ; $02064C

loc_02064E:
        move.l       a2, rTransientCellRecordsEnd(a6)              ; $02064E
        rts                                                        ; $020652
        ifne *-$20654
        fail "ROM end moved"
        endif
