Input ← (
  $ MMMSXXMASM
  $ MSAMXMSMSA
  $ AMXSXMAAMM
  $ MSAMASMSMX
  $ XMASAMXAMM
  $ XXAMMXXAMA
  $ SMSMSASXSS
  $ SAXAMASAAA
  $ MAMMMXMMMM
  $ MXMXAXMASX
)

Input ← &fras "input.txt"

Parse ← ⊜∘ ⊸(¬∊"\r\n")

Data ← Parse Input

Part₁ ← (
  Data
  ⍥(⊸⍉⇌)4
  /+♭ ⌕"XMAS"

  "XMAS"
  ⬚@\W⤸0_0
  ⍥(⊸⍉⇌)4
  ≡(˜⌕Data)
  /+♭
  +
)

Target ← ["M\WS"
          "\WA\W"
          "M\WS"]
Part₂ ← (
  Data
  ⍥(⊸⍉⇌)4
  /+♭ ⌕Target
)

Part₁
Part₂
