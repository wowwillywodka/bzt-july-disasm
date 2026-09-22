; $020AEA..$020CBB | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Consume four fixed 9-byte text rows, then optional sound-script data. No NUL terminator is read for the 36 text bytes. See docs/TEXT.md.
        ifne *-$20AEA
        fail "ROM start moved"
        endif

UpdateStatusMessages:
; Consume four fixed 9-byte text rows, then optional sound-script data. No NUL terminator is read for the 36 text bytes. See docs/TEXT.md.
        cmpi.w       #$69, rFloorClearMessageTimer(a6)             ; $020AEA
        beq.b        loc_020B0E                                    ; $020AF0
        tst.w        rFloorClearMessageTimer(a6)                   ; $020AF2
        beq.b        loc_020B1A                                    ; $020AF6
        subq.w       #$1, rFloorClearMessageTimer(a6)              ; $020AF8
        bne.b        loc_020B1A                                    ; $020AFC
        move.w       #$e1, rFloorClearMessageTimer(a6)             ; $020AFE
        movea.l      #StatusMessageFloorSecured, a0                ; $020B04
        bsr.b        QueueStatusMessage                            ; $020B0A
        bra.b        loc_020B1A                                    ; $020B0C

loc_020B0E:
        subq.w       #$1, rFloorClearMessageTimer(a6)              ; $020B0E
        movea.l      #StatusMessageProceedToNextLevel, a0          ; $020B12
        bsr.b        QueueStatusMessage                            ; $020B18

loc_020B1A:
        bsr.w        SoundRoutine_020CBC                           ; $020B1A
        move.w       -$76ee(a6), d0                                ; $020B1E
        beq.b        loc_020B9A                                    ; $020B22
        sub.w        -$76f0(a6), d0                                ; $020B24
        subq.w       #$1, d0                                       ; $020B28
        beq.b        loc_020B34                                    ; $020B2A
        bmi.b        loc_020B34                                    ; $020B2C
        move.w       d0, -$76ee(a6)                                ; $020B2E
        rts                                                        ; $020B32

loc_020B34:
        clr.w        -$76ee(a6)                                    ; $020B34
        movea.l      #VDP_DATA, a4                                 ; $020B38
        move.w       #$e514, d0                                    ; $020B3E
        swap         d0                                            ; $020B42
        move.w       #$e514, d0                                    ; $020B44
        move.l       #$4a040003, VDP_CONTROL.l                     ; $020B48
        move.l       d0, (a4)                                      ; $020B52
        move.l       d0, (a4)                                      ; $020B54
        move.l       d0, (a4)                                      ; $020B56
        move.l       d0, (a4)                                      ; $020B58
        move.w       d0, (a4)                                      ; $020B5A
        move.l       #$4a840003, VDP_CONTROL.l                     ; $020B5C
        move.l       d0, (a4)                                      ; $020B66
        move.l       d0, (a4)                                      ; $020B68
        move.l       d0, (a4)                                      ; $020B6A
        move.l       d0, (a4)                                      ; $020B6C
        move.w       d0, (a4)                                      ; $020B6E
        move.l       #$4b040003, VDP_CONTROL.l                     ; $020B70
        move.l       d0, (a4)                                      ; $020B7A
        move.l       d0, (a4)                                      ; $020B7C
        move.l       d0, (a4)                                      ; $020B7E
        move.l       d0, (a4)                                      ; $020B80
        move.w       d0, (a4)                                      ; $020B82
        move.l       #$4b840003, VDP_CONTROL.l                     ; $020B84
        move.l       d0, (a4)                                      ; $020B8E
        move.l       d0, (a4)                                      ; $020B90
        move.l       d0, (a4)                                      ; $020B92
        move.l       d0, (a4)                                      ; $020B94
        move.w       d0, (a4)                                      ; $020B96
        rts                                                        ; $020B98

loc_020B9A:
        tst.w        -$76f0(a6)                                    ; $020B9A
        bne.b        loc_020BA2                                    ; $020B9E
        rts                                                        ; $020BA0

loc_020BA2:
        lea.l        -$7730(a6), a0                                ; $020BA2
        movea.l      (a0), a1                                      ; $020BA6
        move.l       $4(a0), (a0)+                                 ; $020BA8
        move.l       $4(a0), (a0)+                                 ; $020BAC
        move.l       $4(a0), (a0)+                                 ; $020BB0
        move.l       $4(a0), (a0)+                                 ; $020BB4
        move.l       $4(a0), (a0)+                                 ; $020BB8
        move.l       $4(a0), (a0)+                                 ; $020BBC
        move.l       $4(a0), (a0)+                                 ; $020BC0
        move.l       $4(a0), (a0)+                                 ; $020BC4
        move.l       $4(a0), (a0)+                                 ; $020BC8
        move.l       $4(a0), (a0)+                                 ; $020BCC
        move.l       $4(a0), (a0)+                                 ; $020BD0
        move.l       $4(a0), (a0)+                                 ; $020BD4
        move.l       $4(a0), (a0)+                                 ; $020BD8
        move.l       $4(a0), (a0)+                                 ; $020BDC
        move.l       $4(a0), (a0)+                                 ; $020BE0
        subq.w       #$1, -$76f0(a6)                               ; $020BE4
        move.w       #$14, -$76ee(a6)                              ; $020BE8

loc_020BEE:
        tst.w        -$7ffe(a6)                                    ; $020BEE
        bne.b        loc_020BEE                                    ; $020BF2
        lea.l        StatusMessageTileLookup(pc), a0               ; $020BF4
        clr.w        d0                                            ; $020BF8
        movea.l      #VDP_DATA, a4                                 ; $020BFA
        move.l       #$4a040003, VDP_CONTROL.l                     ; $020C00
        move.w       #$8, d7                                       ; $020C0A

loc_020C0E:
        move.b       (a1)+, d0                                     ; $020C0E
        subi.b       #$20, d0                                      ; $020C10
        lsl.w        #$1, d0                                       ; $020C14
        move.w       (a0, d0.w), (a4)                              ; $020C16
        dbra         d7, loc_020C0E                                ; $020C1A
        move.l       #$4a840003, VDP_CONTROL.l                     ; $020C1E
        move.w       #$8, d7                                       ; $020C28

loc_020C2C:
        move.b       (a1)+, d0                                     ; $020C2C
        subi.b       #$20, d0                                      ; $020C2E
        lsl.w        #$1, d0                                       ; $020C32
        move.w       (a0, d0.w), (a4)                              ; $020C34
        dbra         d7, loc_020C2C                                ; $020C38
        move.l       #$4b040003, VDP_CONTROL.l                     ; $020C3C
        move.w       #$8, d7                                       ; $020C46

loc_020C4A:
        move.b       (a1)+, d0                                     ; $020C4A
        subi.b       #$20, d0                                      ; $020C4C
        lsl.w        #$1, d0                                       ; $020C50
        move.w       (a0, d0.w), (a4)                              ; $020C52
        dbra         d7, loc_020C4A                                ; $020C56
        move.l       #$4b840003, VDP_CONTROL.l                     ; $020C5A
        move.w       #$8, d7                                       ; $020C64

loc_020C68:
        move.b       (a1)+, d0                                     ; $020C68
        subi.b       #$20, d0                                      ; $020C6A
        lsl.w        #$1, d0                                       ; $020C6E
        move.w       (a0, d0.w), (a4)                              ; $020C70
        dbra         d7, loc_020C68                                ; $020C74
        movea.l      a1, a0                                        ; $020C78
        btst.b       #$1, -$7feb(a6)                               ; $020C7A
        bne.b        loc_020C84                                    ; $020C80
        rts                                                        ; $020C82

loc_020C84:
        tst.w        -$55a0(a6)                                    ; $020C84
        beq.b        loc_020C8C                                    ; $020C88
        rts                                                        ; $020C8A

loc_020C8C:
        lea.l        -$7772(a6), a1                                ; $020C8C
        cmpi.w       #$ffff, (a0)                                  ; $020C90
        bne.b        loc_020C9C                                    ; $020C94
        clr.w        -$55a0(a6)                                    ; $020C96
        rts                                                        ; $020C9A

loc_020C9C:
        move.l       (a0)+, (a1)+                                  ; $020C9C
        cmpi.w       #$ffff, (a0)                                  ; $020C9E
        bne.b        loc_020C9C                                    ; $020CA2
        move.w       (a0)+, (a1)+                                  ; $020CA4
        move.w       #$1, -$55a0(a6)                               ; $020CA6
        move.w       -$7772(a6), -$7732(a6)                        ; $020CAC
        move.w       -$7770(a6), d0                                ; $020CB2
        jmp          SoundRoutine_00DFBA.l                         ; $020CB6
        ifne *-$20CBC
        fail "ROM end moved"
        endif
