; $01FF30..$01FF4D | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: see docs/LINK_PROCEDURE_CONTRACTS.md for caller and packet contracts.
; Линк-кабель: ожидание готовности партнёра (btst бит6 TH в DATA3 $A10005 с таймаутом $FF2C64), затем bset бита5 TR — финальный строб-квитанция; ошибка→$FF2C5E
        ifne *-$1FF30
        fail "ROM start moved"
        endif

WaitForLinkPeerHighAndSetStrobe:
        move.w       ramLinkTransferModeShadow.l, d5                                 ; $01FF30

loc_01FF36:
        subq.w       #$1, d5                                       ; $01FF36
        beq.b        loc_01FF46                                    ; $01FF38
        btst.b       #$6, (a3)                                     ; $01FF3A
        beq.b        loc_01FF36                                    ; $01FF3E
        bset.b       #$5, (a3)                                     ; $01FF40
        rts                                                        ; $01FF44

loc_01FF46:
        addq.w       #$1, ramLinkTransferFailureCount.l                                ; $01FF46
        rts                                                        ; $01FF4C
        ifne *-$1FF4E
        fail "ROM end moved"
        endif
