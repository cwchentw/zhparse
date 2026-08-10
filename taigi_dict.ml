type pos =
  | Punctuation
  | Particle
  | Conjugation
  | Preposition
  | Exclamation
  | Pronoun
  | Demonstrative
  | Prefix
  | Suffix
  | Phrase
  | Adverb
  | ApproximationAdverb
  | Adjective
  | Numeral
  | Verb
  | Noun
  | Foreign
  | Text
  | End

type hanzi = Hanzi of string
type tailo = Tailo of string
type trans = Trans of string

type rule = Rule of hanzi * tailo * pos * trans
type token = Token of hanzi * tailo * pos * trans

let rule hanzi tailo pos trans = Rule(Hanzi(hanzi), Tailo(tailo), pos, Trans(trans))
let token hanzi tailo pos trans = Token(Hanzi(hanzi), Tailo(tailo), pos, Trans(trans))

let punctuations = [
  rule "。" "。" Punctuation "sentence terminator";
  rule "？" "？" Punctuation "question terminator";
  rule "！" "！" Punctuation "exclamation terminator";
  rule "，" "，" Punctuation "comma / pause";
  rule "；" "；" Punctuation "semicolon / connector";
  rule "：" "：" Punctuation "colon / introducer";
  rule "…" "…" Punctuation "ellipsis / omission";
  rule "—" "—" Punctuation "dash / interruption";
  rule "「" "「" Punctuation "opening quotation mark";
  rule "」" "」" Punctuation "closing quotation mark";
  rule "『" "『" Punctuation "opening nested quotation mark";
  rule "』" "』" Punctuation "closing nested quotation mark";
  rule "（" "（" Punctuation "opening parenthesis";
  rule "）" "）" Punctuation "closing parenthesis";
]

let particles = [
  rule "矣" "" Particle "perfective aspect marker";
  rule "袂" "" Particle "inability marker";
  rule "敢" "" Particle "dubitative marker";
  rule "嘛" "" Particle "additive marker";
  rule "咱" "" Particle "inclusive pronoun marker";
  rule "啦" "" Particle "sentence-final emphatic marker";
  rule "喔" "" Particle "sentence-final reminder marker";
  rule "吔" "" Particle "sentence-final softener";
]

let conjugations = [
  rule "佮" "" Conjugation "and";
  rule "含" "" Conjugation "and";
  rule "和" "" Conjugation "and";
  rule "以及" "" Conjugation "and alo";
  rule "抑" "" Conjugation "or";
  rule "以及" "" Conjugation "and alo";

  rule "而且" "" Conjugation "moreover";
  rule "何況" "" Conjugation "not to mention";
  rule "因為" "" Conjugation "because";

  rule "毋過" "m̄-koh" Conjugation "but / however";
  rule "毋但" "m̄-nā" Conjugation "not only";
  rule "毋管" "m̄-kuán" Conjugation "no matter / regardless";
  rule "毋才" "m̄-tsiah" Conjugation "only then / that is why";
]

let prepositions = [
  rule "予" "" Preposition "let / by / to";
]

let exclamations = [
  rule "唉" "" Exclamation "sigh / lament";
  rule "啊" "" Exclamation "surprise / realization";
  rule "嘿" "" Exclamation "call / attention";
  rule "哎呀" "" Exclamation "shock / sudden pain";
  rule "哇" "" Exclamation "wonder / admiration";
  rule "喂" "" Exclamation "greeting / call";
  rule "哼" "" Exclamation "displeasure / disdain";
  rule "噢" "" Exclamation "realization / reminder";
  rule "咦" "" Exclamation "doubt / puzzlement";
  rule "哇哇" "" Exclamation "crying / wailing";
]

let pronouns = [
  rule "我" "guá" Pronoun "first person singular";
  rule "你" "lí" Pronoun "second person singular";
  rule "伊" "i" Pronoun "third person singular";
  rule "阮" "guán" Pronoun "first person plural exclusive";
  rule "咱" "lán" Pronoun "first person plural inclusive";
  rule "恁" "lín" Pronoun "second person plural";
  rule "𪜶" "in" Pronoun "third person plural";
  rule "怹" "in" Pronoun "third person plural";
  rule "家己" "ka-kī" Pronoun "reflexive pronoun";
  rule "我的" "guá ê" Pronoun "my / mine";
  rule "你的" "lí ê" Pronoun "your / yours";
  rule "伊的" "i ê" Pronoun "his / her / its";
  rule "咱的" "lán ê" Pronoun "our (inclusive)";
  rule "阮的" "gún ê" Pronoun "our (exclusive)";
  rule "恁的" "lín ê" Pronoun "your (plural)";
  rule "𪜶的" "in ê" Pronoun "their / theirs";
  rule "怹的" "in ê" Pronoun "their / theirs";
]

let demonstratives = [
  rule "這" "tse" Demonstrative "proximal singular; this (near speaker)";
  rule "彼" "he" Demonstrative "distal singular; that (near listener/away)";
  rule "遮" "tsia" Demonstrative "proximal plural or place; these/this place";
  rule "遐" "hia" Demonstrative "distal plural or place; those/that place";
]

let prefixes = [
  rule "第" "tē" Prefix "ordinal";
]

let suffixes = [
  rule "倍" "puē" Suffix "multiplicative";
]

let phrases = [
  rule "毋甘願" "m̄ kam-guān" Phrase "reluctant";
  rule "毋甘嫌" "m̄-kam hiâm" Phrase "you flatter me";
  rule "毋是勢" "m̄-sī-sè" Phrase "something is wrong";
  rule "毋知死" "m̄-tsai-sí" Phrase "clueless about the danger";
]

let adverbs = [
  rule "攏" "lóng" Adverb "all";
  rule "嘛" "mā" Adverb "also / too";
  rule "亦" "" Adverb "also";
  rule "也" "" Adverb "also";

  rule "猶" "" Adverb "still / yet";
  rule "閣" "" Adverb "again / more";

  rule "毋" "m̄" Adverb "not";
  rule "猶毋過" "iáu-m̄-koh" Adverb "however / yet / but";
  rule "毋捌" "m̄ bat" Adverb "never / have not before";
  rule "毋免" "m̄-bián" Adverb "need not / do not need to / no need";
  rule "毋好" "m̄ hó" Adverb "do not";
  rule "毋好勢" "m̄ hó-sè" Adverb "inconvenient / inopportune";
  rule "毋敢" "m̄ kánn" Adverb "dare not / not dare";
  rule "毋通" "m̄-thang" Adverb "do not / should not";
]

let approximation_adverbs = [
  rule "差不多" "tsha-put-to" Adverb "nearly / almost";
  rule "左右" "tsó-iū" Adverb "about / around";
  rule "成" "tsiânn" Adverb "almost";
  rule "外" "guā" Adverb "more than";
  rule "以下" "í-hā" Adverb "less than";
  rule "無到" "bô kàu" Adverb "less than";
  rule "幾" "kuí" Adverb "several / few";
]

let adjectives = [
  rule "規千萬" "kui-tshing-bān" Adjective "numerous";
  rule "毋甘" "m̄-kam" Adjective "reluctant";
  rule "毋是款" "m̄-sī-khuán" Adjective "not the proper way";
  rule "毋著" "m̄-tio̍h" Adjective "wrong / incorrect / mistaken";
  rule "毋知人" "m̄-tsai-lâng" Adjective "unconscious / comatose / blacked out";
]

let verbs = [
  rule "加" "ka" Verb "add";
  rule "減" "kiám" Verb "subtract";
  rule "乘以" "sêng-í" Verb "multiply";
  rule "除" "tû" Verb "divided into";
  rule "除以" "tû-í" Verb "divided by";
  rule "等於" "tíng-î" Verb "equals";
  rule "賰" "tshun" Verb "leaves";
  rule "毋願" "m̄-guān" Verb "do not want to";
  rule "毋挃" "m̄ ti̍h" Verb "do not want";
  rule "毋驚" "m̄ kiann" Verb "not afraid";
  rule "毋是" "m̄ sī" Verb "is not";
  rule "毋值" "m̄-ta̍t" Verb "not worth it";
  rule "毋知" "m̄ tsai" Verb "do not know";
  rule "毋知影" "m̄ tsai-iánn" Verb "do not know";
]

let numerals = []

let nouns = [
  rule "阿公" "a-kong" Noun "grandfather; father's father";
  rule "阿媽" "a-má" Noun "grandmother; father's mother";
  rule "阿爸" "a-pah" Noun "father";
  rule "阿母" "a-bú" Noun "mother";
  rule "阿伯" "a-peh" Noun "uncle; father's elder brother";
  rule "阿叔" "a-tsik" Noun "uncle; father's younger brother";
  rule "阿姑" "a-koo" Noun "aunt; father's sister";
  rule "阿姆" "a-ḿ" Noun "aunt; paternal elder uncle's wife";
  rule "阿嬸" "a-tsím" Noun "aunt; paternal younger uncle's wife";
  rule "阿舅" "a-kū" Noun "uncle; mother's brother";
  rule "阿姨" "a-î" Noun "aunt; mother's sister";
  rule "阿妗" "a-kīm" Noun "aunt; maternal uncle's wife";
  rule "阿姊" "a-tsí" Noun "elder sister (relative to speaker)";
  rule "阿兄" "a-hiann" Noun "elder brother (relative to speaker)";
  rule "阿嫂" "a-só" Noun "elder brother's wife";
  rule "翁" "ang" Noun "husband";
  rule "某" "bóo" Noun "wife";
  rule "拍折" "phah-tsiat" Noun "discount";
  rule "答案" "tap-àn" Noun "answer";
  rule "暗報" "àm-pò" Noun "evening newspaper";
  rule "目鏡" "ba̍k-kiànn" Noun "eyeglasses";
  rule "目鏡仁" "ba̍k-kiànn-jîn" Noun "eyeglass lens";
  rule "墨汁" "ba̍k-tsiap" Noun "ink";
  rule "萬年筆" "bān-liân-pit" Noun "pen";
  rule "蠓仔香" "báng-á-hiunn" Noun "mosquito coils";
  rule "蠓仔薰" "báng-á-hun" Noun "mosquito coils";
  rule "蠓仔水" "báng-á-tsuí" Noun "pesticides";
  rule "蠓捽仔" "báng-sut-á" Noun "fly swatter";
  rule "蠓罩" "báng-tà" Noun "mosquito net";
  rule "米甕" "bí-àng" Noun "rice jar";
  rule "米管" "bí-kńg" Noun "rice cup";
  rule "抿仔" "bín-á" Noun "brush";
  rule "眠床" "bîn-tshn̂g" Noun "bed";
  rule "眠床枋" "bîn-tshn̂g-pang" Noun "bed board";
  rule "面巾" "bīn-kin" Noun "towel";
  rule "面布" "bīn-pòo" Noun "towel";
  rule "面盆" "bīn-phûn" Noun "washbowl";
  rule "面桶" "bīn-tháng" Noun "washbowl";
  rule "名產" "bîng-sán" Noun "local specialty";
  rule "母囝椅" "bú-kiánn-í" Noun "feeding chair";
  rule "鞋拔仔" "ê-pue̍h-á" Noun "shoehorn";
  rule "鈃仔" "giang-á" Noun "bell";
  rule "紅菜頭" "âng-tshài-thâu" Noun "beet";
  rule "紅菜" "âng-tshài" Noun "Okinawa spinach";
  rule "木瓜" "bo̍k-kue" Noun "papaya";
  rule "番麥" "huan-be̍h" Noun "corn";
  rule "米芳" "bí-phang" Noun "puffed rice cake";
  rule "磅米芳" "pōng-bí-phang" Noun "puffed rice cake";
]

let rules = List.concat [
  punctuations;
  particles;
  conjugations;
  prepositions;
  exclamations;
  pronouns;
  demonstratives;
  prefixes;
  suffixes;
  phrases;
  adverbs;
  approximation_adverbs;
  adjectives;
  verbs;
  numerals;
  nouns;
]

let string_of_pos = function
  | Punctuation -> "Punctuation"
  | Particle -> "Particle"
  | Conjugation -> "Conjugation"
  | Preposition -> "Preposition"
  | Exclamation -> "Exclamation"
  | Pronoun -> "Pronoun"
  | Demonstrative -> "Demonstrative"
  | Prefix -> "Prefix"
  | Suffix -> "Suffix"
  | Phrase -> "Phrase"
  | Adverb -> "Adverb"
  | ApproximationAdverb -> "Approximation Adverb"
  | Adjective -> "Adjective"
  | Verb -> "Verb"
  | Numeral -> "Numeral"
  | Noun -> "Noun"
  | Foreign -> "Foreign"
  | Text -> "Text"
  | End -> "End"

let print_token (Token(Hanzi(z), Tailo(t), pos, Trans(ts))) =
  Printf.sprintf "(%s, %s, %s, %s)" z t (string_of_pos pos) ts
