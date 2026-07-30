let program = "taigilr"
let version = "0.1.0"

#include "dict.ml"

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
