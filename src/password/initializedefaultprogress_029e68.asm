; $029E68..$029EC9 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Fill five saved inventory IDs (1,3,$B,$C,$E), their
; amount bytes $63, all five character-available flags and saved health $63.
; The first two special password phrases call this before setting selection.
        ifne *-$29E68
        fail "ROM start moved"
        endif

InitializeDefaultProgress:
        move.b       #$1, rSavedInventoryItem0(a6)                 ; $029E68
        move.b       #$63, rSavedInventoryAmount0(a6)              ; $029E6E
        move.b       #$3, rSavedInventoryItem1(a6)                 ; $029E74
        move.b       #$63, rSavedInventoryAmount1(a6)              ; $029E7A
        move.b       #$b, rSavedInventoryItem2(a6)                 ; $029E80
        move.b       #$63, rSavedInventoryAmount2(a6)              ; $029E86
        move.b       #$c, rSavedInventoryItem3(a6)                 ; $029E8C
        move.b       #$63, rSavedInventoryAmount3(a6)              ; $029E92
        move.b       #$e, rSavedInventoryItem4(a6)                 ; $029E98
        move.b       #$63, rSavedInventoryAmount4(a6)              ; $029E9E
        move.b       #$1, rCharacterAvailable0(a6)                 ; $029EA4
        move.b       #$1, rCharacterAvailable1(a6)                 ; $029EAA
        move.b       #$1, rCharacterAvailable2(a6)                 ; $029EB0
        move.b       #$1, rCharacterAvailable3(a6)                 ; $029EB6
        move.b       #$1, rCharacterAvailable4(a6)                 ; $029EBC
        move.b       #$63, rSavedHealth(a6)                        ; $029EC2
        rts                                                        ; $029EC8
        ifne *-$29ECA
        fail "ROM end moved"
        endif
