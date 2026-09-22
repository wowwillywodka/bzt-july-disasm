; $098AEA..$098B69 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; A3=byte-pair source, A4=destination RAM. Saves/restores D0-D6/A0-A4; advanced pointers are not returned. Dictionaries use FF5F44/FF6044/FF6144. See docs/COMPRESSION.md.
        ifne *-$98AEA
        fail "ROM start moved"
        endif

DecompressBytePairToRam:
; A3=byte-pair source, A4=destination RAM. Saves/restores D0-D6/A0-A4; advanced pointers are not returned. Dictionaries use FF5F44/FF6044/FF6144. See docs/COMPRESSION.md.
        movem.l      d0-d6/a0-a4, -(a7)                            ; $098AEA

loc_098AEE:
        moveq        #$0, d0                                       ; $098AEE
        moveq        #$0, d1                                       ; $098AF0
        moveq        #$0, d2                                       ; $098AF2
        move.b       (a3)+, d0                                     ; $098AF4
        cmpi.b       #$ff, d0                                      ; $098AF6
        beq.w        loc_098B64                                    ; $098AFA
; RAM/VRAM-long variants: zero dictionary-count byte wraps to 256 triples; $FF terminates the whole stream.
        subq.w       #$1, d0                                       ; $098AFE
        move.b       d0, d1                                        ; $098B00
        lea.l        rBytePairFlags(a6), a0                        ; $098B02
        lea.l        rBytePairLeft(a6), a1                         ; $098B06
        lea.l        rBytePairRight(a6), a2                        ; $098B0A
; DBRA with $100 clears 257 flag bytes: final write also clears left[0]. Preserved original behavior.
        move.w       #$100, d0                                     ; $098B0E

loc_098B12:
        move.b       #$0, (a0, d2.w)                               ; $098B12
        addq.w       #$1, d2                                       ; $098B18
        dbra         d0, loc_098B12                                ; $098B1A
        moveq        #$0, d0                                       ; $098B1E

loc_098B20:
        move.b       (a3)+, d0                                     ; $098B20
        move.b       #$1, (a0, d0.w)                               ; $098B22
        move.b       (a3)+, (a1, d0.w)                             ; $098B28
        move.b       (a3)+, (a2, d0.w)                             ; $098B2C
        dbra         d1, loc_098B20                                ; $098B30
        move.l       a3, d0                                        ; $098B34
        btst.l       #$0, d0                                       ; $098B36
        beq.w        loc_098B40                                    ; $098B3A
        addq.w       #$1, d0                                       ; $098B3E

loc_098B40:
        movea.l      d0, a3                                        ; $098B40
        move.w       (a3)+, d2                                     ; $098B42
        subq.w       #$1, d2                                       ; $098B44
        clr.l        d0                                            ; $098B46

loc_098B48:
        move.b       (a3)+, d0                                     ; $098B48
        jsr          ExpandBytePairToRam.l                         ; $098B4A
        dbra         d2, loc_098B48                                ; $098B50
        move.l       a3, d1                                        ; $098B54
        btst.l       #$0, d1                                       ; $098B56
        beq.w        loc_098B60                                    ; $098B5A
        addq.w       #$1, d1                                       ; $098B5E

loc_098B60:
        movea.l      d1, a3                                        ; $098B60
        bra.b        loc_098AEE                                    ; $098B62

loc_098B64:
        movem.l      (a7)+, d0-d6/a0-a4                            ; $098B64
        rts                                                        ; $098B68
        ifne *-$98B6A
        fail "ROM end moved"
        endif
