# zhparse

A rule‑based parser for Chinese dialects.

## ✨ Rationale

NLP tools for Chinese dialects remain scarce, which limits the development of downstream language applications.  
While a purely rule‑based parser cannot achieve production‑grade accuracy due to inherent ambiguities that rules alone cannot resolve, it can serve as a **bootstrap foundation for machine learning and deep learning parsers**.

## 📌 Project Status

Current development is centered on the **Taigi (Taiwanese Hokkien) and Hakka lexer/tokenizer** projects.  
The primary objective is to design a rule‑based lexer that can consistently process unambiguous words. Given the scope of this undertaking, the initial phase emphasizes **grammatical markers** and **high‑frequency vocabulary** in both Taigi and Hakka.

## ⚙️ System Requirements

- OCaml `4.14+` (recommended)
- [ocaml-clean-compile](https://github.com/opensourcedoc/ocaml-clean-compile) — compile OCaml code without Dune

## 📄 License

MIT License © 2026 ByteBard
