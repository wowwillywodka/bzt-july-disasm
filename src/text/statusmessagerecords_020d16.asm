; $020D16..$0215D1 | text
; ROM-derived payload. Run `make extract ROM=/path/to/prototype.bin`.
        ifne *-$20D16
        fail "ROM start moved"
        endif

StatusMessageRecords equ $020D16
StatusMessageBulletProofVestCollected equ $020D3E
StatusMessageGunrockCollected equ $020D66
StatusMessageSnowmanCollected equ $020D8E
StatusMessageFlashLightCollected equ $020DB6
StatusMessageHandGrenadeCollected equ $020DDE
StatusMessageBuligunCollected equ $020E06
StatusMessageGunrockCollected2 equ $020E2E
StatusMessageNightVisionCollected equ $020E56
StatusMessageLaserAimedGunCollected equ $020E7E
StatusMessageRocketLauncherCollected equ $020EA6
StatusMessageShotgunCollected equ $020ECE
StatusMessageFlameThrowerCollected equ $020EF6
StatusMessagePulseLaserCollected equ $020F1E
StatusMessageBioScannerCollected equ $020F46
StatusMessageMedipackCollected equ $020F6E
StatusMessageSteppingOneFloorUp equ $020F96
StatusMessageSteppingOneFloorDown equ $020FBE
StatusMessageFloorSecured equ $020FE6
StatusMessageFloorNotSecured equ $02100E
StatusMessage2PlayerConnecTionLost equ $021036
StatusMessageBlank equ $02105C
StatusMessageHealthConditionLow equ $021082
StatusMessageHealthConditionCritical equ $0210AA
StatusMessageAmmuNitionIsLow equ $0210D2
StatusMessageEliminateAllEnemies equ $0210FA
StatusMessageZeroEnemiesRemaining equ $021122
StatusMessageProceedToNextLevel equ $02114A
StatusMessageEnteringDockingBayLevel1 equ $021172
StatusMessageEnteringDockingBayLevel2 equ $02119A
StatusMessageEnteringBridgeLevel1 equ $0211C2
StatusMessageEnteringEngineLevel1 equ $0211EA
StatusMessageEnteringEngineLevel2 equ $021212
StatusMessageEnteringEngineLevel3 equ $02123A
StatusMessageEnteringEngineLevel4 equ $021262
StatusMessageEnteringGreenHouseLevel1 equ $02128A
StatusMessageEnteringGreenHouseLevel2 equ $0212B2
StatusMessageEnteringGreenHouseLevel3 equ $0212DA
StatusMessageEnteringBridgeLevel2 equ $021302
StatusMessageEnteringReactorLevel1 equ $02132A
StatusMessageEnteringReactorLevel2 equ $021352
StatusMessageEnteringFloor165 equ $02137A
StatusMessageEnteringFloor164 equ $0213A2
StatusMessageEnteringFloor163 equ $0213CA
StatusMessageEnteringFloor162 equ $0213F2
StatusMessageEnteringFloor161 equ $02141A
StatusMessageEnteringFloor160 equ $021442
StatusMessageEnteringFloor159 equ $02146A
StatusMessageEnteringFloor158 equ $021492
StatusMessageEnteringFloor157 equ $0214BA
StatusMessageEnteringFloor156 equ $0214E2
StatusMessageEnteringFloor155 equ $02150A
StatusMessageEnteringFloor154 equ $021532
StatusMessageEnteringFloor153 equ $02155A
StatusMessageEnteringFloor152 equ $021582
StatusMessageEnteringFloor151 equ $0215AA

        incbin "generated/data/020d16.bin"
        ifne *-$215D2
        fail "ROM end moved"
        endif
