; $012300..$012397 | m68k
; Maintained assembly input; no extraction occurs during build.
; CLASSIFICATION: Reviewed retained instruction island: legal 68000 instructions, local branches/known calls and neighboring routine structure; ordinary reachability not established.
; JULY LOCAL REVIEW:
; Retained tile-11 entry has no world-table selector. Later entries in this same old island ARE targeted by WorldObjectDrawHandlers; the island label does not make them dead.
        ifne *-$12300
        fail "ROM start moved"
        endif

RetainedObjectTileSources:
; Retained tile-11 entry has no world-table selector. Later entries in this same old island ARE targeted by WorldObjectDrawHandlers; the island label does not make them dead.
        movea.l      rZoneObjectTiles(a6), a1                      ; $012300
        adda.w       #ObjectTileOffset11_RetainedPickup, a1        ; $012304
        bra.w        DrawSmallObjectTile                           ; $012308
        movea.l      rZoneObjectTiles(a6), a1                      ; $01230C
        adda.w       #ObjectTileOffset15_SnowmanPickup, a1         ; $012310
        move.w       d5, d4                                        ; $012314
        asr.w        #$1, d4                                       ; $012316
        move.w       d4, d0                                        ; $012318
        asr.w        #$1, d0                                       ; $01231A
        sub.w        d0, d2                                        ; $01231C
        move.w       d4, d3                                        ; $01231E
        asr.w        #$1, d3                                       ; $012320
        sub.w        d3, d1                                        ; $012322
        clr.w        rSoftwareSpriteMirrorFlag(a6)                                    ; $012324
        bra.w        ScaleAndDrawSoftwareSpriteTile                ; $012328

loc_01232C:
        movea.l      rZoneObjectTiles(a6), a1                      ; $01232C
        adda.w       #ObjectTileOffset04_FlashlightPickup, a1      ; $012330
        bra.w        DrawSmallObjectTile                           ; $012334

loc_012338:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012338
        adda.w       #ObjectTileOffset13_HandGrenadePickup, a1     ; $01233C
        bra.w        DrawSmallObjectTile                           ; $012340

loc_012344:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012344
        adda.w       #ObjectTileOffset14_BuligunPickup, a1         ; $012348
        bra.w        DrawSmallObjectTile                           ; $01234C

loc_012350:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012350
        adda.w       #ObjectTileOffset15_SnowmanPickup, a1         ; $012354
        bra.w        DrawSmallObjectTile                           ; $012358

loc_01235C:
        movea.l      rZoneObjectTiles(a6), a1                      ; $01235C
        adda.w       #ObjectTileOffset16_GunrockPickup, a1         ; $012360
        bra.w        DrawSmallObjectTile                           ; $012364

loc_012368:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012368
        adda.w       #ObjectTileOffset07_NightVisionPickup, a1     ; $01236C
        bra.w        DrawSmallObjectTile                           ; $012370

loc_012374:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012374
        adda.w       #ObjectTileOffset05_LaserAimedGunPickup, a1   ; $012378
        bra.w        DrawSmallObjectTile                           ; $01237C

loc_012380:
        movea.l      rZoneObjectTiles(a6), a1                      ; $012380
        adda.w       #ObjectTileOffset06_RocketLauncherOrGunrockPickup, a1 ; $012384
        bra.w        DrawSmallObjectTile                           ; $012388

loc_01238C:
        movea.l      rZoneObjectTiles(a6), a1                      ; $01238C
        adda.w       #ObjectTileOffset12_ShotgunPickup, a1         ; $012390
        bra.w        DrawSmallObjectTile                           ; $012394
        ifne *-$12398
        fail "ROM end moved"
        endif
