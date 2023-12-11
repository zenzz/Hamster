//
//  EmojiCategory.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-05-05.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum contains the emoji categories that the native iOS
 emoji keyboard currently has.

 此 enum 包含 iOS 原生表情符号键盘当前所拥有的表情符号类别。

 In native iOS keyboards, emojis flow from top to bottom and
 from leading to trailing. These lists use this flow as well.

 在原生 iOS 键盘中，表情符号从上到下、从前到后依次排列。这些 list 也使用这种流程。

 Since the `frequent` category should list the most frequent
 emojis, you can now register a static `recentEmojiProvider`.
 By default, a `MostRecentEmojiProvider` will be used.

 由于 "frequent(常用)" 类别应列出最常用的表情符号，因此您现在可以注册一个 static 的 "recentEmojiProvider"。
 默认情况下，将使用`MostRecentEmojiProvider`。
 */
public enum EmojiCategory: String, CaseIterable, Codable, EmojiProvider, Identifiable, Hashable {
  case
    frequent,
    smileys,
    animals,
    foods,
    activities,
    travels,
    objects,
    symbols,
    flags

  public static var frequentEmojiProvider: FrequentEmojiProvider = MostRecentEmojiProvider()
}

public extension EmojiCategory {
  /**
   An ordered list of all available categories.

   所有可用类别的有序列表。
   */
  static var all: [EmojiCategory] { allCases }
}

public extension Collection where Element == EmojiCategory {
  /**
   An ordered list of all available categories.

   所有可用类别的有序列表。
   */
  static var all: [EmojiCategory] { EmojiCategory.allCases }
}

public extension EmojiCategory {
  /**
   The category's unique identifier.

   EmojiCategory 的唯一标识符。
   */
  var id: String { rawValue }

  /**
   An ordered list with all emojis in the category.

   包含该类别中所有表情符号的有序列表。
   */
  var emojis: [Emoji] {
    emojisString
      .replacingOccurrences(of: "\n", with: "")
      .compactMap { Emoji(String($0)) }
  }

  /**
   An ordered string with all emojis in the category.

   包含该类别中所有表情符号的有序字符串。
   */
  var emojisString: String {
    switch self {
    case .frequent:
      return Self.frequentEmojiProvider.emojis.map { $0.char }.joined(separator: "")

    case .smileys:
      return """
      😀😃😄😁😆🥹😅😂🤣🥲
      ☺️😊😇🙂🙃😉😌😍🥰😘
      😗😙😚😋😛😝😜🤪🤨🧐
      🤓😎🥸🤩🥳😏😒😞😔😟
      😕🙁☹️😣😖😫😩🥺😢😭
      😤😠😡🤬🤯😳🥵🥶😶‍🌫️😱
      😨😰😥😓🤗🤔🫣🤭🫢🫡
      🤫🫠🤥😶🫥😐🫤😑🫨😬
      🙄😯😦😧😮😲🥱😴🤤😪
      😮‍💨😵😵‍💫🤐🥴🤢🤮🤧😷🤒
      🤕🤑🤠😈👿👹👺🤡💩👻
      💀☠️👽👾🤖🎃😺😸😹😻
      😼😽🙀😿😾🫶🤲👐🙌👏
      🤝👍👎👊✊🤛🤜🫷🫸🤞
      ✌️🫰🤟🤘👌🤌🤏🫳🫴👈
      👉👆👇☝️✋🤚🖐🖖👋🤙
      🫲🫱💪🦾🖕✍️🙏🫵🦶🦵
      🦿💄💋👄🫦🦷👅👂🦻👃
      👣👁👀🫀🫁🧠🗣👤👥🫂
      👶👧🧒👦👩🧑👨👩‍🦱🧑‍🦱👨‍🦱
      👩‍🦰🧑‍🦰👨‍🦰👱‍♀️👱👱‍♂️👩‍🦳🧑‍🦳👨‍🦳👩‍🦲
      🧑‍🦲👨‍🦲🧔‍♀️🧔🧔‍♂️👵🧓👴👲👳‍♀️
      👳👳‍♂️🧕👮‍♀️👮👮‍♂️👷‍♀️👷👷‍♂️💂‍♀️
      💂💂‍♂️🕵️‍♀️🕵️🕵️‍♂️👩‍⚕️🧑‍⚕️👨‍⚕️👩‍🌾🧑‍🌾
      👨‍🌾👩‍🍳🧑‍🍳👨‍🍳👩‍🎓🧑‍🎓👨‍🎓👩‍🎤🧑‍🎤👨‍🎤
      👩‍🏫🧑‍🏫👨‍🏫👩‍🏭🧑‍🏭👨‍🏭👩‍💻🧑‍💻👨‍💻👩‍💼
      🧑‍💼👨‍💼👩‍🔧🧑‍🔧👨‍🔧👩‍🔬🧑‍🔬👨‍🔬👩‍🎨🧑‍🎨
      👨‍🎨👩‍🚒🧑‍🚒👨‍🚒👩‍✈️🧑‍✈️👨‍✈️👩‍🚀🧑‍🚀👨‍🚀
      👩‍⚖️🧑‍⚖️👨‍⚖️👰‍♀️👰👰‍♂️🤵‍♀️🤵🤵‍♂️👸
      🫅🤴🥷🦸‍♀️🦸🦸‍♂️🦹‍♀️🦹🦹‍♂️🤶
      🧑‍🎄🎅🧙‍♀️🧙🧙‍♂️🧝‍♀️🧝🧝‍♂️🧌🧛‍♀️
      🧛🧛‍♂️🧟‍♀️🧟🧟‍♂️🧞‍♀️🧞🧞‍♂️🧜‍♀️🧜
      🧜‍♂️🧚‍♀️🧚🧚‍♂️👼🤰🫄🫃🤱👩‍🍼
      🧑‍🍼👨‍🍼🙇‍♀️🙇🙇‍♂️💁‍♀️💁💁‍♂️🙅‍♀️🙅
      🙅‍♂️🙆‍♀️🙆🙆‍♂️🙋‍♀️🙋🙋‍♂️🧏‍♀️🧏🧏‍♂️
      🤦‍♀️🤦🤦‍♂️🤷‍♀️🤷🤷‍♂️🙎‍♀️🙎🙎‍♂️🙍‍♀️
      🙍🙍‍♂️💇‍♀️💇💇‍♂️💆‍♀️💆💆‍♂️🧖‍♀️🧖
      🧖‍♂️💅🤳💃🕺👯‍♀️👯👯‍♂️🕴👩‍🦽
      🧑‍🦽👨‍🦽👩‍🦼🧑‍🦼👨‍🦼🚶‍♀️🚶🚶‍♂️👩‍🦯🧑‍🦯
      👨‍🦯🧎‍♀️🧎🧎‍♂️🏃‍♀️🏃🏃‍♂️🧍‍♀️🧍🧍‍♂️
      👫👭👬👩‍❤️‍👨👩‍❤️‍👩💑👨‍❤️‍👨👩‍❤️‍💋‍👨👩‍❤️‍💋‍👩💏
      👨‍❤️‍💋‍👨👨‍👩‍👦👨‍👩‍👧👨‍👩‍👧‍👦👨‍👩‍👦‍👦👨‍👩‍👧‍👧👩‍👩‍👦👩‍👩‍👧👩‍👩‍👧‍👦👩‍👩‍👦‍👦
      👩‍👩‍👧‍👧👨‍👨‍👦👨‍👨‍👧👨‍👨‍👧‍👦👨‍👨‍👦‍👦👨‍👨‍👧‍👧👩‍👦👩‍👧👩‍👧‍👦👩‍👦‍👦
      👩‍👧‍👧👨‍👦👨‍👧👨‍👧‍👦👨‍👦‍👦👨‍👧‍👧🪢🧶🧵🪡
      🧥🥼🦺👚👕👖🩲🩳👔👗
      👙🩱👘🥻🩴🥿👠👡👢👞
      👟🥾🧦🧤🧣🎩🧢👒🎓⛑
      🪖👑💍👝👛👜💼🎒🧳👓
      🕶🥽🌂
      """
    case .animals: return """
      🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨
      🐯🦁🐮🐷🐽🐸🐵🙈🙉🙊
      🐒🐔🐧🐦🐤🐣🐥🪿🦆🐦‍⬛
      🦅🦉🦇🐺🐗🐴🦄🫎🐝🪱
      🐛🦋🐌🐞🐜🪰🪲🪳🦟🦗
      🕷🕸🦂🐢🐍🦎🦖🦕🐙🦑
      🪼🦐🦞🦀🐡🐠🐟🐬🐳🐋
      🦈🦭🐊🐅🐆🦓🦍🦧🦣🐘
      🦛🦏🐪🐫🦒🦘🦬🐃🐂🫏
      🐄🐎🐖🐏🐑🦙🐐🦌🐕🐩
      🦮🐕‍🦺🐈🐈‍⬛🪶🪽🐓🦃🦤🦚
      🦜🦢🦩🕊🐇🦝🦨🦡🦫🦦
      🦥🐁🐀🐿🦔🐾🐉🐲🌵🎄
      🌲🌳🌴🪵🌱🌿☘️🍀🎍🪴
      🎋🍃🍂🍁🪺🪹🍄🐚🪸🪨
      🌾💐🌷🌹🥀🪻🪷🌺🌸🌼
      🌻🌞🌝🌛🌜🌚🌕🌖🌗🌘
      🌑🌒🌓🌔🌙🌎🌍🌏🪐💫
      ⭐️🌟✨⚡️☄️💥🔥🌪🌈☀️
      🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️
      ☃️⛄️🌬💨💧💦🫧☔️☂️🌊
      🌫
      """
    case .foods: return """
      🍏🍎🍐🍊🍋🍌🍉🍇🍓🫐
      🍈🍒🍑🥭🍍🥥🥝🍅🍆🥑
      🫛🥦🥬🥒🌶🫑🌽🥕🫒🧄
      🧅🥔🍠🫚🥐🥯🍞🥖🥨🧀
      🥚🍳🧈🥞🧇🥓🥩🍗🍖🦴
      🌭🍔🍟🍕🫓🥪🥙🧆🌮🌯
      🫔🥗🥘🫕🥫🫙🍝🍜🍲🍛
      🍣🍱🥟🦪🍤🍙🍚🍘🍥🥠
      🥮🍢🍡🍧🍨🍦🥧🧁🍰🎂
      🍮🍭🍬🍫🍿🍩🍪🌰🥜🫘
      🍯🥛🫗🍼🫖☕️🍵🧃🥤🧋
      🍶🍺🍻🥂🍷🥃🍸🧉🍹🍾
      🧊🥄🍴🍽🥣🥡🥢🧂
      """
    case .activities: return """
      ⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱
      🪀🏓🏸🏒🏑🥍🏏🪃🥅⛳️
      🪁🛝🏹🎣🤿🥊🥋🎽🛹🛼
      🛷⛸🥌🎿⛷🏂🪂🏋️‍♀️🏋️🏋️‍♂️
      🤼‍♀️🤼🤼‍♂️🤸‍♀️🤸🤸‍♂️⛹️‍♀️⛹️⛹️‍♂️🤺
      🤾‍♀️🤾🤾‍♂️🏌️‍♀️🏌️🏌️‍♂️🏇🧘‍♀️🧘🧘‍♂️
      🏄‍♀️🏄🏄‍♂️🏊‍♀️🏊🏊‍♂️🤽‍♀️🤽🤽‍♂️🚣‍♀️
      🚣🚣‍♂️🧗‍♀️🧗🏻🧗‍♂️🚵‍♀️🚵🚵‍♂️🚴‍♀️🚴
      🚴‍♂️🏆🥇🥈🥉🏅🎖🏵🎗🎫
      🎟🎪🤹‍♀️🤹🤹‍♂️🎭🩰🎨🎬🎤
      🎧🎼🎹🪇🥁🪘🎷🎺🪗🎸
      🪕🎻🪈🎲♟🎯🎳🎮🎰🧩
      """
    case .travels: return """
      🚗🚕🚙🚌🚎🏎🚓🚑🚒🚐
      🛻🚚🚛🚜🦯🦽🦼🩼🛴🚲
      🛵🏍🛺🛞🚨🚔🚍🚘🚖🚡
      🚠🚟🚃🚋🚞🚝🚄🚅🚈🚂
      🚆🚇🚊🚉✈️🛫🛬🛩💺🛰
      🚀🛸🚁🛶⛵️🚤🛥🛳⛴🚢
      🛟⚓️🪝⛽️🚧🚦🚥🚏🗺🗿
      🗽🗼🏰🏯🏟🎡🎢🎠⛲️⛱
      🏖🏝🏜🌋⛰🏔🗻🏕⛺️🛖
      🏠🏡🏘🏚🏗🏭🏢🏬🏣🏤
      🏥🏦🏨🏪🏫🏩💒🏛⛪️🕌
      🕍🛕🕋⛩🛤🛣🗾🎑🏞🌅
      🌄🌠🎇🎆🌇🌆🏙🌃🌌🌉
      🌁
      """
    case .objects: return """
      ⌚️📱📲💻⌨️🖥🖨🖱🖲🕹
      🗜💽💾💿📀📼📷📸📹🎥
      📽🎞📞☎️📟📠📺📻🎙🎚
      🎛🧭⏱⏲⏰🕰⌛️⏳📡🔋
      🪫🔌💡🔦🕯🪔🧯🛢💸💵
      💴💶💷🪙💰💳🪪💎⚖️🪜
      🧰🪛🔧🔨⚒🛠⛏🪚🔩⚙️
      🪤🧱⛓🧲🔫💣🧨🪓🔪🗡
      ⚔️🛡🚬⚰️🪦⚱️🏺🔮📿🧿
      🪬💈⚗️🔭🔬🕳🩻🩹🩺💊
      💉🩸🧬🦠🧫🧪🌡🧹🪠🧺
      🧻🚽🚰🚿🛁🛀🧼🪥🪒🪮
      🧽🪣🧴🛎🔑🗝🚪🪑🛋🛏
      🛌🧸🪆🖼🪞🪟🛍🛒🎁🎈
      🎏🎀🪄🪅🎊🎉🎎🪭🏮🎐
      🪩🧧✉️📩📨📧💌📥📤📦
      🏷🪧📪📫📬📭📮📯📜📃
      📄📑🧾📊📈📉🗒🗓📆📅
      🗑📇🗃🗳🗄📋📁📂🗂🗞
      📰📓📔📒📕📗📘📙📚📖
      🔖🧷🔗📎🖇📐📏🧮📌📍
      ✂️🖊🖋✒️🖌🖍📝✏️🔍🔎
      🔏🔐🔒🔓
      """
    case .symbols: return """
      🩷❤️🧡💛💚🩵💙💜🖤🩶
      🤍🤎💔❤️‍🔥❤️‍🩹❣️💕💞💓💗
      💖💘💝💟☮️✝️☪️🕉☸️🪯
      ✡️🔯🕎☯️☦️🛐⛎♈️♉️♊️
      ♋️♌️♍️♎️♏️♐️♑️♒️♓️🆔
      ⚛️🉑☢️☣️📴📳🈶🈚️🈸🈺
      🈷️✴️🆚💮🉐㊙️㊗️🈴🈵🈹
      🈲🅰️🅱️🆎🆑🅾️🆘❌⭕️🛑
      ⛔️📛🚫💯💢♨️🚷🚯🚳🚱
      🔞📵🚭❗️❕❓❔‼️⁉️🔅
      🔆〽️⚠️🚸🔱⚜️🔰♻️✅🈯️
      💹❇️✳️❎🌐💠Ⓜ️🌀💤🏧
      🚾♿️🅿️🛗🈳🈂️🛂🛃🛄🛅
      🛜🚹🚺🚼⚧🚻🚮🎦📶🈁
      🔣ℹ️🔤🔡🔠🆖🆗🆙🆒🆕
      🆓0️⃣1️⃣2️⃣3️⃣4️⃣5️⃣6️⃣7️⃣8️⃣
      9️⃣🔟🔢#️⃣*️⃣⏏️▶️⏸️⏯️⏹️
      ⏺️⏭️⏮️⏩️⏪️⏫️⏬️◀️🔼🔽
      ➡️⬅️⬆️⬇️↗️↘️↙️↖️↕️↔️
      ↪️↩️⤴️⤵️🔀🔁🔂🔄🔃🎵
      🎶➕➖➗✖️🟰♾️💲💱™️
      ©️®️👁‍🗨🔚🔙🔛🔝🔜〰️➰
      ➿✔️☑️🔘🔴🟠🟡🟢🔵🟣
      ⚫️⚪️🟤🔺🔻🔸🔹🔶🔷🔳
      🔲▪️▫️◾️◽️◼️◻️🟥🟧🟨
      🟩🟦🟪⬛️⬜️🟫🔈🔇🔉🔊
      🔔🔕📣📢💬💭🗯♠️♣️♥️
      ♦️🃏🎴🀄️🕐🕑🕒🕓🕔🕕
      🕖🕗🕘🕙🕚🕛🕜🕝🕞🕟
      🕠🕡🕢🕣🕤🕥🕦🕧
      """
    case .flags: return """
      🏳️🏴🏴‍☠️🏁🚩🏳️‍🌈🏳️‍⚧️🇺🇳🇦🇫🇦🇱
      🇩🇿🇻🇮🇦🇸🇦🇩🇦🇴🇦🇮🇦🇶🇦🇬🇦🇷🇦🇲
      🇦🇼🇦🇺🇦🇿🇧🇸🇧🇭🇧🇩🇧🇧🇧🇪🇧🇿🇧🇯
      🇧🇲🇧🇹🇧🇴🇧🇦🇧🇼🇧🇷🇻🇬🇧🇳🇧🇬🇧🇫
      🇧🇮🇰🇾🇨🇫🇮🇴🇨🇱🇨🇴🇨🇰🇨🇷🇨🇼🇨🇾
      🇨🇮🇩🇰🇩🇯🇩🇲🇩🇴🇪🇨🇪🇬🇬🇶🇸🇻🇪🇷
      🇪🇪🇪🇹🇪🇺🇫🇰🇫🇯🇵🇭🇫🇮🇫🇷🇬🇫🇵🇫
      🇹🇫🇫🇴🇦🇪🇬🇦🇬🇲🇬🇪🇬🇭🇬🇮🇬🇷🇬🇩
      🇬🇱🇬🇵🇬🇺🇬🇹🇬🇬🇬🇳🇬🇼🇬🇾🇭🇹🇭🇳
      🇭🇰🇮🇳🇮🇩🇮🇶🇮🇷🇮🇪🇮🇸🇮🇲🇮🇱🇮🇹
      🇯🇲🇯🇵🎌🇾🇪🇯🇪🇯🇴🇨🇽🇰🇭🇨🇲🇨🇦
      🇮🇨🇨🇻🇧🇶🇰🇿🇰🇪🇨🇳🇰🇬🇰🇮🇨🇨🇰🇲
      🇨🇬🇨🇩🇽🇰🇭🇷🇨🇺🇰🇼🇱🇦🇱🇸🇱🇻🇱🇧
      🇱🇷🇱🇾🇱🇮🇱🇹🇱🇺🇲🇴🇲🇬🇲🇼🇲🇾🇲🇻
      🇲🇱🇲🇹🇲🇦🇲🇭🇲🇶🇲🇷🇲🇺🇾🇹🇲🇽🇫🇲
      🇲🇿🇲🇩🇲🇨🇲🇳🇲🇪🇲🇸🇲🇲🇳🇦🇳🇷🇳🇱
      🇳🇵🇳🇮🇳🇪🇳🇬🇳🇺🇰🇵🇲🇰🇲🇵🇳🇫🇳🇴
      🇳🇨🇳🇿🇴🇲🇵🇰🇵🇼🇵🇸🇵🇦🇵🇬🇵🇾🇵🇪
      🇵🇳🇵🇱🇵🇹🇵🇷🇶🇦🇷🇪🇷🇴🇷🇼🇷🇺🇧🇱
      🇸🇭🇰🇳🇱🇨🇵🇲🇻🇨🇸🇧🇼🇸🇸🇲🇸🇹🇸🇦
      🇨🇭🇸🇳🇷🇸🇸🇨🇸🇱🇸🇬🇸🇽🇸🇰🇸🇮🇸🇴
      🇪🇸🇱🇰🇬🇧🏴󠁧󠁢󠁥󠁮󠁧󠁿🏴󠁧󠁢󠁳󠁣󠁴󠁿🏴󠁧󠁢󠁷󠁬󠁳󠁿🇸🇩🇸🇷🇸🇪🇸🇿
      🇿🇦🇬🇸🇰🇷🇸🇸🇸🇾🇹🇯🇹🇼🇹🇿🇹🇩🇹🇭
      🇨🇿🇹🇬🇹🇰🇹🇴🇹🇹🇹🇳🇹🇷🇹🇲🇹🇨🇹🇻
      🇩🇪🇺🇬🇺🇦🇭🇺🇺🇾🇺🇸🇺🇿🇻🇺🇻🇦🇻🇪
      🇻🇳🇧🇾🇪🇭🇼🇫🇿🇲🇿🇼🇦🇽🇦🇹🇹🇱
      """
    }
  }

  /**
   An ordered list with all emoji actions in the category.

   包含该类别中所有表情符号 KeyboardAction 的有序列表。
   */
  var emojiActions: [KeyboardAction] {
    emojis.map { .emoji($0) }
  }

  /**
   The fallback emoji string that can be used by the emoji
   category if the app doesn't provide a custom image.

   如果应用程序没有提供自定义图像，表情符号类别可以使用的后备表情符号字符串。
   */
  var fallbackDisplayEmoji: Emoji {
    switch self {
    case .frequent: return Emoji("🕓")
    case .smileys: return Emoji("😀")
    case .animals: return Emoji("🐻")
    case .foods: return Emoji("🍔")
    case .activities: return Emoji("⚽️")
    case .travels: return Emoji("🚗")
    case .objects: return Emoji("💡")
    case .symbols: return Emoji("💱")
    case .flags: return Emoji("🏳️")
    }
  }

  /**
   The English title for the category. You can use this if
   your extension only supports English.

   表情符号类别的英文标题。如果您的扩展程序只支持英文，则可以使用该标题。
   */
  var title: String {
    switch self {
    case .frequent: return "Frequently Used"
    case .smileys: return "Smileys & People"
    case .animals: return "Animals & Nature"
    case .foods: return "Food & Drink"
    case .activities: return "Activity"
    case .travels: return "Travel & Places"
    case .objects: return "Objects"
    case .symbols: return "Symbols"
    case .flags: return "Flags"
    }
  }
}
