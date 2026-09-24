; $001D16..$001D43 | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; Terminates the RAM SAT list at its tail, then queues a DMA transfer from
; SpriteAttributeTable to the VDP SAT at VRAM $B800.
        ifne *-$1D16
        fail "ROM start moved"
        endif

UploadSpriteTable:
        movea.l      rSpriteAttributeTableWritePointer(a6), a0                                ; $001D16
        cmpa.l       #ramSpriteAttributeTable, a0                                  ; $001D1A
        beq.b        loc_001D28                                    ; $001D20
        clr.b        -$5(a0)                                       ; $001D22
        bra.b        loc_001D2C                                    ; $001D26

loc_001D28:
        clr.l        (a0)+                                         ; $001D28
        clr.l        (a0)+                                         ; $001D2A

loc_001D2C:
        move.l       a0, d6                                        ; $001D2C
        move.l       #ramSpriteAttributeTable, d4                                  ; $001D2E
        sub.l        d4, d6                                        ; $001D34
        lsr.w        #$1, d6                                       ; $001D36
        move.l       #$b800, d5                                    ; $001D38
        jmp          QueueVramDma.l                                ; $001D3E
        ifne *-$1D44
        fail "ROM end moved"
        endif
