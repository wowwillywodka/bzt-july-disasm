; $020534..$020567 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW: command $19 after a receiver-role-2 guard. Scans active
; actors and compares the same exit callback first to $1D880 and then to
; $1D25A; both cannot match. Thus the removal branch at $20564 is
; unreachable by ordinary execution. Preserve this prototype logic verbatim.
        ifne *-$20534
        fail "ROM start moved"
        endif

ScanActorsForLegacyExitCallbacks:
        movea.l      rActiveActorHead(a6), a0                      ; $020534
        move.w       rActiveActorCount(a6), d7                     ; $020538
        subq.w       #$1, d7                                       ; $02053C
        bmi.b        loc_020562                                    ; $02053E

loc_020540:
        cmpi.l       #$1d880, ActorExitCallback(a0)                ; $020540
        bne.b        loc_020554                                    ; $020548
        cmpi.l       #$1d25a, ActorExitCallback(a0)                ; $02054A
        beq.b        loc_020564                                    ; $020552

loc_020554:
        movea.l      (a0), a0                                      ; $020554
        cmpa.l       #$0, a0                                       ; $020556
        beq.b        loc_020562                                    ; $02055C
        dbra         d7, loc_020540                                ; $02055E

loc_020562:
        rts                                                        ; $020562

loc_020564:
        jmp          RemoveActorAndSendLink(pc)                    ; $020564
        ifne *-$20568
        fail "ROM end moved"
        endif
