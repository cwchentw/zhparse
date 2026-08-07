let version = "0.1.0"

#include "flag.ml"
#include "dict.ml"
#include "lexer.ml"

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
  let template = Printf.sprintf "Usage: %s [option] <sentence>" Sys.argv.(0) in
  match stream with
  | Stdout -> print_endline template
  | Stderr -> prerr_endline template

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
    #if defined taigi
    Printf.printf "(%s, %s, %s, %s)\n" "EOS" "EOS" (string_of_pos End) "end of sentence"
    #elif defined hakka
    Printf.printf "(%s, %s, %s, %s)\n" "EOS" (string_of_pos End) "all dialect" "end of sentence"
    #endif
  | Error err ->
    prerr_endline err;
    help_info Stderr;
    exit 1
