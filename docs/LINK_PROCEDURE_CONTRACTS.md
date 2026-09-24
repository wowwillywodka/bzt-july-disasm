# Контракты процедур последовательного link и актёрских пакетов

Проверено по инструкциям июльского BZT и таблице [`LinkCommandHandlers`](../src/link/linkcommandhandlers_0204be.asm). Здесь исправлена прежняя классификация: низкоуровневый обмен через порт второго контроллера относился к `input`, а приём/формирование сетевых состояний актёров — к `actors`. Эти входы выполняют **link-протокол**. Это статические контракты; успешный обмен между двумя экземплярами игры динамически здесь не заявляется.

## Передача и приём слов

[`TransmitLinkCommands`](../src/link/transmitlinkcommands_020088.asm) задаёт `A2=PAD2_CONTROL`, `A3=PAD2_DATA`, маски `D2=$0F`, `D3=$F0` и вызывает следующие входы. Все они используют таймаут `$FF2C64`; при его истечении увеличивают `$FF2C5E`. Вызвавший код проверяет этот счётчик. Пометки «слово» относятся к четырём 4-битным фазам в `D7`, а не к четырём отдельным командам link.

| Вход | Действие | Выход/побочный эффект |
| --- | --- | --- |
| [`WaitForLinkPeerLowAfterClearingStrobe`](../src/link/waitforlinkpeerlowafterclearingstrobe_01fdd4.asm) `$01FDD4` | Сбрасывает TR (бит 5), ждёт низкий TH (бит 6) | При ответе пишет `$2F` в `A2`; при таймауте увеличивает счётчик |
| [`TransmitLinkWordInNibbles`](../src/link/transmitlinkwordinnibbles_01fdf6.asm) `$01FDF6` | Посылает четыре фазы из `D7` через `A3`, чередуя TR и ожидая TH | Изменяет `D5–D7` и порт; при таймауте увеличивает счётчик |
| [`SetLinkPortDirectionAndWaitPeerHigh`](../src/link/setlinkportdirectionandwaitpeerhigh_01fe8a.asm) `$01FE8A` | Пишет `$20` в `A2`, поднимает TR и ждёт высокий TH | При таймауте увеличивает счётчик |
| [`ReceiveLinkWordInNibbles`](../src/link/receivelinkwordinnibbles_01feb6.asm) `$01FEB6` | Читает четыре фазы из `A3`, чередуя TR и ожидая TH | Собирает `D7`, меняет `D5`; при таймауте увеличивает счётчик |
| [`WaitForLinkPeerHighAndSetStrobe`](../src/link/waitforlinkpeerhighandsetstrobe_01ff30.asm) `$01FF30` | Ждёт высокий TH и поднимает TR | При таймауте увеличивает счётчик |

[`ConfigureLinkInitiatorPort`](../src/link/configurelinkinitiatorport_01ff4e.asm) `$01FF4E` захватывает Z80 bus, пишет VDP `$8B08`, настраивает `PAD2_CONTROL=$A0`, TR=1 и `SR=$2100`, затем освобождает bus. [`ResetLinkReceiverPortAndQueues`](../src/link/resetlinkreceiverportandqueues_01ff82.asm) `$01FF82` очищает четыре указателя RX/TX, ставит режим `$2500`, `PAD2_CONTROL=$20`, TR=1; его вызывает [`HandleLinkDisconnect`](../src/actors/handlelinkdisconnect_01c1a0.asm). Самостоятельный обычный вызов первого входа ещё надо подтвердить.

[`DequeueLinkCommand`](../src/link/dequeuelinkcommand_020010.asm) `$020010` принимает `A0` как буфер назначения. Если RX пуст, возвращает `D0=0`; иначе копирует команду по длине из [`LinkCommandSizes`](../src/link/linkcommandsizes_020386.asm), продвигает RX tail по маске `$7FF`, восстанавливает `A0` и возвращает `D0=1`. [`ServiceLinkUntilTxQueueEmpty`](../src/link/servicelinkuntiltxqueueempty_020058.asm) `$020058` ждёт VBlank, передаёт TX при роли 1, исполняет RX и повторяет, пока TX head не равен tail или роль не сброшена. Это цикл обслуживания, а не обработчик кнопок.

Таблица размеров ограничивает определённые команды максимум 14 байтами.
Отправитель состояния игрока для команды `$0C` на обычном пути заполняет
только 13 из этих 14 байт; последний байт получает прежнее содержимое общего
буфера. Разбор адресов и условия ветви — в
[INDIRECT_RAM_HANDOFFS.md](INDIRECT_RAM_HANDOFFS.md).

## Команды состояний актёров

[`QueueActorLinkStateCommands10And11`](../src/link/queueactorlinkstatecommands10and11_01ee24.asm) и [`QueueActorLinkCommand10Variants`](../src/link/queueactorlinkcommand10variants_01ee9e.asm) содержат **несколько отдельных входов** после безусловных `JMP`. Они берут `A0` как актёра, формируют команду в `rSharedScratchBuffer` и хвостом переходят в `QueueLinkCommand`. Внутренние метки `$01EE4E/$01EE78/$01EEC8/$01EEF2/$01EF1C` обозначают реальные входы callback, а не продолжение исполнения предыдущей команды. Их байты `3/8/5/C/9/A/B` становятся `ActorRemoteKind` на другой стороне; это не команды локального рендера.

Приёмники `$0A..$11` берутся из [`LinkCommandHandlers`](../src/link/linkcommandhandlers_0204be.asm). `A0` указывает на текущий пакет; [`FindRemoteActorFromPacket`](../src/link/findremoteactorfrompacket_020662.asm) читает link ID, ставит `A3` на payload, ищет активного актёра с флагом `$20`, возвращает `D7=1/Z=0` при успехе. При отсутствии реплики обработчики ниже ничего в актёр не записывают.

| Команда | Приёмник | Записываемые поля реплики |
| --- | --- | --- |
| `$0A` | [`ReceiveTransientCellRecord`](../src/link/receivetransientcellrecord_0205d6.asm) | Реестр временных клеточных записей; ищет запись по указателю, добавляет, обновляет или удаляет её |
| `$0B` | [`ReceiveRemoteActorPositionMotionAndKind`](../src/link/receiveremoteactorpositionmotionandkind_02069a.asm) | X, Y, MotionX, MotionY, знаковый Z, RemoteKind |
| `$0C` | [`ReceiveRemoteActorPositionMotionFlagsFrame`](../src/link/receiveremoteactorpositionmotionflagsframe_0206be.asm) | X, Y, MotionX, MotionY, Z, Flags с `OR $21`, RemoteFrame, RemoteKind |
| `$0D` | [`ReceiveRemoteActorMotion`](../src/link/receiveremoteactormotion_0206f2.asm) | X, Y, MotionX, MotionY, RemoteKind |
| `$0E` | [`ReceiveRemoteActorPositionAndKind`](../src/link/receiveremoteactorpositionandkind_020710.asm) | X, Y, знаковый Z, RemoteKind |
| `$0F` | [`ReceiveRemoteActorXYAndKind`](../src/link/receiveremoteactorxyandkind_02072e.asm) | X, Y, RemoteKind |
| `$10` | [`ReceiveRemoteActorPositionFrameAndKind`](../src/link/receiveremoteactorpositionframeandkind_020744.asm) | X, Y, знаковый Z, RemoteFrame, RemoteKind |
| `$11` | [`ReceiveRemoteActorXYFrameAndKind`](../src/link/receiveremoteactorxyframeandkind_020766.asm) | X, Y, RemoteFrame, RemoteKind |

Имена отражают **записываемые поля**. Они не обещают, что пакет переключает локальный AI или создаёт эффект смерти: эти действия не видны в перечисленных приёмниках. Для модификации формата команды надо менять обе стороны и `LinkCommandSizes`.

## Отдельные входы таблицы приёма

Ранее несколько обработчиков `LinkCommandHandlers` лежали в общих исходных файлах после `RTS` или `JMP`. Они разделены по настоящим адресам таблицы:

| Команда | Вход | Действие |
| --- | --- | --- |
| `$05` | `ReceiveRemoteActorRemoval` `$0207E6` | Ищет реплику по link ID и удаляет её. |
| `$06` | `ReceiveRemoteHitEventDirect` `$020872` | Ищет локального актёра по ID и вызывает его hit callback; ID 0 адресует игрока. |
| `$07` | `ReceiveRemoteHitEventWithFlag` `$020864` | Временно ставит глобальный флаг `$FF2A42` вокруг обработчика `$06`. |
| `$08` | `ReceiveRemoteSoundEvent` `$0208B6` | Передаёт ID звука в звуковой диспетчер. |
| `$09` | `ReceiveRemoteActorSnapshot` `$0208C0` | Обновляет X/Y/Z, флаги, этаж и remote kind найденной реплики. |
| `$13` | `ReceiveRemoteItemGrant` `$020594` | Выдаёт предмет с переопределением количества, затем звук и сообщение. |
| `$14/$15` | `ReceiveRemotePauseOn/Off` `$020584/$02058C` | Меняет бит 1 флагов паузы. |
| `$16` | `ReceiveRetainedEffectBudgetReset` `$020570` | Сбрасывает флаг экранного эффекта и уменьшает ненулевой бюджет. |
| `$17` | `ReceiveLinkDisconnect` `$020580` | Хвостом переходит в обработчик отключения. |
| `$19` | `CheckSecondaryRoleForLegacyActorCleanup` `$02052A` | Только при роли 2 вызывает сканирование актёров `$020534`; ветвь удаления в нём требует равенства одного callback двум разным адресам и недостижима при обычном указателе. |
| `$1A` | `ReceiveRemoteHitEvent` `$020812` | Разбирает hit-параметры для актёра или игрока при временном глобальном флаге. |

Прямого локального отправителя команды `$19` в разобранном коде не найдено. `SendActorSpawnKind19` **не** отправляет эту команду: он записывает `$19` как `ActorRemoteKind` внутри пакета создания актёра `$04` (White Dummy). Это различие важно при поиске путей вызова и исправлении вероятной ошибки проверки callback.
