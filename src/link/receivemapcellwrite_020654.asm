; $020654..$020661 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [⇐June 1A9CA] RAM-реестр -0x7116/-0x711A (список клеток/акторов, аналог реестров обломков)
        ifne *-$20654
        fail "ROM start moved"
        endif

ReceiveMapCellWrite:
; Link command $03: byte + absolute destination pointer, then CommitVisibleMapCell. No origin is transmitted.
        move.b       (a0)+, d0                                     ; $020654
        movea.l      (a0)+, a1                                     ; $020656
        move.b       d0, (a1)                                      ; $020658
        jsr          CommitVisibleMapCell.l                        ; $02065A
        rts                                                        ; $020660
        ifne *-$20662
        fail "ROM end moved"
        endif
