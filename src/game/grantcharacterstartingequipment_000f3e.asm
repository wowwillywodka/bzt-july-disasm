; $000F3E..$000FA7 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Grant selected character equipment from five 8-byte records. Retained legacy episode=1/floor=15 branch uses incoming A0; it is not ordinary HUD printing.
        ifne *-$F3E
        fail "ROM start moved"
        endif

GrantCharacterStartingEquipment:
; Grant selected character equipment from five 8-byte records. Retained legacy episode=1/floor=15 branch uses incoming A0; it is not ordinary HUD printing.
        cmpi.w       #$1, rLegacyEpisodeSelection(a6)              ; $000F3E
        bne.b        loc_000F4E                                    ; $000F44
        cmpi.w       #$f, rCurrentFloor(a6)                        ; $000F46
        beq.b        loc_000F80                                    ; $000F4C

loc_000F4E:
        lea.l        CharacterStartingEquipment(pc), a0            ; $000F4E
        move.w       rSelectedCharacter(a6), d0                    ; $000F52
        lsl.w        #$3, d0                                       ; $000F56
        adda.w       d0, a0                                        ; $000F58
        move.w       (a0)+, d0                                     ; $000F5A
        beq.b        loc_000F7A                                    ; $000F5C
        move.w       (a0)+, rItemGrantAmountOverride(a6)                             ; $000F5E
        move.l       a0, -(a7)                                     ; $000F62
        jsr          GrantInventoryItem.l                            ; $000F64
        movea.l      (a7)+, a0                                     ; $000F6A
        move.w       (a0)+, d0                                     ; $000F6C
        beq.b        loc_000F7A                                    ; $000F6E
        move.w       (a0)+, rItemGrantAmountOverride(a6)                             ; $000F70
        jsr          GrantInventoryItem.l                            ; $000F74

loc_000F7A:
        clr.w        rItemGrantAmountOverride(a6)                                    ; $000F7A
        rts                                                        ; $000F7E

loc_000F80:
        tst.w        rLinkRole(a6)                                 ; $000F80
        beq.b        loc_000F7A                                    ; $000F84
        move.w       #$3ff, d7                                     ; $000F86
        clr.w        d0                                            ; $000F8A
        lea.l        rCellTypeByIndex(a6), a1                      ; $000F8C

loc_000F90:
        move.b       (a0)+, d0                                     ; $000F90
        move.b       (a1, d0.w), d0                                ; $000F92
        cmpi.b       #$6a, d0                                      ; $000F96
        beq.b        loc_000FA2                                    ; $000F9A
        dbra         d7, loc_000F90                                ; $000F9C
        rts                                                        ; $000FA0

loc_000FA2:
        clr.b        -$1(a0)                                       ; $000FA2
        rts                                                        ; $000FA6
        ifne *-$FA8
        fail "ROM end moved"
        endif
