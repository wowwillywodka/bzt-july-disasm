; $01C2EE..$01C35B | m68k
; Maintained assembly input; no extraction occurs during build.
; RESEARCH NOTE (July; semantic claims still require local review):
; [внутри старой 0x1C222] Таблица указателей типов актёров (capstone-мусор ori.b — это данные) + инит-рутина актёра по 0x1c2ee: ставит vtable 0x1f8f8/0x1f93a/0x1d130/0x1f8d0, аним-данные 0x2b58e0, тип 0x35
        ifne *-$1C2EE
        fail "ROM start moved"
        endif

loc_01C2EE:
        bra.w        RemoveActor                                   ; $01C2EE

loc_01C2F2:
        andi.w       #$ff2f, ActorFlags(a0)                        ; $01C2F2
        move.l       #$1f8f8, ActorUpdateCallback(a0)              ; $01C2F8
        clr.b        ActorUpdateDelay(a0)                          ; $01C300
        move.l       #$1f93a, ActorHitCallback(a0)                 ; $01C304
        move.l       #EnvironmentRoutine_01D130, ActorExitCallback(a0) ; $01C30C
        move.l       #DrawLegacyDeathEffect, ActorDrawCallback(a0) ; $01C314
        clr.w        ActorMotionX(a0)                              ; $01C31C
        clr.w        ActorMotionY(a0)                              ; $01C320
        move.l       #LegacyDeathEffectSpriteBank, ActorSpriteBank(a0) ; $01C324
        move.b       #$35, ActorCorpseCellProfile(a0)              ; $01C32C
        rts                                                        ; $01C332

loc_01C334:
        jmp          StartProjectileExplosionAndWallStages.l       ; $01C334

loc_01C33A:
        clr.w        -$55a0(a6)                                    ; $01C33A
        clr.w        -$559e(a6)                                    ; $01C33E
        move.w       #$e, d0                                       ; $01C342
        move.l       a0, -(a7)                                     ; $01C346
        jsr          SoundRoutine_00DF64.l                         ; $01C348
        movea.l      (a7)+, a0                                     ; $01C34E
        move.w       #$1e, -$559e(a6)                              ; $01C350
        jmp          StartProjectileExplosionAndWallStages.l       ; $01C356
        ifne *-$1C35C
        fail "ROM end moved"
        endif
