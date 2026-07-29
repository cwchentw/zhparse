# taigi-parse

A rule-based Taigi parser.

## ✨ Rationale

There are currently very few NLP tools for Taigi, which limits the development of Taigi-based applications.  
A purely rule-based parser cannot reach production-grade quality due to the many ambiguities that are difficult to resolve with rules alone.  
However, such a parser can serve as a **bootstrap foundation for machine learning or deep learning parsers**.

## 📌 Project Status

Work is in progress on the **lexer / tokenizer**.  
Ideally, a rule-based lexer should cover all unambiguous words. Since this is a large undertaking, the initial focus will be on **grammar words** and **common words** in Taigi.

## ⚙️ System Requirements

- OCaml `4.14+` (recommended)  
- [ocaml-clean-compile](https://github.com/opensourcedoc/ocaml-clean-compile) — compile OCaml code without Dune  
- [clean-artifact](https://github.com/opensourcedoc/clean-artifact) — clean build artifacts  

## 📄 License

MIT License © 2026 ByteBard
