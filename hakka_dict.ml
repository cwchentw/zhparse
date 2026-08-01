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
  | Adverb
  | Noun
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

let particles = []

let conjugations = []

let prepositions = []

let exclamations = []

let pronouns = []

let demonstratives = []

let adverbs = []

let nouns = [
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
  | Adverb -> "Adverb"
  | Noun -> "Noun"
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
  Printf.sprintf "(%s, %s, \"%s\", \"%s\")" p (string_of_pos pos) (print_dialect dialect) t
