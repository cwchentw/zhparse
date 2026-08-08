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

let string_of_uchar (uchar : Uchar.t) : string =
  let buf = Buffer.create 4 in
  Buffer.add_utf_8_uchar buf uchar;
  Buffer.contents buf

let string_of_uchars (uchars : Uchar.t list) : string =
  let buf = Buffer.create (List.length uchars * 4) in
  List.iter (Buffer.add_utf_8_uchar buf) uchars;
  Buffer.contents buf

let is_english (uchar : Uchar.t) =
  let code = Uchar.to_int uchar in
  (code >= 65 && code <= 90) || (code >= 97 && code <= 122)

let is_uppcase (uchar : Uchar.t) =
  let code = Uchar.to_int uchar in
  code >= 65 && code <= 90

let match_foreign_proper_noun (uchars : Uchar.t list) =
  let rec match_english (ucs : Uchar.t list) (acc : Uchar.t list) =
    match ucs with
    | [] -> [], List.rev acc
    | x :: xs when is_english x -> match_english xs (x :: acc)
    | _ -> ucs, List.rev acc
  in
  let (remaining, matched_uchars) = match_english uchars [] in
  match matched_uchars with
  | [] -> None
  | _ ->
      let z = string_of_uchars matched_uchars in
      if List.exists is_uppcase matched_uchars then
        #if defined mandarin
        Some (Token(Hanzi(z), Pinyin(z), Noun, Trans(z)), remaining)
        #elif defined taigi
        Some (Token(Hanzi(z), Tailo(z), Noun, Trans(z)), remaining)
        #elif defined hakka
        Some (Token(Pattern(z), Noun, all_dialect, Trans(z)), remaining)
        #endif
      else
        #if defined mandarin
        Some (Token(Hanzi(z), Pinyin(z), Foreign, Trans(z)), remaining)
        #elif defined taigi
        Some (Token(Hanzi(z), Tailo(z), Foreign, Trans(z)), remaining)
        #elif defined hakka
        Some (Token(Pattern(z), Foreign, all_dialect, Trans(z)), remaining)
        #endif

let match_rule_prefix (rules : rule list) (uchars : Uchar.t list) =
  let total_len = List.length uchars in
  let rec try_lengths len =
    if len <= 0 then None
    else
      let prefix_str = string_of_uchars (take len uchars) in
      #if defined mandarin
      let matched = rules |> List.find_opt (fun (Rule(Hanzi(z), _, _, _)) -> z = prefix_str) in
      #elif defined taigi
      let matched = rules |> List.find_opt (fun (Rule(Hanzi(z), _, _, _)) -> z = prefix_str) in
      #elif defined hakka
      let matched = rules |> List.find_opt (fun (Rule(Pattern(p), _, _, _)) -> p = prefix_str) in
      #endif
      match matched with
      #if defined mandarin
      | Some (Rule(Hanzi(z), Pinyin(py), pos_tag, trans_tag)) ->
        Some (Token(Hanzi(z), Pinyin(py), pos_tag, trans_tag), drop len uchars)
      #elif defined taigi
      | Some (Rule(Hanzi(z), Tailo(t), pos_tag, trans_tag)) ->
        Some (Token(Hanzi(z), Tailo(t), pos_tag, trans_tag), drop len uchars)
      #elif defined hakka
      | Some (Rule(Pattern(p), pos_tag, dialect, trans_tag)) ->
        Some (Token(Pattern(p), pos_tag, dialect, trans_tag), drop len uchars)
      #endif
      | None -> try_lengths (len - 1)
  in
  try_lengths total_len

let consume_text_chunk (rules : rule list) (uchars : Uchar.t list) =
  let rec loop rest acc =
    match rest with
    | [] -> List.rev acc, []
    | u :: tl ->
        if is_english u then
          List.rev acc, rest
        else
          match match_rule_prefix rules rest with
          | Some _ -> List.rev acc, rest
          | None -> loop tl (u :: acc)
  in
  let text_uchars, remaining =
    match loop uchars [] with
    | [], u :: tl -> [u], tl
    | res -> res
  in
  let text_str = string_of_uchars text_uchars in
  #if defined mandarin
  (token text_str text_str Text "text content", remaining)
  #elif defined taigi
  (token text_str text_str Text "text content", remaining)
  #elif defined hakka
  (token text_str Text all_dialect "text content", remaining)
  #endif

let lex (rules : rule list) (str : string) : token list =
  let tokens = tokenize_utf8 str in
  let rec loop uchars acc =
    match uchars with
    | [] -> List.rev acc
    | x :: _ ->
        let matched_res =
          if is_english x then
            match_foreign_proper_noun uchars
          else
            match_rule_prefix rules uchars
        in
        match matched_res with
        | Some (tok, remaining) ->
            loop remaining (tok :: acc)
        | None ->
            let text_tok, remaining = consume_text_chunk rules uchars in
            loop remaining (text_tok :: acc)
  in
  loop tokens []
