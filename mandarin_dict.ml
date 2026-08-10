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
type pinyin = Pinyin of string
type trans = Trans of string

type rule = Rule of hanzi * pinyin * pos * trans
type token = Token of hanzi * pinyin * pos * trans

let rule hanzi pinyin pos trans = Rule(Hanzi(hanzi), Pinyin(pinyin), pos, Trans(trans))
let token hanzi pinyin pos trans = Token(Hanzi(hanzi), Pinyin(pinyin), pos, Trans(trans))

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

let particles : rule list = []

let conjugations : rule list = []

let prepositions : rule list = []

let exclamations : rule list = []

let pronouns : rule list = []

let demonstratives : rule list = []

let prefixes : rule list = []

let suffixes : rule list = []

let phrases : rule list = []

let adverbs : rule list = []

let approximation_adverbs : rule list = []

let adjectives : rule list = []

let verbs : rule list = []

let numerals : rule list = []

let nouns : rule list = []

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

let string_of_token (Token(Hanzi(z), Pinyin(py), pos, Trans(ts))) =
  Printf.sprintf "(%s, %s, %s, %s)" z py (string_of_pos pos) ts
