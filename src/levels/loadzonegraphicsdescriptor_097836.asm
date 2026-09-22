; $097836..$09787B | m68k
; Maintained assembly input; no extraction occurs during build.
; JULY LOCAL REVIEW:
; D0 selects a 56-byte zone graphics descriptor. Its wall pixels, sprite/wall remaps, floor color modes and five 160-byte background profiles are distinct resources; see docs/WALL_GRAPHICS.md.
        ifne *-$97836
        fail "ROM start moved"
        endif

LoadZoneGraphicsDescriptor:
; D0 selects a 56-byte zone graphics descriptor. Its wall pixels, sprite/wall remaps, floor color modes and five 160-byte background profiles are distinct resources; see docs/WALL_GRAPHICS.md.
        mulu.w       #$38, d0                                      ; $097836
        lea.l        ZoneGraphicsDescriptors.l, a0                 ; $09783A
        adda.w       d0, a0                                        ; $097840
        move.l       (a0)+, rZoneFloorColorModes(a6)               ; $097842
        move.l       (a0)+, rZoneScenePalette(a6)                  ; $097846
        move.l       (a0)+, rZoneEffectPalette(a6)                 ; $09784A
        move.l       (a0)+, rZoneSpriteColorRemaps(a6)             ; $09784E
        move.l       (a0)+, rZoneWallColorRemaps(a6)               ; $097852
        move.l       (a0)+, rZoneBackgroundProfile1(a6)            ; $097856
        move.l       (a0)+, rZoneBackgroundProfile2(a6)            ; $09785A
        move.l       (a0)+, rZoneBackgroundProfile0(a6)            ; $09785E
        move.l       (a0)+, rZoneBackgroundProfile3(a6)            ; $097862
        move.l       (a0)+, rZoneBackgroundProfile4(a6)            ; $097866
        move.l       (a0)+, rZoneWallTiles(a6)                     ; $09786A
        move.l       (a0)+, rZonePanoramaCompressedTiles(a6)       ; $09786E
        move.l       (a0)+, rZonePanoramaTilemap(a6)               ; $097872
        move.l       (a0)+, rZoneObjectTiles(a6)                   ; $097876
        rts                                                        ; $09787A
        ifne *-$9787C
        fail "ROM end moved"
        endif
