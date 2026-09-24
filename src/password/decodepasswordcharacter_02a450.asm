; $02A450..$02A46F | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: Find the next input character in the 64-byte password
; code alphabet. Return its six-bit index in D0, or $2D if absent.
        ifne *-$2A450
        fail "ROM start moved"
        endif

DecodePasswordCharacter:
        lea.l        PasswordCodeAlphabet(pc), a3                  ; $02A450
        move.w       #$3f, d0                                      ; $02A454
        move.b       (a2)+, d2                                     ; $02A458

loc_02A45A:
        cmp.b        (a3)+, d2                                     ; $02A45A
        beq.b        loc_02A468                                    ; $02A45C
        dbra         d0, loc_02A45A                                ; $02A45E
        move.w       #$2d, d0                                      ; $02A462
        rts                                                        ; $02A466

loc_02A468:
        neg.w        d0                                            ; $02A468
        addi.w       #$3f, d0                                      ; $02A46A
        rts                                                        ; $02A46E
        ifne *-$2A470
        fail "ROM end moved"
        endif
