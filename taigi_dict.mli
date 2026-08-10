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

val rule : string -> string -> pos -> string -> rule
val token : string -> string -> pos -> string -> token

val rules : rule list

val string_of_pos : pos -> string
val string_of_token : token -> string
