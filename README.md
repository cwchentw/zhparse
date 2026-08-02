# zhparse

A rule‑based parser for Chinese regional languages (Sinitic languages).

## ✨ Rationale

NLP tools for Chinese regional languages remain scarce, which limits the development of downstream language applications.  
While a purely rule‑based parser cannot achieve production‑grade accuracy due to inherent ambiguities that rules alone cannot resolve, it can serve as a **bootstrap foundation for machine learning and deep learning parsers**.

## 📌 Project Status

The current stage of development is focused on the **Taigi (Taiwanese Hokkien) lexer/tokenizer** projects. The main objective is to design a **rule‑based lexer** that can consistently handle unambiguous words. In this initial phase, particular attention is placed on **grammatical markers** and **high‑frequency vocabulary**, ensuring that the foundation of the system is both stable and practical for real usage.

Work on the **Hakka lexer/tokenizer** continues, but regional distinctions are not implemented at this stage due to insufficient data. Lexical entries will be restructured once more comprehensive sources become available.

## ⚙️ System Requirements

- OCaml `4.14+` (recommended)
- [ocaml-clean-compile](https://github.com/opensourcedoc/ocaml-clean-compile) — compile OCaml code without Dune

## 📄 License

MIT License © 2026 ByteBard
