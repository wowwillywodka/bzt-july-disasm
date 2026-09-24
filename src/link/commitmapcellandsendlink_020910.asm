; $020910..$020943 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Reviewed July: persist an edited map cell; optional link command $03. See caller A1 caveat.
        ifne *-$20910
        fail "ROM start moved"
        endif

CommitMapCellAndSendLink:
; A0=modified cell; persist locally through A1. Link branch uses restored caller A1 for its byte/address payload.
        move.l       a1, -(a7)                                     ; $020910
        movea.l      a0, a1                                        ; $020912
        jsr          CommitVisibleMapCell.l                        ; $020914
        movea.l      (a7)+, a1                                     ; $02091A
        tst.w        rLinkRole(a6)                                 ; $02091C
        bne.b        loc_020924                                    ; $020920
        rts                                                        ; $020922

loc_020924:
        movem.l      d0-d7/a0-a3, -(a7)                            ; $020924
        lea.l        rSharedScratchBuffer(a6), a0                                ; $020928
        move.b       #$3, (a0)                                     ; $02092C
        move.b       (a1), $1(a0)                                  ; $020930
        move.l       a1, $2(a0)                                    ; $020934
        jsr          QueueLinkCommand.l                            ; $020938
        movem.l      (a7)+, d0-d7/a0-a3                            ; $02093E
        rts                                                        ; $020942
        ifne *-$20944
        fail "ROM end moved"
        endif
