; $07A8C8..$07A8D3 | m68k
; Maintained assembly input; no extraction occurs during build.
; Write the $FF host-command prefix, then fall through to
; WriteGemsCommandByte at $07A8D4: D0 supplies the opcode and that helper
; publishes the ring write index. There is deliberately no RTS here.
        ifne *-$7A8C8
        fail "ROM start moved"
        endif

WriteGemsCommandPrefixAndOpcode:
        move.b       #$ff, (a1, d1.w)                              ; $07A8C8
        addq.b       #$1, d1                                       ; $07A8CE
        andi.b       #$3f, d1                                      ; $07A8D0
        ifne *-$7A8D4
        fail "ROM end moved"
        endif
