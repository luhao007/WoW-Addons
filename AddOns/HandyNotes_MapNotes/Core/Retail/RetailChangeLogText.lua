local ADDON_NAME, ns = ...

ns.CurrentAddonVersion = "3.6.1"
ns.PreviousAddonVersion = "3.6.0" -- Only increase this number if you want to see changelogs and NPC updates after an add-on update. Only important for actual changes to NPCs or major updates

ns.LOCALE_CHANGELOGS = {
  { version = "3.6.1", table = { "smallChanges", "tocUpdate"} },
  { version = "3.6.0", table = "prepatchUpdate" },
  { version = "3.5.9", table = "prepatchUpdate" },
  { version = "3.5.8", table = ns.LOCALE_CHANGELOG_3_5_6 },
  { version = "3.5.7", table = "smallChanges" },
  { version = "3.5.6", table = ns.LOCALE_CHANGELOG_3_5_6 },
  { version = "3.5.5", table = { "smallChanges", "tocUpdate"} },
  { version = "3.5.4", table = "smallChanges" },
  { version = "3.5.3", table = "smallChanges" },
  { version = "3.5.2", table = "tocUpdate" },
  { version = "3.5.1", table = ns.LOCALE_CHANGELOG_3_5_0 },
}

ns.LOCALE_CHANGELOG_3_5_ = { -- empty backup file
  deDE = [[

]],

  enUS = [[

]],

  frFR = [[

]],

  itIT = [[

]],

  esES = [[

]],

  esMX = [[

]],

  ptBR = [[

]],

  ruRU = [[

]],

  zhCN = [[

]],

  zhTW = [[

]],

  koKR = [[

]],
}

ns.LOCALE_CHANGELOG_3_5_8 = {
  deDE = [[
• Es wurde im Allgemeinen Menü-Reiter ein neuer Unterpunkt mit dem Namen „Tooltip“ hinzugefügt.

• Dort lässt sich die Darstellung der MapNotes-Tooltip-Texte anpassen.

• Es ist nun möglich, die Schriftart, die Textumrandung, den Tooltip-Hintergrund sowie den Rahmen des Tooltip-Fensters zu ändern.

• Diese Funktionen befinden sich derzeit noch in der Testphase. Falls ihr Fehler findet oder Feedback habt, meldet euch gerne über die Webseite.
]],

  enUS = [[
• A new "Tooltip" submenu has been added to the General menu tab.

• It allows you to customize the appearance of MapNotes tooltip text.

• You can now change the font, text outline, tooltip background, and tooltip border.

• These features are still in the testing phase. If you find any issues or have feedback, please let us know via the website.
]],

  frFR = [[
• Un nouveau sous-menu « Tooltip » a été ajouté dans l'onglet des paramètres généraux.

• Il permet de personnaliser l'apparence des textes des infobulles de MapNotes.

• Vous pouvez désormais modifier la police, le contour du texte, l'arrière-plan de l'infobulle ainsi que sa bordure.

• Ces fonctionnalités sont encore en phase de test. Si vous trouvez des erreurs ou avez des retours, n'hésitez pas à les signaler via le site web.
]],

  itIT = [[
• È stato aggiunto un nuovo sottomenu "Tooltip" nella scheda delle impostazioni generali.

• Consente di personalizzare l'aspetto del testo dei suggerimenti di MapNotes.

• Ora è possibile modificare il carattere, il contorno del testo, lo sfondo del suggerimento e il bordo della finestra del suggerimento.

• Queste funzionalità sono ancora in fase di test. Se riscontri problemi o hai suggerimenti, faccelo sapere tramite il sito web.
]],

  esES = [[
• Se ha añadido un nuevo submenú "Tooltip" en la pestaña de configuración general.

• Permite personalizar la apariencia del texto de las descripciones emergentes de MapNotes.

• Ahora puedes cambiar la fuente, el contorno del texto, el fondo de la descripción emergente y el borde de la ventana.

• Estas funciones aún están en fase de pruebas. Si encuentras errores o tienes sugerencias, háznoslo saber a través del sitio web.
]],

  esMX = [[
• Se agregó un nuevo submenú "Tooltip" en la pestaña de configuración general.

• Permite personalizar la apariencia del texto de las ventanas emergentes de MapNotes.

• Ahora puedes cambiar la fuente, el contorno del texto, el fondo de la ventana emergente y el borde de la ventana.

• Estas funciones aún están en fase de pruebas. Si encuentras errores o tienes comentarios, háznoslo saber a través del sitio web.
]],

  ptBR = [[
• Um novo submenu "Tooltip" foi adicionado à guia de configurações gerais.

• Ele permite personalizar a aparência dos textos das dicas de ferramenta do MapNotes.

• Agora é possível alterar a fonte, o contorno do texto, o fundo da dica de ferramenta e a borda da janela.

• Esses recursos ainda estão em fase de testes. Caso encontre problemas ou tenha sugestões, informe-nos pelo site.
]],

  ruRU = [[
• Во вкладку общих настроек был добавлен новый подраздел «Подсказка».

• В нём можно настроить внешний вид текста всплывающих подсказок MapNotes.

• Теперь можно изменить шрифт, контур текста, фон всплывающей подсказки и рамку окна подсказки.

• Эти функции всё ещё находятся на стадии тестирования. Если вы обнаружите ошибки или у вас есть отзывы, пожалуйста, сообщите нам через сайт.
]],

  zhCN = [[
• 在“常规”设置标签中新增了“鼠标提示”子菜单。

• 您现在可以自定义 MapNotes 鼠标提示文本的显示效果。

• 现在可以修改字体、文字描边、鼠标提示背景以及鼠标提示边框。

• 这些功能目前仍处于测试阶段。如果您发现问题或有任何反馈，欢迎通过网站告诉我们。
]],

  zhTW = [[
• 在「一般」設定分頁中新增了「滑鼠提示」子選單。

• 您現在可以自訂 MapNotes 滑鼠提示文字的顯示方式。

• 現在可以修改字型、文字外框、滑鼠提示背景以及滑鼠提示邊框。

• 這些功能目前仍處於測試階段。如果您發現任何問題或有任何建議，歡迎透過網站與我們聯繫。
]],

  koKR = [[
• 일반 설정 탭에 새로운 "툴팁" 하위 메뉴가 추가되었습니다.

• 이제 MapNotes 툴팁 텍스트의 표시 방식을 사용자 지정할 수 있습니다.

• 글꼴, 텍스트 외곽선, 툴팁 배경 및 툴팁 테두리를 변경할 수 있습니다.

• 이 기능은 아직 테스트 단계에 있습니다. 문제가 발생하거나 의견이 있으시면 웹사이트를 통해 알려 주세요.
]],
}

ns.LOCALE_CHANGELOG_3_5_6 = {
  deDE = [[
• Auf der Flugkarte wurden fehlende Instanzen hinzugefügt

• Für einige Portalsymbole wurden Bedienungshinweise hinzugefügt, die anzeigen, wie diese Portale freigeschaltet werden können
]],

  enUS = [[
• Added missing instances to the Flight Map

• Added instructions to some portal icons showing how to unlock these portals
]],

  frFR = [[
• Ajout des instances manquantes sur la carte des trajets aériens

• Ajout d'instructions à certaines icônes de portail indiquant comment débloquer ces portails
]],

  itIT = [[
• Aggiunte le istanze mancanti alla mappa dei voli

• Aggiunte istruzioni ad alcune icone dei portali che mostrano come sbloccare questi portali
]],

  esES = [[
• Se añadieron las instancias que faltaban al mapa de vuelo

• Se añadieron instrucciones a algunos iconos de portales que muestran cómo desbloquear estos portales
]],

  esMX = [[
• Se agregaron las instancias faltantes al mapa de vuelo

• Se agregaron instrucciones a algunos íconos de portales que muestran cómo desbloquear estos portales
]],

  ptBR = [[
• Instâncias ausentes adicionadas ao mapa de voo

• Foram adicionadas instruções a alguns ícones de portais mostrando como desbloquear esses portais
]],

  ruRU = [[
• На карту полётов добавлены отсутствующие подземелья

• Для некоторых значков порталов добавлены подсказки, показывающие, как разблокировать эти порталы
]],

  zhCN = [[
• 飞行地图中补充了缺失的副本

• 为部分传送门图标添加了说明，显示如何解锁这些传送门
]],

  zhTW = [[
• 飛行地圖新增了遺漏的副本

• 為部分傳送門圖示新增了說明，顯示如何解鎖這些傳送門
]],

  koKR = [[
• 비행 지도에 누락된 인스턴스가 추가되었습니다

• 일부 차원문 아이콘에 해당 차원문을 해제하는 방법을 알려주는 안내가 추가되었습니다
]],
}

ns.LOCALE_CHANGELOG_3_5_1 = {
  deDE = [[
• HandyNotes: MapNotes funktioniert nun auch für Erweiterung von „Jubiläum - The Burning Crusade“
]],

  enUS = [[
• HandyNotes: MapNotes now also works for the “Anniversary - The Burning Crusade” expansion
]],

  frFR = [[
• HandyNotes : MapNotes fonctionne désormais aussi pour l’extension « Anniversaire - The Burning Crusade »
]],

  itIT = [[
• HandyNotes: MapNotes ora funziona anche per l’espansione “Anniversario - The Burning Crusade”
]],

  esES = [[
• HandyNotes: MapNotes ahora también funciona para la expansión « Aniversario - The Burning Crusade »
]],

  esMX = [[
• HandyNotes: MapNotes ahora también funciona para la expansión « Aniversario - The Burning Crusade »
]],

  ptBR = [[
• HandyNotes: MapNotes agora também funciona para a expansão “Aniversário - The Burning Crusade”
]],

  ruRU = [[
• HandyNotes: MapNotes теперь также работает для дополнения « Юбилей — The Burning Crusade »
]],

  zhCN = [[
• HandyNotes：MapNotes 现在也支持“周年纪念 - 燃烧的远征”扩展内容
]],

  zhTW = [[
• HandyNotes：MapNotes 現在也支援「週年紀念 - 燃燒的遠征」資料片
]],

  koKR = [[
• HandyNotes: MapNotes가 이제 “기념일 - 불타는 성전” 확장팩에서도 작동합니다
]],
}

ns.partialUpdate = {
  deDE = [[
• Kleinere Anpassungen
]],

  enUS = [[
• Minor adjustments
]],

  frFR = [[
• Ajustements mineurs
]],

  itIT = [[
• Modifiche minori
]],

  esES = [[
• Ajustes menores
]],

  esMX = [[
• Ajustes menores
]],

  ptBR = [[
• Pequenos ajustes
]],

  ruRU = [[
• Незначительные изменения
]],

  zhCN = [[
• 小幅调整
]],

  zhTW = [[
• 小幅調整
]],

  koKR = [[
• 소규모 조정
]],
}

ns.prepatchUpdate = {
  deDE = [[
• Vorbereitung für zukünftiges Update
]],

  enUS = [[
• Preparation for a future update
]],

  frFR = [[
• Préparation pour une mise à jour future
]],

  itIT = [[
• Preparazione per un aggiornamento futuro
]],

  esES = [[
• Preparación para una actualización futura
]],

  esMX = [[
• Preparación para una actualización futura
]],

  ptBR = [[
• Preparação para uma atualização futura
]],

  ruRU = [[
• Подготовка к будущему обновлению
]],

  zhCN = [[
• 为未来更新做准备
]],

  zhTW = [[
• 為未來更新做準備
]],

  koKR = [[
• 향후 업데이트 준비
]],
}

ns.classicUpdate = {
  deDE = [[
• Update Classic
]],

  enUS = [[
• Classic update
]],

  frFR = [[
• Mise à jour Classic
]],

  itIT = [[
• Aggiornamento Classic
]],

  esES = [[
• Actualización de Classic
]],

  esMX = [[
• Actualización de Classic
]],

  ptBR = [[
• Atualização do Classic
]],

  ruRU = [[
• Обновление Classic
]],

  zhCN = [[
• Classic 更新
]],

  zhTW = [[
• Classic 更新
]],

  koKR = [[
• Classic 업데이트
]],
}

ns.smallChanges = {
  deDE = [[
• kleinere Anpassungen
]],

  enUS = [[
• minor adjustments
]],

  frFR = [[
• ajustements mineurs
]],

  itIT = [[
• piccoli aggiustamenti
]],

  esES = [[
• ajustes menores
]],

  esMX = [[
• ajustes menores
]],

  ptBR = [[
• pequenos ajustes
]],

  ruRU = [[
• небольшие изменения
]],

  zhCN = [[
• 小幅调整
]],

  zhTW = [[
• 小幅調整
]],

  koKR = [[
• 소소한 조정
]],
}

ns.tocUpdate = {
  deDE = [[
• toc update
]],

  enUS = [[
• TOC update
]],

  frFR = [[
• Mise à jour du TOC
]],

  itIT = [[
• Aggiornamento del TOC
]],

  esES = [[
• Actualización del TOC
]],

  esMX = [[
• Actualización del TOC
]],

  ptBR = [[
• Atualização do TOC
]],

  ruRU = [[
• Обновление TOC
]],

  zhCN = [[
• TOC 更新
]],

  zhTW = [[
• TOC 更新
]],

  koKR = [[
• TOC 업데이트
]],
}