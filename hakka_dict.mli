type dialect =
  | Sixian
  | Hailu
  | Dapu
  | Raoping
  | Zhaoan
  | SouthSixian

val int_of_dialect : dialect -> int
val string_of_dialect : dialect -> string

val all_dialect : int

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

val rule : string -> pos -> int -> string -> rule
val token : string -> pos -> int -> string -> token

val rules : rule list

val string_of_pos : pos -> string
val string_of_token : token -> string
