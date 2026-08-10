type dialect =
  | Sixian
  | Hailu
  | Dapu
  | Raoping
  | Zhaoan
  | SouthSixian

let int_of_dialect d =
  match d with
  | Sixian      -> 0b000001
  | Hailu       -> 0b000010
  | Dapu        -> 0b000100
  | Raoping     -> 0b001000
  | Zhaoan      -> 0b010000
  | SouthSixian -> 0b100000

let string_of_dialect d =
  match d with
  | Sixian      -> "Sixian"
  | Hailu       -> "Hailu"
  | Dapu        -> "Dapu"
  | Raoping     -> "Raoping"
  | Zhaoan      -> "Zhao'an"
  | SouthSixian -> "South Sixian"

let combine (a : dialect) (b : dialect) =
  (int_of_dialect a) lor (int_of_dialect b)

let is_dialect a (b : dialect) =
  a land (int_of_dialect b) <> 0

let all_dialect =
  int_of_dialect Sixian
  lor int_of_dialect Hailu
  lor int_of_dialect Dapu
  lor int_of_dialect Raoping
  lor int_of_dialect Zhaoan
  lor int_of_dialect SouthSixian

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

type pattern = Pattern of string
type trans = Trans of string

type rule = Rule of pattern * pos * int * trans
type token = Token of pattern * pos * int * trans

let rule pattern pos dialect trans = Rule (Pattern pattern, pos, dialect, Trans trans)
let token pattern pos dialect trans = Token (Pattern pattern, pos, dialect, Trans trans)

let punctuations = [
  rule "。" Punctuation all_dialect "sentence terminator";
  rule "？" Punctuation all_dialect "question terminator";
  rule "！" Punctuation all_dialect "exclamation terminator";
  rule "，" Punctuation all_dialect "comma / pause";
  rule "；" Punctuation all_dialect "semicolon / connector";
  rule "：" Punctuation all_dialect "colon / introducer";
  rule "…" Punctuation all_dialect "ellipsis / omission";
  rule "—" Punctuation all_dialect "dash / interruption";
  rule "「" Punctuation all_dialect "opening quotation mark";
  rule "」" Punctuation all_dialect "closing quotation mark";
  rule "『" Punctuation all_dialect "opening nested quotation mark";
  rule "』" Punctuation all_dialect "closing nested quotation mark";
  rule "（" Punctuation all_dialect "opening parenthesis";
  rule "）" Punctuation all_dialect "closing parenthesis";
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

let nouns = [
  rule "姨丈公" Noun all_dialect "husband of maternal grandmother's sister";
  rule "阿嬤" Noun all_dialect "grandmother (commonly paternal)";
  rule "阿媽" Noun all_dialect "grandmother (commonly paternal)";
  rule "姐婆" Noun all_dialect "maternal grandmother";
  rule "丈㜷媽" Noun all_dialect "wife's grandmother";
  rule "阿怙" Noun all_dialect "father (classical term)";
  rule "伯㜷" Noun all_dialect "paternal uncle's wife";
  rule "爺母" Noun all_dialect "parents";
  rule "公姐子" Noun all_dialect "married couple";
  rule "姪子" Noun all_dialect "brother's son";
  rule "姪女" Noun all_dialect "brother's daughter";
  rule "姪阿郎" Noun all_dialect "husband of niece";
  rule "桌仔" Noun (int_of_dialect Sixian) "desk";
  rule "桌" Noun (int_of_dialect Hailu lor int_of_dialect Dapu lor int_of_dialect Raoping lor int_of_dialect SouthSixian) "desk";
  rule "桌子" Noun (int_of_dialect Zhaoan) "desk";
  rule "椅仔" Noun (int_of_dialect Sixian lor int_of_dialect Hailu lor int_of_dialect Raoping) "chair";
  rule "椅" Noun (int_of_dialect Dapu lor int_of_dialect SouthSixian) "chair";
  rule "椅子" Noun (int_of_dialect Zhaoan) "chair";
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

let print_dialect d =
  if d land all_dialect = all_dialect then
    "all dialect"
  else if d = 0 then
    "none"
  else
    let buf = Buffer.create 16 in
    let check dialect =
      if is_dialect d dialect then (
        Buffer.add_string buf (string_of_dialect dialect);
        Buffer.add_string buf " "
      )
    in
    check Sixian;
    check Hailu;
    check Dapu;
    check Raoping;
    check Zhaoan;
    check SouthSixian;
    buf |> Buffer.contents |> String.trim

let print_token (Token (Pattern p, pos, dialect, Trans t)) =
  Printf.sprintf "(%s, %s, %s, %s)" p (string_of_pos pos) (print_dialect dialect) t
