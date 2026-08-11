# Ambiguous Words

## Definition

In Chinese corpora, **ambiguous words** are lexical items whose meaning or function shifts depending on context. They often overlap across categories (e.g., noun vs. verb, or function word vs. content word), making them difficult to resolve deterministically.

## Problem in Rule-Based Lexers

- Rule-based lexers rely on fixed tokenization rules.
- Ambiguous words resist such treatment because:
  - Their role changes with syntactic or semantic context.
  - Corpus frequency shows high variability in usage.
- Attempting to resolve them with handcrafted rules leads to brittle parsing and misclassification.

## Current Strategy

- **No explicit rules** are written to resolve ambiguous words.
- Instead, the lexer **falls back to a generic "Text" token** whenever ambiguity arises.
- This design choice avoids premature or incorrect resolution at the lexical stage.

## Role of Deep Learning Models

- Contextual disambiguation is deferred to **deep learning models**.
- These models can leverage surrounding corpus context to infer the correct interpretation.
- This separation of concerns ensures:
  - The lexer remains simple and robust.
  - Higher-level models handle the complexity of semantic and syntactic resolution.

## Summary

Ambiguous words are a natural challenge in Chinese parsing. zhparse deliberately avoids rule-based resolution, treating them as raw text tokens. By deferring interpretation to deep learning models, the system maintains stability at the lexical layer while enabling accurate understanding at the corpus level.
