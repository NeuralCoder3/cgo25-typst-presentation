#import "common.typ" : *

#slide[
  #toolbox.pdfpc.speaker-note("general already a lot, cut most cut down")
  = Evaluation Enumeration $n=3$

  // biggest contributor to speed

  // general then cut

  #toolbox.side-by-side(
    columns: (10cm,20cm)
  )[
  #table(
    columns: 2,
    stroke: tableStroke,
    table.header(
      [Approach], 
      [Time]
    ),
    [Dijkstra], [$56$s],
    [Dijkstra parallel], [$17$s],
    [Dedup, viable], [$8.6$s],
    [Dedup, A$star$], [$1.7$s],
    [+viable, instr], [$0.7$s],
    [+cut $k=1$], [$0.1$s],
  )
  ][
    #show: later

    #place(
      center,
      dx:-2cm,
      image("imgs/all_solutions_cut_all_commands_no_early__scattered_a70_p50_i3000_cut.png",height: 11cm)
    )
  ]

]

// warning: layout did not converge within 5 attempts
#slide[
  = Evaluation Enumeration $n>=3$

  #table(
    columns: 4,
    stroke: tableStroke,
    table.header(
      [Approach], 
      [#place(dy:-1cm,text(20pt)[#box[$l=11$]])$n=3$], 
      [#place(dy:-1cm,text(20pt)[#box[$l=20$]])$n=4$], 
      [#place(dy:-1cm,text(20pt)[#box[$l=33$]])$n=5$], 
    ),
    [Enumeration], best[$97$ms], [$2.4$s], best[$11$min],
    [AlphaDev-RL], [$6$min], [$30$min], [$17.5$h],
    [AlphaDev-S], [$0.4$s], best[$0.6$s], [$5.75$h]
  )

  - All solutions for $n=3$: $10$min
  - Optimality for $n=4$: $2$weeks
]

#slide[
  #toolbox.pdfpc.speaker-note("MinMax Synth time 32s for 5")
  = Evaluation Kernels #only("2-")[MinMax]

  #table(
    columns: 4,
    stroke: tableStroke,
    table.header(
      [Kernel], 
      [$n=3$], 
      [$n=4$], 
      [$n=5$]
    ),
    underline[Enumeration], best[$5.8$ms], [$9.4$ms], best[$14.8$ms],
    [Mimicry#footnote(text()[Mimicry. 2023. Faster Sorting Beyond DeepMind’s AlphaDev. https://www.mimicry.ai/faster-sorting-beyond-deepminds-alphadev Accessed: 2023-09-20])], [$8.0$ms], best[$8.8$ms], [---],
    [AlphaDev], [$6.7$ms], [$10.4$ms], [$16.2$ms],
    [Sorting Network (Cmp)], [$7.1$ms], [$14.8$ms], [$19.4$ms],
    uncover("2-")[#underline[MinMax]], 
    uncover("2-")[#highlight(fill:green.lighten(60%))[4.6ms]], 
    uncover("2-")[#highlight(fill:green.lighten(60%))[7.0ms]], 
    uncover("2-")[#highlight(fill:green.lighten(60%))[10.7ms]], 

    uncover("2-")[Sorting Network],
    uncover("2-")[$5.3$ms],
    uncover("2-")[$8.1$ms],
    uncover("2-")[$12.2$ms],

  )
  #uncover("2-")[
  #place(
    right,
    dx:-0cm,
    dy:-5cm,
    text(size: 20pt)[```
movdqa %xmm1, %xmm3
pminud %xmm2, %xmm1
pmaxud %xmm3, %xmm2
movdqa %xmm0, %xmm3
pminud %xmm2, %xmm3
pmaxud %xmm0, %xmm2
pminud %xmm1, %xmm0
pmaxud %xmm3, %xmm1
    ```]
  )]
  
]