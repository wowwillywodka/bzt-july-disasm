; $01FEB6..$01FF2F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: see docs/LINK_PROCEDURE_CONTRACTS.md for caller and packet contracts.
; Линк-кабель: приём байта через DATA3 ($A10005) — 4 фазы nibble-handshake (btst бит6 TH, lsl сборка nibble'ов в D7, toggle бита5 TR), таймаут $FF2C64, ошибка→$FF2C5E
        ifne *-$1FEB6
        fail "ROM start moved"
        endif

ReceiveLinkWordInNibbles:
        move.w       ramLinkTransferModeShadow.l, d5                                 ; $01FEB6

loc_01FEBC:
        subq.w       #$1, d5                                       ; $01FEBC
        beq.w        loc_01FF28                                    ; $01FEBE
        btst.b       #$6, (a3)                                     ; $01FEC2
        beq.b        loc_01FEBC                                    ; $01FEC6
        move.b       (a3), d7                                      ; $01FEC8
        move.b       d7, -(a7)                                     ; $01FECA
        move.w       (a7)+, d7                                     ; $01FECC
        bset.b       #$5, (a3)                                     ; $01FECE
        move.w       ramLinkTransferModeShadow.l, d5                                 ; $01FED2

loc_01FED8:
        subq.w       #$1, d5                                       ; $01FED8
        beq.w        loc_01FF28                                    ; $01FEDA
        btst.b       #$6, (a3)                                     ; $01FEDE
        bne.b        loc_01FED8                                    ; $01FEE2
        move.b       (a3), d7                                      ; $01FEE4
        lsl.b        #$4, d7                                       ; $01FEE6
        lsl.l        #$4, d7                                       ; $01FEE8
        bclr.b       #$5, (a3)                                     ; $01FEEA
        move.w       ramLinkTransferModeShadow.l, d5                                 ; $01FEEE

loc_01FEF4:
        subq.w       #$1, d5                                       ; $01FEF4
        beq.w        loc_01FF28                                    ; $01FEF6
        btst.b       #$6, (a3)                                     ; $01FEFA
        beq.b        loc_01FEF4                                    ; $01FEFE
        move.b       (a3), d7                                      ; $01FF00
        lsl.b        #$4, d7                                       ; $01FF02
        lsl.l        #$4, d7                                       ; $01FF04
        bset.b       #$5, (a3)                                     ; $01FF06
        move.w       ramLinkTransferModeShadow.l, d5                                 ; $01FF0A

loc_01FF10:
        subq.w       #$1, d5                                       ; $01FF10
        beq.w        loc_01FF28                                    ; $01FF12
        btst.b       #$6, (a3)                                     ; $01FF16
        bne.b        loc_01FF10                                    ; $01FF1A
        move.b       (a3), d7                                      ; $01FF1C
        lsl.b        #$4, d7                                       ; $01FF1E
        lsr.l        #$4, d7                                       ; $01FF20
        bclr.b       #$5, (a3)                                     ; $01FF22
        rts                                                        ; $01FF26

loc_01FF28:
        addq.w       #$1, ramLinkTransferFailureCount.l                                ; $01FF28
        rts                                                        ; $01FF2E
        ifne *-$1FF30
        fail "ROM end moved"
        endif
