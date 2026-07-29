let program = "taigilr"
let version = "0.1.0"

type command =
  | Version
  | Help
  | Sentence of string

let arg_parse argv =
  match Array.to_list argv with
  | [_] -> Error "No sentence"
  | [_; "-v"] | [_; "--version"] -> Ok Version
  | [_; "-h"] | [_; "--help"] -> Ok Help
  | [_; arg] when String.starts_with ~prefix:"-" arg ->
    Error (Printf.sprintf "Unknown option: %s" arg)
  | [_; sentence] -> Ok (Sentence sentence)
  | _ -> Error "Too many arguments"

type stream =
  | Stdout
  | Stderr

let help_info stream =
  let template = Printf.sprintf "Usage: %s [option] <sentence>" program in
  match stream with
  | Stdout -> print_endline template
  | Stderr -> prerr_endline template

type pos =
  | Punc
  | Ambiguity
  | Particle
  | Exclamation
  | Conj
  | Pronoun
  | Noun
  | Text
  | End

type pattern = Pattern of string
type trans = Trans of string

type rule = Rule of pattern * pos * trans
type token = Token of pattern * pos * trans

let rule pattern pos trans = Rule(Pattern(pattern), pos, Trans(trans))
let token pattern pos trans = Token(Pattern(pattern), pos, Trans(trans))

let punctuations = [
  rule "。" Punc "sentence terminator";
  rule "？" Punc "question terminator";
  rule "！" Punc "exclamation terminator";
  rule "，" Punc "comma / pause";
  rule "；" Punc "semicolon / connector";
  rule "：" Punc "colon / introducer";
  rule "…" Punc "ellipsis / omission";
  rule "—" Punc "dash / interruption";
  rule "「" Punc "opening quotation mark";
  rule "」" Punc "closing quotation mark";
  rule "『" Punc "opening nested quotation mark";
  rule "』" Punc "closing nested quotation mark";
  rule "（" Punc "opening parenthesis";
  rule "）" Punc "closing parenthesis";
]

let ambiguities = [
  rule "會" Ambiguity "Ambiguous meaning";
  rule "咧" Ambiguity "Ambiguous meaning";
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
  rule "我" Pronoun "first person singular"
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
  exclamations;
  pronouns;
  nouns;
  ambiguities;
]

let rec take n lst =
  if n <= 0 then []
  else match lst with
    | [] -> []
    | x :: xs -> x :: take (n - 1) xs

let rec drop n lst =
  if n <= 0 then lst
  else match lst with
    | [] -> []
    | _ :: xs -> drop (n - 1) xs

let tokenize_utf8 (s : string) : Uchar.t list =
  let len = String.length s in
  let rec loop i acc =
    if i >= len then List.rev acc
    else
      let decode = String.get_utf_8_uchar s i in
      let uchar = Uchar.utf_decode_uchar decode in
      let width = Uchar.utf_decode_length decode in
      loop (i + width) (uchar :: acc)
  in
  loop 0 []

let string_of_uchars (uchars : Uchar.t list) : string =
  let buf = Buffer.create (List.length uchars * 4) in
  List.iter (Buffer.add_utf_8_uchar buf) uchars;
  Buffer.contents buf

let match_rule_prefix (rules : rule list) (uchars : Uchar.t list) =
  let total_len = List.length uchars in
  let rec try_lengths len =
    if len <= 0 then None
    else
      let prefix_str = string_of_uchars (take len uchars) in
      let matched = rules |> List.find_opt (fun (Rule(Pattern(p), _, _)) -> p = prefix_str) in
      match matched with
      | Some (Rule(Pattern(p), pos_tag, trans_tag)) ->
          Some (Token(Pattern(p), pos_tag, trans_tag), drop len uchars)
      | None -> try_lengths (len - 1)
  in
  try_lengths total_len

let consume_text_chunk (rules : rule list) (uchars : Uchar.t list) =
  let rec loop rest acc =
    match rest with
    | [] -> List.rev acc, []
    | u :: tl ->
        match match_rule_prefix rules rest with
        | Some _ -> List.rev acc, rest
        | None -> loop tl (u :: acc)
  in
  let text_uchars, remaining = loop uchars [] in
  let text_str = string_of_uchars text_uchars in
  (token text_str Text "text content", remaining)

let lex (rules : rule list) (str : string) : token list =
  let tokens = tokenize_utf8 str in
  let rec loop uchars acc =
    match uchars with
    | [] -> List.rev acc
    | _ ->
        match match_rule_prefix rules uchars with
        | Some (tok, remaining) ->
            loop remaining (tok :: acc)
        | None ->
            let text_tok, remaining = consume_text_chunk rules uchars in
            loop remaining (text_tok :: acc)
  in
  loop tokens []

let string_of_pos = function
  | Punc -> "Punc"
  | Ambiguity -> "Ambiguity"
  | Particle -> "Particle"
  | Exclamation -> "Exclamation"
  | Conj -> "Conj"
  | Pronoun -> "Pronoun"
  | Noun -> "Noun"
  | Text -> "Text"
  | End -> "End"

let print_token (Token(Pattern(p), pos, Trans(t))) =
  Printf.sprintf "(%s, %s, \"%s\")" p (string_of_pos pos) t

let _ =
  let cmd = arg_parse Sys.argv in
  match cmd with
  | Ok Version ->
    Printf.printf "%s\n" version
  | Ok Help ->
    help_info Stdout
  | Ok (Sentence sentence) ->
    Printf.printf "# %s\n" sentence;
    lex rules sentence
    |> List.iter (fun x -> print_endline (print_token x));
    Printf.printf "(%s, %s, \"%s\")\n" "EOS" (string_of_pos End) "end of sentence"
  | Error err ->
    prerr_endline err;
    help_info Stderr;
    exit 1
