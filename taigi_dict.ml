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
  | Adverb
  | Adjective
  | Numeral
  | Verb
  | Noun
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
  rule "毋" "" Particle "negation marker";
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
  rule "我" "" Pronoun "first person singular";
  rule "家己" "" Pronoun "reflexive pronoun; myself";
  rule "你" "" Pronoun "second person singular";
  rule "伊" "" Pronoun "third person singular";
  rule "咱" "" Pronoun "first person plural inclusive";
  rule "阮" "" Pronoun "first person plural exclusive";
  rule "恁" "" Pronoun "second person plural";
  rule "𪜶" "" Pronoun "third person plural";
]

let demonstratives = [
  rule "這" "" Demonstrative "proximal; this (near speaker)";
  rule "遮" "" Demonstrative "proximal; here (near speaker)";
  rule "彼" "" Demonstrative "distal; that (near listener/away)";
  rule "遐" "" Demonstrative "distal; there (far away)";
]

let prefixes = [
  rule "第" "tē" Prefix "ordinal";
]

let suffixes = [
  rule "倍" "puē" Suffix "multiplicative";
]

let adverbs = [
  rule "嘛" "" Adverb "also / too";
  rule "亦" "" Adverb "also";
  rule "也" "" Adverb "also";

  rule "猶" "" Adverb "still / yet";
  rule "閣" "" Adverb "again / more";
]

let adjectives = [
  rule "規千萬" "kui-tshing-bān" Adjective "numerous";
]

let verbs = []

let numerals = [
  rule "零" "lân" Numeral "zero";
  rule "半" "puànn" Numeral "half";
  rule "一" "it" Numeral "one";
  rule "二" "jī" Numeral "two";
  rule "三" "sann" Numeral "three";
  rule "四" "sì" Numeral "four";
  rule "五" "gōo" Numeral "five";
  rule "六" "la̍k" Numeral "six";
  rule "七" "tshit" Numeral "seven";
  rule "八" "peh" Numeral "eight";
  rule "九" "káu" Numeral "nine";
  rule "十" "tsa̍p" Numeral "ten";
  rule "百" "pah" Numeral "hundred";
  rule "千" "tshing" Numeral "thousand";
  rule "萬" "bān" Numeral "ten thousand";
  rule "億" "ik" Numeral "hundred million";
  rule "第一" "tē-it" Numeral "first";
  rule "第二" "tē-jī" Numeral "second";
  rule "第三" "tē-sann" Numeral "third";
  rule "第四" "tē-sì" Numeral "fourth";
  rule "第五" "tē-gōo" Numeral "fifth";
  rule "第六" "tē-la̍k" Numeral "sixth";
  rule "第七" "tē-tshit" Numeral "seventh";
  rule "第八" "tē-peh" Numeral "eighth";
  rule "第九" "tē-káu" Numeral "ninth";
  rule "第十" "tē-tsa̍p" Numeral "tenth";
  rule "第十一" "tē-tsa̍p-it" Numeral "eleventh";
  rule "第十二" "tē-tsa̍p-jī" Numeral "twelfth";
  rule "第十三" "tē-tsa̍p-sann" Numeral "thirteenth";
  rule "第十四" "tē-tsa̍p-sì" Numeral "fourteenth";
  rule "第十五" "tē-tsa̍p-gōo" Numeral "fifteenth";
  rule "第十六" "tē-tsa̍p-la̍k" Numeral "sixteenth";
  rule "第十七" "tē-tsa̍p-tshit" Numeral "seventeenth";
  rule "第十八" "tē-tsa̍p-peh" Numeral "eighteenth";
  rule "第十九" "tē-tsa̍p-káu" Numeral "nineteenth";
  rule "第二十" "tē-jī-tsa̍p" Numeral "twentieth";
  rule "一倍" "it-pōe" Numeral "single";
  rule "二倍" "jī-pōe" Numeral "double";
  rule "三倍" "sann-pōe" Numeral "triple";
  rule "四倍" "sì-pōe" Numeral "fourfold";
  rule "五倍" "gōo-pōe" Numeral "fivefold";
  rule "六倍" "la̍k-pōe" Numeral "sixfold";
  rule "七倍" "tshit-pōe" Numeral "sevenfold";
  rule "八倍" "peh-pōe" Numeral "eightfold";
  rule "九倍" "káu-pōe" Numeral "ninefold";
  rule "十倍" "tsa̍p-pōe" Numeral "tenfold";
  rule "十一倍" "tsa̍p-it-pōe" Numeral "elevenfold";
  rule "十二倍" "tsa̍p-jī-pōe" Numeral "twelvefold";
  rule "十三倍" "tsa̍p-sann-pōe" Numeral "thirteenfold";
  rule "十四倍" "tsa̍p-sì-pōe" Numeral "fourteenfold";
  rule "十五倍" "tsa̍p-gōo-pōe" Numeral "fifteenfold";
  rule "十六倍" "tsa̍p-la̍k-pōe" Numeral "sixteenfold";
  rule "十七倍" "tsa̍p-tshit-pōe" Numeral "seventeenfold";
  rule "十八倍" "tsa̍p-peh-pōe" Numeral "eighteenfold";
  rule "十九倍" "tsa̍p-káu-pōe" Numeral "nineteenfold";
  rule "二十倍" "jī-tsa̍p-pōe" Numeral "twentyfold";
]

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
  adverbs;
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
  | Adverb -> "Adverb"
  | Adjective -> "Adjective"
  | Verb -> "Verb"
  | Numeral -> "Numeral"
  | Noun -> "Noun"
  | Text -> "Text"
  | End -> "End"

let print_token (Token(Hanzi(z), Tailo(t), pos, Trans(ts))) =
  Printf.sprintf "(%s, %s, %s, \"%s\")" z t (string_of_pos pos) ts
