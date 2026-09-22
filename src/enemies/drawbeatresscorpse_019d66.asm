; $019D66..$019DF1 | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; Ordinary final corpse2/3. CB/CC draw decrements counter4..1 using animation3 frames1,2,2,3. C8/C9 switches to DogSpriteBank, animation5/frame4.
        ifne *-$19D66
        fail "ROM start moved"
        endif

DrawBeatressCorpse:
; Ordinary final corpse2/3. CB/CC draw decrements counter4..1 using animation3 frames1,2,2,3. C8/C9 switches to DogSpriteBank, animation5/frame4.
        cmpi.b       #$c9, ActorDeathMode(a0)                      ; $019D66
        beq.w        loc_019DA4                                    ; $019D6C
        cmpi.b       #$c8, ActorDeathMode(a0)                      ; $019D70
        beq.w        loc_019DBA                                    ; $019D76
        cmpi.b       #$cc, ActorDeathMode(a0)                      ; $019D7A
        beq.w        loc_019E28                                    ; $019D80
        cmpi.b       #$cb, ActorDeathMode(a0)                      ; $019D84
        beq.w        loc_019DD0                                    ; $019D8A
        cmpi.l       #$1fecaa, ActorSpriteBank(a0)                 ; $019D8E
        move.w       #$2, d0                                       ; $019D96
        move.w       #$3, d2                                       ; $019D9A
        jmp          DrawActorAnimation.l                          ; $019D9E

loc_019DA4:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $019DA4
        move.w       #$5, d0                                       ; $019DAC
        move.w       #$4, d2                                       ; $019DB0
        jmp          DrawActorAnimation.l                          ; $019DB4

loc_019DBA:
        move.l       #DogSpriteBank, ActorSpriteBank(a0)           ; $019DBA
        move.w       #$5, d0                                       ; $019DC2
        move.w       #$4, d2                                       ; $019DC6
        jmp          DrawActorAnimation.l                          ; $019DCA

loc_019DD0:
        cmpi.b       #$4, ActorStateCounter(a0)                    ; $019DD0
        beq.b        DrawBeatressCorpseTransition                  ; $019DD6
        cmpi.b       #$3, ActorStateCounter(a0)                    ; $019DD8
        beq.b        loc_019E04                                    ; $019DDE
        cmpi.b       #$2, ActorStateCounter(a0)                    ; $019DE0
        beq.b        loc_019E04                                    ; $019DE6
        cmpi.b       #$1, ActorStateCounter(a0)                    ; $019DE8
        beq.b        loc_019E16                                    ; $019DEE
        rts                                                        ; $019DF0
        ifne *-$19DF2
        fail "ROM end moved"
        endif
