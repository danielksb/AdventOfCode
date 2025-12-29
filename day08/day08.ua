# Experimental!

Input ← (
  $ 162,817,812
  $ 57,618,57
  $ 906,360,560
  $ 592,479,940
  $ 352,342,300
  $ 466,668,158
  $ 542,29,236
  $ 431,825,988
  $ 739,650,466
  $ 52,470,668
  $ 216,146,977
  $ 819,987,18
  $ 117,168,530
  $ 805,96,715
  $ 346,949,466
  $ 970,615,88
  $ 941,993,340
  $ 862,61,35
  $ 984,92,344
  $ 425,690,689
)
Input ← &fras "input.txt"

Data ← ⊜(⊜⋕ ⊸≠@,) ⊸(¬∊"\r\n") Input
# Data

Dist ← √/+ⁿ2-

SortedPairs ← ⊏⍏ ⊸≡(Dist °⊟) ⧅₂<

DistTable ← ˙⊞(Dist) Data

ShortestDists ← ↘₁◴⍆♭ DistTable # drop,1 because of dist to self

ShortestNConns! ← ◴≡⍆⊚∊(↙^ShortestDists) DistTable

ShortestCoords ← ≡(≡(˜⊡ Data)) ShortestNConns!10

# coord circuit -> bool
MatchCircuit ← /↥∊

# Joins array of circuits into a single circuit
JoinCircuits ← ◴˜∧(˜⊂°□)[]

# [0 1 4 5] [4_6] ->  [0 1 4 5 6]
MergeFindings ← ⊂□◴⊂⊙♭

# connection circuits -> new circuits
# 4_6 [□[0_1 1_4 4_5] □[2_3]] -> [□[0_1 1_4 4_5 4_6] □[2_3]]
InsertIntoCircuit ← (
  ◡≡(MatchCircuit⊙°□)¤
  :
  ⊙⊃((JoinCircuits▽∘)|▽¬)
  :
  MergeFindings
)

Part₁ ← (
  ∧(InsertIntoCircuit) ShortestNConns!1000 []
  /×↙₋₃⍆≡(⧻°□)
)
&p $"Part 1: _" Part₁

N ← ⧻Data

Loop ← (
  ⊙°⊂                            # take next coord
  ◡≡⌟(/↥/↥≡⌞∊°□)                 # find matching circuits
  ⊃(⊂[]□ ◴ ˜⊂ JoinCircuits ▽|▽¬) # merge machting circuits, keep non matching circuits
  ⊂                              # join all circuits together
)

Part₂ ← (
  SortedPairs Data
  ⊃{⊢}↘₁ # extract first coord into first circuit
  ⍢(Loop|< N ⧻°□⊢)
  /×♭↙₁⍉↙₂°□⊢
)
&p $"Part 2: _" Part₂

┌─╴test
  ⍤⤙≍ [] JoinCircuits []
  ⍤⤙≍ [0 1 4] JoinCircuits [□[0 1 4]]
  ⍤⤙≍ [0 1 4 2 3] JoinCircuits [□[0 1 4] □[2 3]]
  ⍤⤙≍ [0 1 4 2 3 5] JoinCircuits [□[0 1 4] □[2 3] □[4 5]]
  ⍤⤙≍ 1 MatchCircuit 2_3 [2 3]
  ⍤⤙≍ 1 MatchCircuit 2_3 [1 2 3]
  ⍤⤙≍ 1 MatchCircuit 2_3 [2 4]
  ⍤⤙≍ 1 MatchCircuit 2_3 [1 3]
  ⍤⤙≍ 0 MatchCircuit 2_3 [4 5]
  ⍤⤙≍ [□[0 1 4 5 6] □[2 3]] InsertIntoCircuit 4_6 [□[0 1 4 5] □[2 3]]      # find one circuit
  ⍤⤙≍ [□[0 1 4 5 2 3]] InsertIntoCircuit 4_3 [□[0 1 4 5] □[2 3]]           # find two circuits
  ⍤⤙≍ [□[6 7] □[0 1 4 5] □[2 3]] InsertIntoCircuit 6_7 [□[0 1 4 5] □[2 3]] # find no circuits
  ⍤⤙≍ [□[2 3 6 7] □[0 1 4 5]] InsertIntoCircuit 6_7 [□[0 1 4 5] □[2 3 6]]
  ⍤⤙≍ [□[6 7]] InsertIntoCircuit 6_7 []
  ⍤⤙≍ [□[0 1 2 3 7 8 9] □[4 5 6]] InsertIntoCircuit 3_7 [□[0 1 2 3] □[4 5 6] □[7 8 9]]
  ⍤⤙≍ {{[1_3 0_1]} [3_4 4_5]} {Loop {[0_1]} [1_3 3_4 4_5]}
  ⍤⤙≍ {{[1_3 0_1 1_2 3_7]} [3_4 4_5]} {Loop {[0_1 1_2] [3_7]} [1_3 3_4 4_5]}
  # ⍤⤙≍ {{[11_13] [0_1 1_2] [3_7]} [3_4 4_5]} {Loop {[0_1 1_2] [3_7]} [11_13 3_4 4_5]}
  ⍤⤙≍ {{[1_6 0_1 1_2] [3_7]} [3_4 4_5]} {Loop {[0_1 1_2] [3_7]} [1_6 3_4 4_5]}
  ⍤⤙≍ {[1_2 0_1 2_3]} ⊙◌ Loop {[0_1] [2_3]} [1_2]
└─╴
