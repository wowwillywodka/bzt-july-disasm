; $098C76..$098D29 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A3=source, D0=VRAM BYTE address. Word-packed variant; count zero selects a raw-copy exit, unlike RAM/VRAM-long. No established external call in decoded July code.
        ifne *-$98C76
        fail "ROM start moved"
        endif

DecompressBytePairToVramWord:
; A3=source, D0=VRAM BYTE address. Word-packed variant; count zero selects a raw-copy exit, unlike RAM/VRAM-long. No established external call in decoded July code.
        movem.l      d0-d6/a0-a4, -(a7)                            ; $098C76
        move.w       #$8f02, VDP_CONTROL.l                         ; $098C7A
        asl.l        #$2, d0                                       ; $098C82
        lsr.w        #$2, d0                                       ; $098C84
        ori.w        #$4000, d0                                    ; $098C86
        swap         d0                                            ; $098C8A
        move.l       d0, VDP_CONTROL.l                             ; $098C8C
        moveq        #$1, d3                                       ; $098C92

loc_098C94:
        moveq        #$0, d0                                       ; $098C94
        moveq        #$0, d1                                       ; $098C96
        moveq        #$0, d2                                       ; $098C98
        move.b       (a3)+, d0                                     ; $098C9A
        beq.w        loc_098D14                                    ; $098C9C
        cmpi.b       #$ff, d0                                      ; $098CA0
        beq.w        loc_098D0E                                    ; $098CA4
        subq.w       #$1, d0                                       ; $098CA8
        move.b       d0, d1                                        ; $098CAA
        lea.l        rBytePairFlags(a6), a0                        ; $098CAC
        lea.l        rBytePairLeft(a6), a1                         ; $098CB0
        lea.l        rBytePairRight(a6), a2                        ; $098CB4
        move.w       #$100, d0                                     ; $098CB8

loc_098CBC:
        move.b       #$0, (a0, d2.w)                               ; $098CBC
        addq.w       #$1, d2                                       ; $098CC2
        dbra         d0, loc_098CBC                                ; $098CC4
        moveq        #$0, d0                                       ; $098CC8

loc_098CCA:
        move.b       (a3)+, d0                                     ; $098CCA
        move.b       #$1, (a0, d0.w)                               ; $098CCC
        move.b       (a3)+, (a1, d0.w)                             ; $098CD2
        move.b       (a3)+, (a2, d0.w)                             ; $098CD6
        dbra         d1, loc_098CCA                                ; $098CDA
        move.l       a3, d0                                        ; $098CDE
        btst.l       #$0, d0                                       ; $098CE0
        beq.w        loc_098CEA                                    ; $098CE4
        addq.w       #$1, d0                                       ; $098CE8

loc_098CEA:
        movea.l      d0, a3                                        ; $098CEA
        move.w       (a3)+, d2                                     ; $098CEC
        subq.w       #$1, d2                                       ; $098CEE
        clr.l        d0                                            ; $098CF0

loc_098CF2:
        move.b       (a3)+, d0                                     ; $098CF2
        jsr          ExpandBytePairToVramWord.l                    ; $098CF4
        dbra         d2, loc_098CF2                                ; $098CFA
        move.l       a3, d1                                        ; $098CFE
        btst.l       #$0, d1                                       ; $098D00
        beq.w        loc_098D0A                                    ; $098D04
        addq.w       #$1, d1                                       ; $098D08

loc_098D0A:
        movea.l      d1, a3                                        ; $098D0A
        bra.b        loc_098C94                                    ; $098D0C

loc_098D0E:
        movem.l      (a7)+, d0-d6/a0-a4                            ; $098D0E
        rts                                                        ; $098D12

loc_098D14:
; Zero-count raw mode skips one byte, reads a word, then copies ((word>>2)+1) LONGS and returns. No subtract-one before DBRA.
        addq.l       #$1, a3                                       ; $098D14
        move.w       (a3)+, d0                                     ; $098D16
        lsr.w        #$2, d0                                       ; $098D18

loc_098D1A:
        move.l       (a3)+, VDP_DATA.l                             ; $098D1A
        dbra         d0, loc_098D1A                                ; $098D20
        movem.l      (a7)+, d0-d6/a0-a4                            ; $098D24
        rts                                                        ; $098D28
        ifne *-$98D2A
        fail "ROM end moved"
        endif
