; $029ECA..$029F61 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Retained generator for 48 ordinary password strings,
; writing them from $FF8000 with space separators, then executing ILLEGAL.
; No ordinary game-flow caller has been established.
        ifne *-$29ECA
        fail "ROM start moved"
        endif

RetainedPasswordSelfTest:
        movea.l      #WORK_RAM_BASE, a6                            ; $029ECA
        clr.w        d0                                            ; $029ED0
        movea.l      a6, a0                                        ; $029ED2

loc_029ED4:
        move.b       #$1, rSavedInventoryItem0(a6)                 ; $029ED4
        move.b       #$7, rSavedInventoryAmount0(a6)               ; $029EDA
        move.b       #$3, rSavedInventoryItem1(a6)                 ; $029EE0
        move.b       #$7, rSavedInventoryAmount1(a6)               ; $029EE6
        move.b       #$b, rSavedInventoryItem2(a6)                 ; $029EEC
        move.b       #$7, rSavedInventoryAmount2(a6)               ; $029EF2
        move.b       #$c, rSavedInventoryItem3(a6)                 ; $029EF8
        move.b       #$7, rSavedInventoryAmount3(a6)               ; $029EFE
        move.b       #$e, rSavedInventoryItem4(a6)                 ; $029F04
        move.b       #$7, rSavedInventoryAmount4(a6)               ; $029F0A
        move.b       #$1, rCharacterAvailable0(a6)                 ; $029F10
        move.b       #$1, rCharacterAvailable1(a6)                 ; $029F16
        move.b       #$1, rCharacterAvailable2(a6)                 ; $029F1C
        move.b       #$1, rCharacterAvailable3(a6)                 ; $029F22
        move.b       #$1, rCharacterAvailable4(a6)                 ; $029F28
        move.b       #$3f, rSavedHealth(a6)                        ; $029F2E
        move.b       d0, rLevelSelection(a6)                       ; $029F34
        movem.l      d0/a0, -(a7)                                  ; $029F38
        bsr.w        EncodeProgressPassword                        ; $029F3C
        movem.l      (a7)+, d0/a0                                  ; $029F40
        addq.w       #$1, d0                                       ; $029F44
        adda.w       #$9, a0                                       ; $029F46
        move.b       #$20, (a0)+                                   ; $029F4A
        move.l       #$20202020, (a0)+                             ; $029F4E
        move.w       #$2020, (a0)+                                 ; $029F54
        cmpi.w       #$30, d0                                      ; $029F58
        bne.w        loc_029ED4                                    ; $029F5C
        illegal                                                    ; $029F60
        ifne *-$29F62
        fail "ROM end moved"
        endif
