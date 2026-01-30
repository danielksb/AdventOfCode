&p "Running Benchmark..."
N ← ⍥(⁅ ×10000 ⚂)1000000
N
&p $"length: _" ⊸⧻
⍜now⍥(◌⊚≠⊸⍆N)100
&p $"result: _ s/ops" ÷100
