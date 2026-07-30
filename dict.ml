type pos =
  | Punctuation
  | Particle
  | Conjugation
  | Preposition
  | Exclamation
  | Pronoun
  | Demonstrative
  | Adverb
  | Noun
  | Ambiguity
  | Text
  | End

type pattern = Pattern of string
type trans = Trans of string

type rule = Rule of pattern * pos * trans
type token = Token of pattern * pos * trans

let rule pattern pos trans = Rule(Pattern(pattern), pos, Trans(trans))
let token pattern pos trans = Token(Pattern(pattern), pos, Trans(trans))

let punctuations = [
  rule "。" Punctuation "sentence terminator";
  rule "？" Punctuation "question terminator";
  rule "！" Punctuation "exclamation terminator";
  rule "，" Punctuation "comma / pause";
  rule "；" Punctuation "semicolon / connector";
  rule "：" Punctuation "colon / introducer";
  rule "…" Punctuation "ellipsis / omission";
  rule "—" Punctuation "dash / interruption";
  rule "「" Punctuation "opening quotation mark";
  rule "」" Punctuation "closing quotation mark";
  rule "『" Punctuation "opening nested quotation mark";
  rule "』" Punctuation "closing nested quotation mark";
  rule "（" Punctuation "opening parenthesis";
  rule "）" Punctuation "closing parenthesis";
]

let ambiguous_meaning = "Ambiguous meaning"

let ambiguities = [
  rule "會" Ambiguity ambiguous_meaning;
  rule "咧" Ambiguity ambiguous_meaning;
  rule "共" Ambiguity ambiguous_meaning;
  rule "甲" Ambiguity ambiguous_meaning;
  rule "由" Ambiguity ambiguous_meaning;
  rule "按" Ambiguity ambiguous_meaning;
  rule "以" Ambiguity ambiguous_meaning;
  rule "用" Ambiguity ambiguous_meaning;
]

let particles = [
  rule "矣" Particle "perfective aspect marker";
  rule "毋" Particle "negation marker";
  rule "袂" Particle "inability marker";
  rule "敢" Particle "dubitative marker";
  rule "嘛" Particle "additive marker";
  rule "咱" Particle "inclusive pronoun marker";
  rule "啦" Particle "sentence-final emphatic marker";
  rule "喔" Particle "sentence-final reminder marker";
  rule "吔" Particle "sentence-final softener";
]

let conjugations = [
  rule "佮" Conjugation "and";
  rule "含" Conjugation "and";
  rule "和" Conjugation "and";
  rule "以及" Conjugation "and alo";
  rule "抑" Conjugation "or";
  rule "以及" Conjugation "and alo";

  rule "而且" Conjugation "moreover";
  rule "何況" Conjugation "not to mention";
  rule "因為" Conjugation "because";
]

let prepositions = [
  rule "予" Preposition "let / by / to";
]

let exclamations = [
  rule "唉" Exclamation "sigh / lament";
  rule "啊" Exclamation "surprise / realization";
  rule "嘿" Exclamation "call / attention";
  rule "哎呀" Exclamation "shock / sudden pain";
  rule "哇" Exclamation "wonder / admiration";
  rule "喂" Exclamation "greeting / call";
  rule "哼" Exclamation "displeasure / disdain";
  rule "噢" Exclamation "realization / reminder";
  rule "咦" Exclamation "doubt / puzzlement";
  rule "哇哇" Exclamation "crying / wailing";
]

let pronouns = [
  rule "我" Pronoun "first person singular";
  rule "家己" Pronoun "reflexive pronoun; myself";
  rule "你" Pronoun "second person singular";
  rule "伊" Pronoun "third person singular";
  rule "咱" Pronoun "first person plural inclusive";
  rule "阮" Pronoun "first person plural exclusive";
  rule "恁" Pronoun "second person plural";
  rule "𪜶" Pronoun "third person plural";
]

let demonstratives = [
  rule "這" Demonstrative "proximal; this (near speaker)";
  rule "遮" Demonstrative "proximal; here (near speaker)";
  rule "彼" Demonstrative "distal; that (near listener/away)";
  rule "遐" Demonstrative "distal; there (far away)";
]

let adverbs = [
  rule "嘛" Adverb "also / too";
  rule "亦" Adverb "also";
  rule "也" Adverb "also";

  rule "猶" Adverb "still / yet";
  rule "閣" Adverb "again / more";
]

let nouns = [
  rule "阿公" Noun "grandfather; father's father";
  rule "阿媽" Noun "grandmother; father's mother";
  rule "阿爸" Noun "father";
  rule "阿母" Noun "mother";
  rule "阿伯" Noun "uncle; father's elder brother";
  rule "阿叔" Noun "uncle; father's younger brother";
  rule "阿姑" Noun "aunt; father's sister";
  rule "阿姆" Noun "aunt; paternal elder uncle's wife";
  rule "阿嬸" Noun "aunt; paternal younger uncle's wife";
  rule "阿舅" Noun "uncle; mother's brother";
  rule "阿姨" Noun "aunt; mother's sister";
  rule "阿妗" Noun "aunt; maternal uncle's wife";
  rule "阿姊" Noun "elder sister (relative to speaker)";
  rule "阿兄" Noun "elder brother (relative to speaker)";
  rule "阿嫂" Noun "elder brother's wife";
  rule "翁" Noun "husband";
  rule "某" Noun "wife";
  rule "紅菜頭" Noun "beet";
  rule "紅菜" Noun "Okinawa spinach";
  rule "木瓜" Noun "papaya";
  rule "番麥" Noun "corn";
  rule "米芳" Noun "puffed rice cake";
]

let rules = List.concat [
  punctuations;
  particles;
  conjugations;
  prepositions;
  exclamations;
  pronouns;
  demonstratives;
  adverbs;
  nouns;
  ambiguities;
]

let string_of_pos = function
  | Punctuation -> "Punctuation"
  | Particle -> "Particle"
  | Conjugation -> "Conjugation"
  | Preposition -> "Preposition"
  | Exclamation -> "Exclamation"
  | Pronoun -> "Pronoun"
  | Demonstrative -> "Demonstrative"
  | Adverb -> "Adverb"
  | Noun -> "Noun"
  | Ambiguity -> "Ambiguity"
  | Text -> "Text"
  | End -> "End"

let print_token (Token(Pattern(p), pos, Trans(t))) =
  Printf.sprintf "(%s, %s, \"%s\")" p (string_of_pos pos) t
