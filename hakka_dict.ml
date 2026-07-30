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

let ambiguities = []

let particles = []

let conjugations = []

let prepositions = []

let exclamations = []

let pronouns = []

let demonstratives = []

let adverbs = []

let nouns = []

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
