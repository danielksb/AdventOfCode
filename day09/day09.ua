# Experimental!
Input ← (
  $ 7,1
  $ 11,1
  $ 11,7
  $ 9,7
  $ 9,5
  $ 2,5
  $ 2,3
  $ 7,3
)
Input ← &fras "input.txt"

Data ← ⊜(⊜⋕ ⊸(≠@,)) ⊸(¬∊"\r\n") Input

Edges ← ⧈∘ 2 ⊂⟜⊢Data
Pairs ← ⧅<2 Data

Area ← /×+1⌵/-

Part₁ ← /↥ ≡(Area) Pairs

&p $"Part 1: _" Part₁

AllEqual ← /× ≡(≍°⊟) ⧈∘2

HorizontalEdges ← ▽ ⊸≡(/=≡⊣) Edges
VerticalEdges   ← ▽ ⊸≡(/=≡⊢) Edges

HorizontalLines ← ≡(⊣⊡0) HorizontalEdges
VerticalLines   ← ≡(⊢⊡0) VerticalEdges

OnHorizontalEdge ← (
  ˜▽ HorizontalEdges (=HorizontalLines ⊸⊣) # find edge
  ≡⌟(
    ⊃/↧/↥≡⊢
    ⊙⊙⊢
    ×⊃(≥⊙⋅∘)(≤⋅⊙∘)
  )
  ⨬(0|/×)⊸⧻ # and everything
)
# OnHorizontalEdge ← (≤⊙≤ ⊙⊙⊢ ⊃/↧/↥ ≡⊣) HorizontalEdges
OnVerticalEdge ← (
  ˜▽ VerticalEdges (=VerticalLines ⊸⊢) # find edge
  ≡⌟(
    ⊃/↧/↥≡⊣
    ⊙⊙⊣
    ×⊃(≥⊙⋅∘)(≤⋅⊙∘)
  )
  ⨬(0|/×)⊸⧻ # and everything
)

CrossesY  ← =1/+ > ⊙⊣ ≡⊣
IsRightOf ← < ⊡0_0 ⊙⊢
RayHits   ← ×⊃(CrossesY|IsRightOf)
RayInside ← =1◿2 /+ ≡⌟RayHits VerticalEdges
OnAnyEdge ← ∨ ⊃(OnVerticalEdge|OnHorizontalEdge)
# [7_1 11_3] -> [7_3 11_1]
OppositeEdges ← ⍜⍉⍜(⊡1)(↻1)
Inside        ← memo∨⊃(OnAnyEdge|RayInside)

# ⊞(⊂) ⇡14 ⇡9
# ⊞(Inside⊂) ⇡14 ⇡9

LargestAreas ← ⊏⍖ ⊸≡(Area) ⧅<2 Data

# Given a range checks if a number is inside.
# bool ? range num
# e.g. [1 5] 7 checks for 1 < 7 < 5
InRange ← ×⊃(>⊢)(<⊣)

# checks if two ranges overlap
# bool ? range range
RangeOverlap ← (
  ⍏⊂
  ¬∊ [2_0_3_1 0_1_2_3 2_3_0_1]
)

VerticalCollide   ← InRange ⊙(⊢≡⊢) ⍆≡⊢
HorizontalCollide ← InRange ⊙(⊢≡⊣) ⍆≡⊣
HorizontalOverlap ← RangeOverlap ∩(⍆≡⊣)
VerticalOverlap   ← RangeOverlap ∩(⍆≡⊢)
RectEdgeCollide   ← ∨⊃(×⊃VerticalCollide HorizontalOverlap) (×⊃HorizontalCollide VerticalOverlap)

HasEdgeInside ← /∨≡⌟˜RectEdgeCollide Edges

Part₂ ← (
  LargestAreas
  wait⊸≡pool(¬HasEdgeInside)
  Area⊢▽
)
&p $"Part 2: _" Part₂

┌─╴test
  ⍤⤙≍ 1 RectEdgeCollide [11_1 2_3] [7_1 7_3]
  ⍤⤙≍ 0 RectEdgeCollide [11_1 2_3] [11_1 11_3]
  ⍤⤙≍ 0 RectEdgeCollide [11_1 2_3] [11_1 11_4]
  ⍤⤙≍ 1 RectEdgeCollide [2_1 11_3] [2_2 11_2]
  ⍤⤙≍ 0 RectEdgeCollide [9_5 2_3] [7_1 11_1]
  ⍤⤙≍ 0 RectEdgeCollide [9_5 2_3] [2_3 7_3]
  ⍤⤙≍ 0 RectEdgeCollide [9_5 2_3] [7_3 7_1]
  ⍤⤙≍ 1 RangeOverlap [1 5] [2 6]
  ⍤⤙≍ 1 RangeOverlap [6 2] [5 1]
  ⍤⤙≍ 1 RangeOverlap [1 5] [1 5]
  ⍤⤙≍ 1 RangeOverlap [1 5] [1 6]
  ⍤⤙≍ 1 RangeOverlap [1 5] [0 5]
  ⍤⤙≍ 0 RangeOverlap [1 5] [5 6]
  ⍤⤙≍ 0 RangeOverlap [5 6] [1 5]
  ⍤⤙≍ 0 RangeOverlap [1 5] [6 7]
  ⍤⤙≍ 0 RangeOverlap [6 7] [1 5]
└─╴
