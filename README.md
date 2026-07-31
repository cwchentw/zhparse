# zhparse

A rule‑based parser for Chinese dialects.

## ✨ Rationale

NLP tools for Chinese dialects remain scarce, which limits the development of downstream language applications.  
While a purely rule‑based parser cannot achieve production‑grade accuracy due to inherent ambiguities that rules alone cannot resolve, it can serve as a **bootstrap foundation for machine learning and deep learning parsers**.

## 📌 Project Status

The current stage of development is focused on the **Taigi (Taiwanese Hokkien) lexer/tokenizer** projects. The main objective is to design a **rule‑based lexer** that can consistently handle unambiguous words. In this initial phase, particular attention is placed on **grammatical markers** and **high‑frequency vocabulary**, ensuring that the foundation of the system is both stable and practical for real usage.

Meanwhile, work on the **Hakka lexer/tokenizer** has been postponed due to the complexity of dialectal variation. Since manually adding words is a tedious process, future progress will rely on building an **interactive GUI or Web application** to streamline data entry. This approach will make dictionary expansion more efficient and allow smoother integration into the lexer framework.

## ⚙️ System Requirements

- OCaml `4.14+` (recommended)
- [ocaml-clean-compile](https://github.com/opensourcedoc/ocaml-clean-compile) — compile OCaml code without Dune

## 📄 License

MIT License © 2026 ByteBard
