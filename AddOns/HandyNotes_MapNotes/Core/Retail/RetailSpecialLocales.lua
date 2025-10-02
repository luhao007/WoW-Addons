local ADDON_NAME, ns = ...
ns.locale = GetLocale()

ns.CHANGE_VERSIONS_CHECK = { -- RetailVersionsCheck.lua
  deDE = "Neue Version |cff00ff00%s|r verfügbar, deine Version |cffffff00%s|r ist veraltet!",
  enUS = "New version |cff00ff00%s|r available, your version |cffffff00%s|r is outdated!",
  frFR = "Nouvelle version |cff00ff00%s|r disponible, votre version |cffffff00%s|r est obsolète!",
  esES = "Nueva versión |cff00ff00%s|r disponible, tu versión |cffffff00%s|r está obsoleta!",
  esMX = "Nueva versión |cff00ff00%s|r disponible, tu versión |cffffff00%s|r está obsoleta!",
  itIT = "Nuova versione |cff00ff00%s|r disponibile, la tua versione |cffffff00%s|r è obsoleta!",
  ptBR = "Nova versão |cff00ff00%s|r disponível, sua versão |cffffff00%s|r está desatualizada!",
  ruRU = "Доступна новая версия |cff00ff00%s|r, ваша версия |cffffff00%s|r устарела!",
  zhCN = "有新版本 |cff00ff00%s|r 可用, 你的版本 |cffffff00%s|r 已过时!",
  zhTW = "有新版本 |cff00ff00%s|r 可用, 你的版本 |cffffff00%s|r 已過時!",
  koKR = "새 버전 |cff00ff00%s|r 사용 가능, 현재 버전 |cffffff00%s|r 은(는) 오래되었습니다!",
}

ns.CHANGE_LOG_CONFIRMED = { -- RetailChangelog.lua
  deDE = "Das Änderungsprotokoll wird bis zu einer neuen Version nicht mehr automatisch angezeigt",
  enUS = "The changelog will no longer be displayed automatically until a new version is released",
  frFR = "Le journal des modifications ne sera plus affiché automatiquement jusqu’à la sortie d’une nouvelle version",
  esES = "El registro de cambios ya no se mostrará automáticamente hasta que se lance una nueva versión",
  esMX = "El registro de cambios ya no se mostrará automáticamente hasta que se lance una nueva versión",
  itIT = "Il registro delle modifiche non verrà più mostrato automaticamente fino al rilascio di una nuova versione",
  ptBR = "O registro de alterações não será mais exibido automaticamente até o lançamento de uma nova versão",
  ruRU = "Журнал изменений больше не будет автоматически отображаться до выхода новой версии",
  zhCN = "在新版本发布之前，更新日志将不再自动显示",
  zhTW = "在新版本發布之前，更新日誌將不再自動顯示",
  koKR = "새 버전이 출시될 때까지 변경 로그는 더 이상 자동으로 표시되지 않습니다",
}

ns.LOCALE_USE_IN_COMBAT_NAME = { -- RetailOptions.lua
  enUS = "Use in combat anyway",
  deDE = "Im Kampf trotzdem verwenden",
  frFR = "Utiliser en combat quand même",
  esES = "Usar en combate de todos modos",
  esMX = "Usar en combate de todos modos",
  itIT = "Usare comunque in combattimento",
  ptBR = "Usar em combate mesmo assim",
  ruRU = "Использовать в бою всё равно",
  koKR = "전투 중에도 강제로 사용",
  zhCN = "战斗中仍然使用",
  zhTW = "戰鬥中仍然使用",
}

ns.LOCALE_USE_IN_COMBAT_1 = { -- RetailOptions.lua
  enUS = "I understand that enabling and continuing to use this feature with MapNotes icons or functions before, during, or after combat to change the world map may cause Blizzard errors",
  deDE = "Ich verstehe, dass die Aktivierung und weitere Nutzung dieser Funktion mit MapNotes-Symbolen oder -Funktionen vor, während oder nach dem Kampf beim Wechseln der Weltkarte zu Blizzard-Fehlern führen kann",
  frFR = "Je comprends qu’activer et continuer à utiliser cette fonction avec les icônes ou fonctions de MapNotes avant, pendant ou après un combat pour changer la carte du monde peut provoquer des erreurs de Blizzard",
  esES = "Entiendo que activar y seguir usando esta función con iconos o funciones de MapNotes antes, durante o después del combate para cambiar el mapa del mundo puede provocar errores de Blizzard",
  esMX = "Entiendo que activar y continuar usando esta función con iconos o funciones de MapNotes antes, durante o después del combate para cambiar el mapa del mundo puede causar errores de Blizzard",
  itIT = "Capisco che abilitare e continuare a usare questa funzione con le icone o funzioni di MapNotes prima, durante o dopo il combattimento per cambiare la mappa del mondo può causare errori di Blizzard",
  ptBR = "Entendo que ativar e continuar usando este recurso com ícones ou funções do MapNotes antes, durante ou após o combate para mudar o mapa do mundo pode causar erros da Blizzard",
  ruRU = "Я понимаю, что включение и дальнейшее использование этой функции с иконками или функциями MapNotes до, во время или после боя для смены карты мира может вызвать ошибки Blizzard",
  koKR = "전투 전후 또는 전투 중에 MapNotes 아이콘이나 기능으로 세계 지도를 변경하면 블리자드 오류가 발생할 수 있음을 이해합니다",
  zhCN = "我明白，在战斗前、战斗中或战斗后使用 MapNotes 图标或功能切换世界地图可能会导致暴雪错误",
  zhTW = "我了解，在戰鬥前、戰鬥中或戰鬥後使用 MapNotes 圖示或功能切換世界地圖可能會導致暴雪錯誤",
}

ns.LOCALE_USE_IN_COMBAT_2 = { -- RetailOptions.lua
  enUS = "Once the “ADDON_ACTION_BLOCKED” error has been triggered, it usually does not occur again during this play session, and you can still use MapNotes to switch the world map in combat. However, in some cases, further errors may occur that require reloading the UI",
  deDE = "Sobald der Fehler „ADDON_ACTION_BLOCKED“ einmal ausgelöst wurde, tritt er normalerweise nicht erneut in dieser Spielsitzung auf, und die Weltkartenumschaltung mit MapNotes kann weiterhin im Kampf genutzt werden. In manchen Fällen können jedoch weitere Fehler auftreten, die ein Neuladen der Benutzeroberfläche erfordern",
  frFR = "Une fois l’erreur « ADDON_ACTION_BLOCKED » déclenchée, elle ne se reproduit généralement pas durant cette session de jeu, et vous pouvez continuer à utiliser MapNotes pour changer la carte du monde en combat. Cependant, dans certains cas, d’autres erreurs peuvent survenir et nécessiter un rechargement de l’interface",
  esES = "Una vez que se ha producido el error «ADDON_ACTION_BLOCKED», normalmente no vuelve a ocurrir durante esta sesión de juego, y aún puedes usar MapNotes para cambiar el mapa del mundo en combate. Sin embargo, en algunos casos, pueden producirse errores adicionales que requieran recargar la interfaz",
  esMX = "Una vez que se ha producido el error «ADDON_ACTION_BLOCKED», por lo general no vuelve a ocurrir durante esta sesión de juego, y todavía puedes usar MapNotes para cambiar el mapa del mundo en combate. Sin embargo, en algunos casos, pueden ocurrir errores adicionales que requieran recargar la interfaz",
  itIT = "Una volta che si è verificato l’errore «ADDON_ACTION_BLOCKED», di solito non si ripete durante questa sessione di gioco e puoi continuare a usare MapNotes per cambiare la mappa del mondo in combattimento. Tuttavia, in alcuni casi, possono verificarsi ulteriori errori che richiedono di ricaricare l’interfaccia",
  ptBR = "Uma vez que o erro «ADDON_ACTION_BLOCKED» foi acionado, normalmente ele não ocorre novamente durante esta sessão de jogo, e você ainda pode usar o MapNotes para mudar o mapa do mundo em combate. No entanto, em alguns casos, podem ocorrer erros adicionais que exigem recarregar a interface",
  ruRU = "После того как ошибка «ADDON_ACTION_BLOCKED» была вызвана один раз, обычно она больше не возникает в текущей игровой сессии, и вы всё ещё можете использовать MapNotes для переключения карты мира в бою. Однако в некоторых случаях могут возникнуть дополнительные ошибки, требующие перезагрузки интерфейса",
  koKR = "일단 «ADDON_ACTION_BLOCKED» 오류가 발생하면 이 게임 세션 동안에는 보통 다시 발생하지 않으며, 전투 중에도 MapNotes로 세계 지도를 전환할 수 있습니다. 다만 경우에 따라 추가 오류가 발생하여 UI를 다시 불러와야 할 수도 있습니다",
  zhCN = "一旦触发了“ADDON_ACTION_BLOCKED”错误，通常在本次游戏会话期间不会再次发生，并且你仍然可以在战斗中使用 MapNotes 切换世界地图。不过，在某些情况下，可能会出现其他错误，需要重新加载界面",
  zhTW = "一旦觸發「ADDON_ACTION_BLOCKED」錯誤，通常在本次遊戲會話期間不會再次發生，並且你仍然可以在戰鬥中使用 MapNotes 切換世界地圖。然而，在某些情況下，可能會出現其他錯誤，需要重新載入介面",
}

ns.LOCALE_SUPPRESS_ERRORS_DESC_1 = { -- RetailOptions.lua
  enUS = "Attempts to suppress and hide all errors that may arise from switching the world map via MapNotes, so that only very rare and specific errors get through, which can only be resolved with a /reload of the user interface",
  deDE = "Versucht, alle Fehler zu unterdrücken und auszublenden, die durch das Wechseln der Weltkarte über MapNotes entstehen können, sodass nur sehr seltene und spezielle Fehler durchkommen, die sich nur mit einem /reload der Benutzeroberfläche beheben lassen",
  frFR = "Essaie de supprimer et de masquer toutes les erreurs susceptibles de survenir lors du changement de la carte du monde via MapNotes, afin que seules des erreurs très rares et spécifiques passent, lesquelles ne peuvent être corrigées qu’avec un /reload de l’interface utilisateur",
  esES = "Intenta suprimir y ocultar todos los errores que puedan surgir al cambiar el mapa del mundo mediante MapNotes, de modo que solo aparezcan errores muy raros y específicos que solo se pueden resolver con un /reload de la interfaz de usuario",
  esMX = "Intenta suprimir y ocultar todos los errores que puedan surgir al cambiar el mapa del mundo mediante MapNotes, de modo que solo aparezcan errores muy raros y específicos que solo se pueden resolver con un /reload de la interfaz de usuario",
  itIT = "Cerca di sopprimere e nascondere tutti gli errori che possono insorgere cambiando la mappa del mondo tramite MapNotes, così che passino solo errori molto rari e specifici, risolvibili soltanto con un /reload dell’interfaccia utente",
  ptBR = "Tenta suprimir e ocultar todos os erros que podem surgir ao trocar o mapa-múndi via MapNotes, de modo que apenas erros muito raros e específicos passem, os quais só podem ser resolvidos com um /reload da interface do usuário",
  ruRU = "Пытается подавить и скрыть все ошибки, которые могут возникнуть при переключении карты мира через MapNotes, так что проходят только очень редкие и специфические ошибки, которые можно исправить лишь с помощью /reload интерфейса пользователя",
  koKR = "MapNotes로 세계 지도를 전환할 때 발생할 수 있는 모든 오류를 억제하고 숨기려고 시도하여, /reload로만 해결 가능한 매우 드물고 특정한 오류만 표시되도록 합니다",
  zhCN = "尝试抑制并隐藏通过 MapNotes 切换世界地图时可能产生的所有错误，使只有极少数特定错误会显示，这些错误只能通过 /reload 用户界面来解决",
  zhTW = "嘗試抑制並隱藏透過 MapNotes 切換世界地圖時可能產生的所有錯誤，僅讓極少數特定錯誤顯示，而這些錯誤只能透過 /reload 使用者介面來解決",
}

ns.LOCALE_SUPPRESS_ERRORS_DESC_2 = { -- RetailOptions.lua
  enUS = "In these cases, MapNotes creates a separate window with the option to quickly reload the user interface so that the error is resolved",
  deDE = "In diesen speziellen Fällen erstellt MapNotes ein Fenster mit der Option, die Benutzeroberfläche neu zu laden, sodass der Fehler bereinigt wird",
  frFR = "Dans ces cas, MapNotes crée une fenêtre distincte avec l’option de recharger rapidement l’interface utilisateur afin que l’erreur soit résolue",
  esES = "En estos casos, MapNotes crea una ventana separada con la opción de recargar rápidamente la interfaz de usuario para que el error quede resuelto",
  esMX = "En estos casos, MapNotes crea una ventana separada con la opción de recargar rápidamente la interfaz de usuario para que el error quede resuelto",
  itIT = "In questi casi, MapNotes crea una finestra separata con l’opzione di ricaricare rapidamente l’interfaccia utente, così che l’errore venga risolto",
  ptBR = "Nesses casos, o MapNotes cria uma janela separada com a opção de recarregar rapidamente a interface do usuário, resolvendo o erro",
  ruRU = "В этих случаях MapNotes создаёт отдельное окно с возможностью быстро перезагрузить интерфейс пользователя, чтобы ошибка была устранена",
  koKR = "이러한 경우, MapNotes는 사용자 인터페이스를 빠르게 다시 불러올 수 있는 별도의 창을 만들어 오류를 해결합니다",
  zhCN = "在这些情况下，MapNotes 会创建一个单独的窗口，提供快速重载用户界面的选项，从而解决错误",
  zhTW = "在這些情況下，MapNotes 會建立一個單獨的視窗，提供快速重新載入使用者介面的選項，從而解決錯誤",
}

ns.LOCALE_SUPPRESS_ERRORS_DESC_3 = { -- RetailOptions.lua
  enUS = "If you don't mind a short /reload in these rare cases, this option can be used",
  deDE = "Wenn dich ein kurzer /reload in diesen seltenen Fällen nicht stört, kann diese Variante verwendet werden",
  frFR = "Si un court /reload dans ces cas rares ne vous dérange pas, vous pouvez utiliser cette option",
  esES = "Si no te molesta hacer un breve /reload en estos casos poco frecuentes, puedes usar esta opción",
  esMX = "Si no te molesta hacer un breve /reload en estos casos poco frecuentes, puedes usar esta opción",
  itIT = "Se non ti disturba fare un breve /reload in questi casi rari, puoi usare questa opzione",
  ptBR = "Se não se importar em fazer um breve /reload nesses casos raros, pode usar esta opção",
  ruRU = "Если вас не беспокоит короткий /reload в этих редких случаях, можно использовать эту опцию",
  koKR = "이러한 드문 경우에 짧은 /reload이 괜찮다면 이 옵션을 사용할 수 있습니다",
  zhCN = "如果你不介意在这些少见情况下执行一次简短的 /reload，就可以使用此选项",
  zhTW = "如果你不介意在這些少見情況下執行一次簡短的 /reload，就可以使用此選項",
}

ns.LOCALE_SUPPRESS_ERRORS_NAME = { -- RetailOptions.lua
  enUS = "Suppress Errors",
  deDE = "Fehler unterdrücken",
  frFR = "Supprimer les erreurs",
  esES = "Suprimir errores",
  esMX = "Suprimir errores",
  itIT = "Sopprimi errori",
  ptBR = "Suprimir erros",
  ruRU = "Подавление ошибок",
  koKR = "오류 억제",
  zhCN = "抑制错误",
  zhTW = "抑制錯誤",
}

ns.LOCALE_COMBAT_LOCKED = { -- RetailErrorMessage.lua
  enUS = "> Map switching is blocked during combat ! <",
  deDE = "> Kartenwechsel im Kampf blockiert ! <",
  frFR = "> Changement de carte bloqué en combat ! <",
  esES = "> Cambio de mapa bloqueado en combate ! <",
  esMX = "> Cambio de mapa bloqueado en combate ! <",
  itIT = "> Cambio mappa bloccato in combattimento ! <",
  ptBR = "> Mudança de mapa bloqueada em combate ! <",
  ruRU = "> Смена карты заблокирована в бою ! <",
  koKR = "> 전투 중 지도 전환이 차단되었습니다 ! <",
  zhCN = "> 战斗中地图切换已被阻止 ! <",
  zhTW = "> 戰鬥中地圖切換已被阻止 ! <",
}

ns.LOCALE_AFTER_COMBAT_ALLOWED = { -- RetailErrorMessage.lua
  enUS = "> Map switching blocked in combat ! <\n> will be executed after combat <",
  deDE = "> Kartenwechsel im Kampf blockiert ! <\n> Dieser wird nach dem Kampf nachgeholt <",
  frFR = "> Changement de carte bloqué en combat ! <\n> il sera effectué après le combat <",
  esES = "> Cambio de mapa bloqueado en combate ! <\n> se realizará después del combate <",
  esMX = "> Cambio de mapa bloqueado en combate ! <\n> se realizará después del combate <",
  itIT = "> Cambio mappa bloccato in combattimento ! <\n> verrà eseguito dopo il combattimento <",
  ptBR = "> Mudança de mapa bloqueada em combate ! <\n> será executada após o combate <",
  ruRU = "> Смена карты заблокирована в бою ! <\n> будет выполнена после боя <",
  koKR = "> 전투 중 지도 전환이 차단됨 ! <\n> 전투 후에 실행됩니다 <",
  zhCN = "> 战斗中地图切换已被阻止 ! <\n> 战斗结束后将执行 <",
  zhTW = "> 戰鬥中地圖切換已被阻止 ! <\n> 戰鬥結束後將執行 <",
}

ns.LOCALE_OPEN_AFTER_COMBAT = { -- RetailErrorMessage.lua
  enUS = "> Map switching executed after combat <",
  deDE = "> Kartenwechsel nachgeholt <",
  frFR = "> Changement de carte effectué après le combat <",
  esES = "> Cambio de mapa realizado después del combate <",
  esMX = "> Cambio de mapa realizado después de la batalla <",
  itIT = "> Cambio mappa eseguito dopo il combattimento <",
  ptBR = "> Mudança de mapa executada após o combate <",
  ruRU = "> Смена карты выполнена после боя <",
  koKR = "> 전투 후 지도 전환이 실행되었습니다 <",
  zhCN = "> 战斗结束后已执行地图切换 <",
  zhTW = "> 戰鬥結束後已執行地圖切換 <",
}

ns.LOCALE_BLOCKPANEL_MSG = { -- RetailErrorMessage.lua
  deDE = [[Bitte einmal die Benutzeroberfläche erneuern, um die Funktion an Blizzard zurückzugeben.]],
  enUS = [[Please reload the UI to return this function to the Blizzard UI.]],
  frFR = [[Veuillez recharger l’interface afin de restituer cette fonction à l’interface de Blizzard.]],
  itIT = [[Ricarica l’interfaccia per restituire questa funzione all’interfaccia di Blizzard.]],
  esES = [[Recarga la interfaz para devolver esta función a la interfaz de Blizzard.]],
  esMX = [[Recarga la interfaz para devolver esta función a la interfaz de Blizzard.]],
  ptBR = [[Recarregue a interface para devolver esta função à interface da Blizzard.]],
  ruRU = [[Пожалуйста, перезагрузите интерфейс, чтобы вернуть эту функцию интерфейсу Blizzard.]],
  koKR = [[이 기능을 블리자드 UI로 되돌리려면 UI를 다시 불러와 주세요.]],
  zhCN = [[请重新加载界面，以将此功能交还给暴雪界面。]],
  zhTW = [[請重新載入介面，以將此功能交還給暴雪介面。]],
}

ns.bugSackTriggers = { -- RetailErrorMessage.lua
  deDE = "bugsack: du hast einen fehler entdeckt",
  enUS = "bugsack: you have found an error",
  enGB = "bugsack: you have found an error",
  frFR = "bugsack: vous avez trouvé une erreur",
  esES = "bugsack: ¡ha ocurrido un error!",
  esMX = "bugsack: ¡ha ocurrido un error!",
  itIT = "bugsack: hai trovato un bug",
  ptBR = "bugsack: você encontrou um erro",
  ruRU = "bugsack: у тебя муха в супе",
  zhCN = "bugsack: 这里有一个恶心的错误",
  zhTW = "bugsack: 在你的湯裡有一隻臭蟲啊！",
  koKR = "bugsack: 수프에 벌레가 있습니다",
}