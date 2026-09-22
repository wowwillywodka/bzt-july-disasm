; $020662..$020699 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x20654] [⇐June 1A9CA] RAM-реестр -0x7116/-0x711A (список клеток/акторов, аналог реестров обломков)
        ifne *-$20662
        fail "ROM start moved"
        endif

FindRemoteActorFromPacket:
; In A0=packet cursor; out A3=payload. Find remote actor by link ID and flag $20; D7=1/Z=0 if found.
        move.b       (a0)+, d0                                     ; $020662
        movea.l      a0, a3                                        ; $020664
        move.w       rActiveActorCount(a6), d7                     ; $020666
        bne.b        loc_020672                                    ; $02066A
        move.w       #$0, d7                                       ; $02066C
        rts                                                        ; $020670

loc_020672:
        subq.w       #$1, d7                                       ; $020672
        movea.l      rActiveActorHead(a6), a0                      ; $020674

loc_020678:
        cmp.b        ActorLinkId(a0), d0                           ; $020678
        bne.b        loc_020688                                    ; $02067C
        move.w       ActorFlags(a0), d1                            ; $02067E
        andi.w       #$20, d1                                      ; $020682
        bne.b        loc_020694                                    ; $020686

loc_020688:
        movea.l      (a0), a0                                      ; $020688
        dbra         d7, loc_020678                                ; $02068A
        move.w       #$0, d7                                       ; $02068E
        rts                                                        ; $020692

loc_020694:
        move.w       #$1, d7                                       ; $020694
        rts                                                        ; $020698
        ifne *-$2069A
        fail "ROM end moved"
        endif
