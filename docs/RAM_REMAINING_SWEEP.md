# Заключительный проход по числовым A6-адресам

Область действия: июльский BZT Build 071395a, игровой код 68000 с
`A6=$FF8000`. В этом проходе рассмотрены **120 адресов / 444 A6-обращения**,
оставшиеся после предыдущего аудита **отрицательных A6-смещений** RAM. Они названы в `include/ram.inc`, а
все эти обращения и найденные прямые абсолютные ссылки заменены на символы в редактируемом `.asm`. Для каждого адреса
в `tools/ram_remaining_spec.py` закреплена исходная инструкция-свидетель.
На момент этого прохода каталог содержал **266 проверенных адресов**, **517 уникальных
инструкций-свидетелей** и **0 неименованных отрицательных A6-адресов**. Позднее
положительные смещения были разобраны отдельно в [RAM_POSITIVE_A6.md](RAM_POSITIVE_A6.md);
теперь каталог содержит 275 адресов и 535 инструкций-свидетелей. Косвенная индексация
буферов, другие формы абсолютной адресации и стек A6 драйвера GEMS не
становятся от этого полностью известной картой RAM.

Часть из 120 адресов — младшие байты уже названных слов (`ControllerStateLow`,
`PlayerHealthLow`, координаты окна карты, слоты инвентаря). `TitleLayer0…4`
лежат внутри одного 32-байтного блока; `SoftwareSpriteOutputBaseMinusFour`
и `LaserReticleFrameSampleBase` — адреса для вычисления указателя внутри
программного кадра, а не новые свободные буферы. Соседние байты
`$FF10AA..$FF10AF` принадлежат разным полям сохранённого эффекта: нельзя
считать `$FF10AB` младшим байтом флага в `$FF10AA` или `$FF10AC` старшим
байтом бюджета в `$FF10AD`.

Границы доказанного также существенны. `WallChangeRefreshFlag` здесь имеет
несколько записей и не имеет прямого декодированного читателя. Несколько
панорамных эффектов сохранены в коде, но обычная достижимость их отрисовщика
не установлена. Парольный цикл перестановки обращается к `$FF2C66`, где
также лежит `LinkPortStatusShadow`: link interrupt проверяет его на `$2100`.
Условная порча проверки возможна, но игровой сценарий не воспроизведён. Подробности —
[формат паролей](PASSWORD_FORMAT.md) и [основной RAM-аудит](RAM_AUDIT.md).

| RAM | Имя | Байты | Наблюдаемая роль | Исходная инструкция |
|---|---|---:|---|---|
| `$FF0001` | `VBlankCounterLow` | 1 | low byte of the existing VBlankCounter word, tested by pause input | `$002E22` |
| `$FF0004` | `BootInitializationMarker` | 2 | set to $FFFF after the first work-RAM clear; later boots skip that clear | `$0006A2` |
| `$FF0006` | `RandomSeed` | 4 | PRNG long saved and restored around scene and character transitions | `$0011F2` |
| `$FF0015` | `SoundOptionsLow` | 1 | low byte of SoundOptions tested by the status-message sound path | `$020C7A` |
| `$FF002F` | `ControllerStateLow` | 1 | direction bits of the existing controller-state word | `$00E33A` |
| `$FF0033` | `PreviousControllerStateLow` | 1 | direction bits of the previous controller-state word | `$00E342` |
| `$FF06F2` | `VisibleObjectCellTypeIndex` | 1 | RAM index of cell type $85 found at scene load and read by map-object routines | `$001284` |
| `$FF06F4` | `MenuVramWriteAddressOffset` | 4 | long added to menu tilemap VDP write-address commands | `$021FF2` |
| `$FF06F8` | `PaletteFadeCurrentColors` | buffer | 256-byte working CRAM-color buffer used by both fade directions | `$001C42` |
| `$FF07F8` | `PaletteFadeStableStepCount` | 2 | fade convergence counter, compared with 2 or $14 by fade paths | `$0226FE` |
| `$FF07FA` | `PaletteFadeTargetColorsPointer` | 4 | source palette pointer used by component-wise fade | `$001C5E` |
| `$FF07FE` | `PaletteFadeComponentIndex` | 1 | cycling R/G/B component index 0..2 | `$001C6C` |
| `$FF07FF` | `PaletteFadeHalfRateToggle` | 1 | bit 1 toggled to run component stepping on alternating calls | `$02262A` |
| `$FF0874` | `TitleScrollState` | 2 | title scroll setup/return state; retained effect also tests it | `$022EB4` |
| `$FF0876` | `RetainedWallEffectOffset` | 2 | signed displacement decremented in retained wall-renderer screen effect | `$028818` |
| `$FF0878` | `RetainedWallEffectScale` | 2 | scale/phase word advanced in retained wall-renderer screen effect | `$02881C` |
| `$FF087A` | `TitleScrollTrack0Ticks` | 2 | first title-scroll script countdown and frame-selector input | `$022F38` |
| `$FF087C` | `TitleScrollTrack1Ticks` | 2 | second title-scroll script countdown and frame-selector input | `$022F4E` |
| `$FF087E` | `TitleScrollTrack0Pointer` | 4 | current read pointer in first title-scroll word sequence | `$022F3E` |
| `$FF0882` | `TitleScrollTrack1Pointer` | 4 | current read pointer in second title-scroll word sequence | `$022F54` |
| `$FF0886` | `TitleScrollCurve0Pointer` | 4 | first current title animation curve pointer | `$022F90` |
| `$FF088A` | `TitleScrollCurve1Pointer` | 4 | second current title animation curve pointer | `$022FC0` |
| `$FF0914` | `PauseMapCharacterCursorByte` | 1 | byte cached and compared before advancing the pause-map character sequence | `$002F04` |
| `$FF0915` | `PauseMapAndHitFlashToggle` | 1 | byte toggled by pause-map animation and tested on player hit | `$00E024` |
| `$FF0916` | `PauseMapCharacterSequencePointer` | 4 | pointer into TitleCharacterOrder advanced by the pause-map loop | `$002C48` |
| `$FF091A` | `PauseMapSecondaryCursorByte` | 1 | second cached byte in pause-map animated sequence | `$002F3E` |
| `$FF091C` | `PauseMapSecondarySequencePointer` | 4 | second pause-map animation pointer | `$002C50` |
| `$FF0920` | `TitleScrollVerticalOffset` | 2 | word advanced by two and used for title screen tilemap scroll | `$022EC0` |
| `$FF0922` | `TitleScrollFrameDivider` | 2 | title frame divider cycling over four iterations | `$022EC4` |
| `$FF0924` | `TitleScrollDisplacement` | 2 | signed title-scroll displacement reduced by two until limit | `$022EC8` |
| `$FF0926` | `TitleScrollLayerWords` | buffer | start of 32-byte RAM block cleared and uploaded as title layer words | `$023214` |
| `$FF0928` | `TitleLayer0Long` | 4 | long part of six-byte title sprite layer record 0 | `$0232A6` |
| `$FF092C` | `TitleLayer0Word` | 2 | word part of six-byte title sprite layer record 0 | `$0232AA` |
| `$FF092E` | `TitleLayer1Long` | 4 | long part of six-byte title sprite layer record 1 | `$023290` |
| `$FF0932` | `TitleLayer1Word` | 2 | word part of six-byte title sprite layer record 1 | `$023294` |
| `$FF0934` | `TitleLayer2Long` | 4 | long part of six-byte title sprite layer record 2 | `$02327A` |
| `$FF0938` | `TitleLayer2Word` | 2 | word part of six-byte title sprite layer record 2 | `$02327E` |
| `$FF093A` | `TitleLayer3Long` | 4 | long part of six-byte title sprite layer record 3 | `$023264` |
| `$FF093E` | `TitleLayer3Word` | 2 | word part of six-byte title sprite layer record 3 | `$023268` |
| `$FF0940` | `TitleLayer4Long` | 4 | long part of six-byte title sprite layer record 4 | `$02324E` |
| `$FF0944` | `TitleLayer4Word` | 2 | word part of six-byte title sprite layer record 4 | `$023252` |
| `$FF0946` | `TitleScrollLayerWordsEnd` | buffer | one-past-end pointer for the 32-byte title layer block | `$022CA2` |
| `$FF0DDA` | `InitialVideoPortSnapshot` | 4 | VDP control-port long copied during gameplay video initialization | `$00296A` |
| `$FF0DDE` | `RetainedPanoramaTileDelay` | 2 | delay word in retained panorama tile animation | `$001974` |
| `$FF0DE0` | `RetainedPanoramaTileState0` | 4 | first cleared retained panorama tile-animation work long | `$001978` |
| `$FF0DE4` | `RetainedPanoramaTileState1` | 4 | second cleared retained panorama tile-animation work long | `$00197C` |
| `$FF0DE8` | `RetainedPanoramaTileState2` | 4 | third cleared retained panorama tile-animation work long | `$001980` |
| `$FF0DF3` | `PlayerHealthLow` | 1 | low byte of PlayerHealth; saved health is copied through it | `$001AE8` |
| `$FF0DF4` | `PlayerHealthBeforeHit` | 2 | health snapshot used to detect threshold crossings after damage | `$00E090` |
| `$FF0E34` | `ItemsCollectedCount` | 2 | incremented after accepted ordinary-item or medipack pickup | `$012804` |
| `$FF0E44` | `MedipacksCollectedCount` | 2 | incremented by medipack pickup and compared on status screen | `$001ADE` |
| `$FF0E46` | `EpisodeMedipackCellTotal` | 2 | episode-load count of cell type $25 used with medipacks collected | `$0974BA` |
| `$FF0E48` | `ObjectiveCellTypeIndexScratch` | 1 | cell index for type $79 cached while counting objectives in map | `$0973E8` |
| `$FF0E4A` | `GameClockFrameTicks` | 1 | unpaused VBlank counter rolling over at 60 | `$000E24` |
| `$FF0E4B` | `GameClockSeconds` | 1 | seconds counter rolling over at 60 and displayed in status | `$000A9E` |
| `$FF0E4C` | `GameClockMinutes` | 1 | minutes counter rolling over at 60 and displayed in status | `$000AAE` |
| `$FF0E4D` | `GameClockHours` | 1 | hours counter incremented on minute rollover | `$000ABE` |
| `$FF0E52` | `ViewSwayWeaponPhaseScratch` | 2 | view-sway word carried into weapon switch/draw | `$00F7AC` |
| `$FF0E54` | `ViewSwaySavedFacingAngle` | 2 | original PlayerFacingAngle restored after temporary sway | `$00F7B4` |
| `$FF0E56` | `ViewSwaySavedFacingVectorX` | 2 | original facing X vector restored after temporary sway | `$00F7BA` |
| `$FF0E58` | `ViewSwaySavedFacingVectorY` | 2 | original facing Y vector restored after temporary sway | `$00F7C0` |
| `$FF0E5A` | `ViewSwaySavedOffsetZ` | 2 | original PlayerViewOffsetZ restored after temporary sway | `$00F7C6` |
| `$FF0E8C` | `WallSlopeTextureUStart` | 2 | original wall U start saved before advance and used in sloped-span interpolation | `$00D8F4` |
| `$FF0EAD` | `PlayerForwardSpeedLow` | 1 | low byte of PlayerForwardSpeed transmitted in local player link state | `$02041A` |
| `$FF0EE1` | `GameTickLow` | 1 | low byte of GameTick tested by animation and rendering callbacks | `$01DF1E` |
| `$FF0EE2` | `WallChangeRefreshFlag` | 2 | set to 1 by wall changes and scene entries; direct decoded reader not found | `$00AD3C` |
| `$FF1022` | `NearestActorScanRemaining` | 2 | working countdown copied from actor count during nearest-target scan | `$01E524` |
| `$FF1054` | `PauseMapFloorLabelIndex` | 2 | floor label index copied for pause-map text rendering | `$003808` |
| `$FF1061` | `InventorySlot0ItemIdLow` | 1 | low byte of ordinary inventory slot 0 item ID | `$000E8C` |
| `$FF1062` | `InventorySlot0QuantityHigh` | 1 | high byte of slot 0 amount word copied into saved progress | `$000E92` |
| `$FF1065` | `InventorySlot1ItemIdLow` | 1 | low byte of ordinary inventory slot 1 item ID | `$000E98` |
| `$FF1066` | `InventorySlot1QuantityHigh` | 1 | high byte of slot 1 amount word copied into saved progress | `$000E9E` |
| `$FF1069` | `InventorySlot2ItemIdLow` | 1 | low byte of ordinary inventory slot 2 item ID | `$000EA4` |
| `$FF106A` | `InventorySlot2QuantityHigh` | 1 | high byte of slot 2 amount word copied into saved progress | `$000EAA` |
| `$FF106D` | `InventorySlot3ItemIdLow` | 1 | low byte of ordinary inventory slot 3 item ID | `$000EB0` |
| `$FF106E` | `InventorySlot3QuantityHigh` | 1 | high byte of slot 3 amount word copied into saved progress | `$000EB6` |
| `$FF1071` | `InventorySlot4ItemIdLow` | 1 | low byte of ordinary inventory slot 4 item ID | `$000EBC` |
| `$FF1072` | `InventorySlot4QuantityHigh` | 1 | high byte of slot 4 amount word copied into saved progress | `$000EC2` |
| `$FF1091` | `WeaponActionPhaseLow` | 1 | low byte of WeaponActionPhase tested in retained weapon 04 draw | `$013822` |
| `$FF1093` | `UnarmedAttackVariantLow` | 1 | low byte of UnarmedAttackVariant tested for attack choice | `$0135DA` |
| `$FF10A8` | `PlayerDamageFlashColor` | 2 | CRAM color word decayed by VBlank after player damage | `$00E02A` |
| `$FF10AB` | `RetainedPanoramaHorizontalPhase` | 1 | random 0..$78 horizontal phase added to retained sprite X | `$00235E` |
| `$FF10AC` | `RetainedPanoramaEffectPreset` | 1 | retained effect byte initialized to 4; downstream role not established | `$002588` |
| `$FF10AF` | `RetainedPanoramaEffectPending` | 1 | separate pending flag tested by retained sprite renderer | `$002794` |
| `$FF10B0` | `RetainedPanoramaSpriteScreenX` | 2 | X position saved while emitting retained panorama sprite | `$0027F0` |
| `$FF10B2` | `RetainedPanoramaMarkerArmed` | 1 | nonzero flag for pending retained panorama marker | `$0027E0` |
| `$FF10B3` | `RetainedPanoramaMarkerTicks` | 1 | retained panorama marker countdown | `$002302` |
| `$FF10B4` | `SceneShiftOrRetainedPanoramaX` | 2 | shared screen-shift word also updated by retained panorama position tracker | `$0027E6` |
| `$FF10B6` | `RetainedPanoramaMarkerY` | 2 | marker position initialized to $D0 and read by retained animation | `$0027A2` |
| `$FF10B8` | `InventoryRandomSelectionScratch` | buffer | temporary byte array used while reducing a random inventory amount | `$0179EC` |
| `$FF10CF` | `SoftwareSpriteMirrorFlagLow` | 1 | low byte of SoftwareSpriteMirrorFlag copied from frame descriptor | `$01FCC2` |
| `$FF11B5` | `TransitHeightOffsetLow` | 1 | low byte of TransitHeightOffset read by type $30 face-profile builder | `$009210` |
| `$FF11C2` | `WallSlopeHeightAccumulator` | 2 | per-column sloped wall height accumulator | `$00DA3E` |
| `$FF11C4` | `WallSlopeHeightStep` | 2 | sloped wall height delta added each column | `$00D930` |
| `$FF2A42` | `RemoteHitCommandVariant` | 1 | selects link hit command $07 instead of $06 during local/remote hit handling | `$001058` |
| `$FF2A43` | `RemoteHitCommandSpecial` | 1 | selects link hit command $1A ahead of ordinary hit variants | `$00105C` |
| `$FF2A52` | `CurrentSoundSequenceId` | 2 | sequence ID written by GEMS wrapper and compared in game-flow/transit handlers | `$00F0C8` |
| `$FF2A64` | `RetainedSceneLoopGate` | 2 | scene-entry clear and gameplay-loop test; no nonzero game-code writer found | `$001074` |
| `$FF2A70` | `LastStrideSoundPhase` | 2 | last stride phase cached to avoid replaying same step sound | `$001060` |
| `$FF2A7C` | `RetainedEpisodePasswordText` | buffer | nine-character source buffer read by retained episode/password formatter | `$001A9E` |
| `$FF2A86` | `SceneProgressPasswordText` | buffer | scene secured text and destination for encoded progress password | `$001096` |
| `$FF2C5E` | `LinkTransferFailureCount` | 2 | cleared before transfer, incremented on link timeout, tested after each piece | `$0200A0` |
| `$FF2C62` | `LinkRetryDelay` | 2 | failure backoff word temporarily zeroed around selected link transfers | `$0012F4` |
| `$FF2C64` | `LinkTransferModeShadow` | 2 | link mode word temporarily set to $2000 while sending | `$0012F8` |
| `$FF2C66` | `LinkPortStatusShadow` | 2 | $2100/$2500 link-port mode shadow read by link IRQ/video; password overrun can touch its low byte | `$01FF70` |
| `$FF2C68` | `LinkReceiveReadOffset` | 2 | byte offset of next word to dequeue from RX ring | `$020010` |
| `$FF2C6A` | `LinkReceiveWriteOffset` | 2 | byte offset after last word received in RX ring | `$020014` |
| `$FF2C6C` | `LinkTransmitReadOffset` | 2 | byte offset of next TX-ring word to transmit | `$01FFEE` |
| `$FF2C6E` | `LinkTransmitWriteOffset` | 2 | byte offset after last queued TX-ring word | `$01FFD2` |
| `$FF2C70` | `LinkReceiveRing` | buffer | $800-byte ring of received link-command words | `$020020` |
| `$FF3470` | `LinkTransmitRing` | buffer | $800-byte ring of queued outgoing command words | `$01FFCE` |
| `$FF3C73` | `MapWindowOriginXLow` | 1 | low byte of MapWindowOriginX used by enemy and train position paths | `$0978DE` |
| `$FF3C75` | `MapWindowOriginYLow` | 1 | low byte of MapWindowOriginY used by enemy and train position paths | `$0978E2` |
| `$FF3D5C` | `MapCellParityPhase` | 1 | byte toggled while selecting alternating visible-map cell entries | `$00F5E8` |
| `$FF3D62` | `VisibleMapObjectCoordinates` | buffer | terminated X/Y byte pairs of visible type-$85 map objects | `$0033AA` |
| `$FF5D9E` | `PauseMapPanX` | 2 | horizontal offset moved by pause-map controller and used in cell/object projection | `$003420` |
| `$FF5DA0` | `PauseMapPanY` | 2 | vertical offset moved by pause-map controller and used in cell/object projection | `$003406` |
| `$FF5EB6` | `PauseMapRenderPassSelector` | 2 | signed selector choosing first or second pause-map render pass | `$001194` |
| `$FF6246` | `SoftwareSpriteOutputBaseMinusFour` | buffer | base pointer four bytes before packed viewport used by tile scaler | `$00F97A` |
| `$FF76EA` | `LaserReticleFrameSampleBase` | buffer | interior software-framebuffer offset sampled to place laser reticle | `$013BA6` |
