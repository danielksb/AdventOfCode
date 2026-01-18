Input ← (
  $ 47|53
  $ 97|13
  $ 97|61
  $ 97|47
  $ 75|29
  $ 61|13
  $ 75|53
  $ 29|13
  $ 97|29
  $ 53|29
  $ 61|53
  $ 97|53
  $ 61|29
  $ 47|13
  $ 75|47
  $ 97|75
  $ 47|61
  $ 75|61
  $ 47|29
  $ 75|13
  $ 53|13
  $ 
  $ 75,47,61,53,29
  $ 97,61,53,29,13
  $ 75,29,13
  $ 75,97,47,61,53
  $ 61,13,29
  $ 97,13,75,29,47
)

Input ← &fras "input.txt"

SplitParts ← ⊜□ ⊸(¬⌕"\n\n")

Rules ← memo(
  °□⊢ SplitParts Input
  ⊜([∩⋕°$"_|_"]) ⊸(≠@\n)
)

Pages ← memo(
  °□⊣ SplitParts Input
  ⊜(□⊜⋕ ⊸(≠@,)) ⊸(≠@\n)
)

MiddleValue ← ⊡⊸(⌊÷2⧻)

# Returns the middle value if pages are valid or 0 if not valid
# Bool ? Pages Rules
Validate ← (
  ⤚⊃⧻⨂      # Length RuleIndices Pages
  ▽ ⊸(≡/↧≠) # remove indizes not matching page nums
  /↧≡(/>)   # check if valid
  ⨬(0|MiddleValue)
)

Part₁ ← /+ ≡⌟(◇Validate) Pages Rules

InvalidPages ← ▽ ⤚(¬±≡⌟(◇Validate)) Pages Rules

# a pair is sorted if a rule exists for the pair
IsValidPair ← ∊Rules

# Sorts given pages by IsValidPair
SortPages ← ⇌⊏ ⊸(⍏ ≡/+ ˙⊞(IsValidPair⊂))

Part₂ ← /+ ≡⌟(Validate ◇SortPages) InvalidPages Rules

&p $"_ _ " ⊃Part₁ Part₂
