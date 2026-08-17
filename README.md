# zhparse

A rule‑based parser for Chinese regional languages (Sinitic languages).

## ✨ Rationale

NLP tools for Chinese regional languages remain scarce, which limits the development of downstream language applications.  
While a purely rule‑based parser cannot achieve production‑grade accuracy due to inherent ambiguities that rules alone cannot resolve, it can serve as a **bootstrap foundation for machine learning and deep learning parsers**.

## 📌 Project Status

**NLP is fundamentally an engineering discipline, not just programming.**    
Models are driven by corpora rather than code. Programming in this context primarily serves as data preprocessing and rule construction.

This project is presented as a **prototype of a rule‑based Chinese analyzer**, intended to demonstrate methodology and design principles. It is not aimed at productization, but rather serves as a research and teaching example that highlights corpus‑driven approaches to language processing.

## ⚙️ System Requirements

- OCaml `4.14+` (recommended)
- [ocaml-clean-compile](https://github.com/opensourcedoc/ocaml-clean-compile) — compile OCaml code without Dune

## 📄 License

MIT License © 2026 ByteBard
