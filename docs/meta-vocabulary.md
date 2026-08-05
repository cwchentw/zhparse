# Meta-Vocabulary Specification

This project uses a small set of **meta-tokens** to normalize non-core linguistic inputs.  
They ensure consistency across the corpus and reduce sparsity in training data.

## Token List

### `<NUM>`

- **Definition:** Represents any numeric sequence (e.g., integers, phone numbers, dates).
- **Usage:** Replace all digit sequences with `<NUM>`.
- **Example:**  
  - Input: `0912345678`  
  - Output: `<NUM>`

### `<FOREIGN>`

- **Definition:** Represents non-CJK foreign words (e.g., English, Romanized text).
- **Usage:** Replace unknown foreign words with `<FOREIGN>`.  
  - High-frequency proper nouns (e.g., *iPhone*, *LINE*, *Facebook*) may be preserved in raw form.
- **Example:**  
  - Input: `laptop`  
  - Output: `<FOREIGN>`

### `<PUNCT>`

- **Definition:** Represents punctuation marks and sentence delimiters.
- **Usage:** Normalize all punctuation into `<PUNCT>`, while still logging EOS separately.
- **Example:**  
  - Input: `.`  
  - Output: `<PUNCT>`

### `<UNK>`

- **Definition:** Represents unknown CJK characters not covered by the lexicon.
- **Usage:** Assign `<UNK>` when a character is within the CJK Unicode range but absent from the lexicon.
- **Example:**  
  - Input: Rare Han character not in dictionary  
  - Output: `<UNK>`

## Design Notes

- **Normalization Strategy:**  
  - Numbers → always `<NUM>`  
  - Foreign words → `<FOREIGN>` unless whitelisted  
  - Punctuation → `<PUNCT>`  
  - Unknown Han characters → `<UNK>`
- **Corpus Consistency:**  
  - Meta-tokens should be applied uniformly across silver and gold corpora.  
  - This ensures deep learning models can generalize without overfitting to rare exceptions.
- **Extensibility:**  
  - Additional meta-tokens may be introduced if new exception classes emerge (e.g., `<EMOJI>`).
