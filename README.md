# zhparse

A rule‑based parser for Chinese dialects.

## ✨ Rationale

NLP tools for Chinese dialects remain scarce, which limits the development of downstream language applications.  
While a purely rule‑based parser cannot achieve production‑grade accuracy due to inherent ambiguities that rules alone cannot resolve, it can serve as a **bootstrap foundation for machine learning and deep learning parsers**.

## 📌 Project Status

Development is currently focused on the **Taigi (Taiwanese Hokkien) lexer/tokenizer**.  
The goal is to build a rule‑based lexer that reliably handles unambiguous words. Given the scale of this task, early work prioritizes **grammatical markers** and **high‑frequency vocabulary** in Taigi.

## ⚙️ System Requirements

- OCaml `4.14+` (recommended)
- [ocaml-clean-compile](https://github.com/opensourcedoc/ocaml-clean-compile) — compile OCaml code without Dune

## 📄 License

MIT License © 2026 ByteBard
