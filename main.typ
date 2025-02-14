// #import "@preview/polylux:0.4.0": *
// // #import "@preview/friendly-polylux:0.1.0" as friendly
// #import "lib.typ" as friendly
// #import "@preview/cetz:0.3.1"
// #import "@preview/cetz-plot:0.1.0": plot, chart
// #import friendly: titled-block


#import "common.typ" : *

#show: friendly.setup.with(
  short-title: "Synthesis of Sorting Kernels",
  short-speaker: "Marcel Ullrich, Sebastian Hack",
)

// #set text(size: 30pt, font: "Andika")
// #show raw: set text(font: "Fantasque Sans Mono")
// #show math.equation: set text(font: "Lete Sans Math")

#set text(size: 30pt)

#friendly.title-slide(
  title: [Synthesis of Sorting Kernels],
  speaker: [
    #underline[Marcel Ullrich], Sebastian Hack #linebreak() 
    #text(size: 20pt)[Saarland University, Saarland Informatics Campus]
  ],
  conference: [03.03.2025, CGO 2025],
  // speaker-website: "url-to-the-speaker.org", // use `none` to disable
  // slides-url: none, // use `none` to disable
  // qr-caption: text(font: "Excalifont")[Get these slides],
  // logo: image("uni_logo.png", width: 2cm, height: 2cm)
  logo: place(
    bottom+center,
    dx: 2.07cm,
    box(
      clip: true,
      width: 7cm,
      align(left,
        image("imgs/owl.png", width: 12cm, height: 12cm)
      )
    )
  ),

)

// #slide[
//   = My first slide
//   With some maths: $x^2 + y^2 = z^2$

//   And some code: `Typst *rocks*!`

//   #titled-block(title: [A block])[
//     Some important content
//   ]

//   #uncover(2)[
//     Animation
//   ]
// ]


/*

Goal (Section 2)

Our Approach (Section 3)

Comparison (Section 4)
-> what learned

Results of Kernels (Section 5)

*/

#slide[
  #toolbox.pdfpc.speaker-note("Timsort, Introsort")
  = Sorting Kernels
  /*
  mergesort/quicksort

  sorting network
  code lowering
  */

  // timsort, introsort => quick/merge/heap then insert
  #toolbox.side-by-side[
  #context cetz.canvas({
    import cetz.plot
    import cetz.draw: *

    let blue = rgb("#99adcc")
    let numbers = (5,6,1,3,4,9,7,13,2,8,11,10,12)

    // mergesort
    for x in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10) {
      rect((x, 0), (x+1,1), fill: blue)
      // text((x+0.5, 0.5), str(numbers.at(x - 1)), anchor: "middle")
      content(
        (x+0.5, 0.5),
        text(str(numbers.at(x - 1))), 
      )
    }
    for x in (1, 2, 3, 4, 5) {
      rect((x - 1, -1), (x+1-1,-2), fill: blue)
      rect((x + 6, -1), (x+1+6,-2), fill: blue)
      
      content(
        (x - 0.5, -1.5),
        text(str(numbers.at(x - 1))), 
      )
      content(
        (x - 0.5+7, -1.5),
        text(str(numbers.at(x + 5 - 1))), 
      )
    }
    line((1,0), (0,-1), stroke: (dash: "dashed"))
    line((6,0), (5,-1), stroke: (dash: "dashed"))
    line((6,0), (7,-1), stroke: (dash: "dashed"))
    line((11,0), (7+5,-1), stroke: (dash: "dashed"))
    for x in (1, 2, 3) {
      rect((x - 2, -3), (x+1-2,-4), fill: blue)
      rect((x + 5, -3), (x+1+5,-4), fill: blue)

      content(
        (x - 1.5, -3.5),
        text(str(numbers.at(x - 1))), 
      )
      content(
        (x + 5.5, -3.5),
        text(str(numbers.at(x +5 - 1))), 
      )
    }
    for x in (1, 2) {
      rect((x + 2, -3), (x+1+2,-4), fill: blue)
      rect((x + 9, -3), (x+1+9,-4), fill: blue)

      content(
        (x + 2.5, -3.5),
        text(str(numbers.at(x +3 - 1))), 
      )
      content(
        (x + 9.5, -3.5),
        text(str(numbers.at(x +8 - 1))), 
      )
    }
    line((0,-2), (-1,-3), stroke: (dash: "dashed"))
    line((3,-2), (2,-3), stroke: (dash: "dashed"))
    line((3,-2), (3,-3), stroke: (dash: "dashed"))
    line((5,-2), (5,-3), stroke: (dash: "dashed"))
    line((7,-2), (6,-3), stroke: (dash: "dashed"))
    line((10,-2), (9,-3), stroke: (dash: "dashed"))
    line((10,-2), (10,-3), stroke: (dash: "dashed"))
    line((12,-2), (12,-3), stroke: (dash: "dashed"))

  // })

  // #uncover("2-")[
  // #cetz.canvas({
  //   import cetz.plot
  //   import cetz.draw: *

  set-viewport(
    (0,-9), (1,-8)
  )
  let blue = rgb("E8C872")

  if (logic.subslide.at(here()).first() > 1) {
    for x in (1, 2, 3) {
      rect((x - 2, 3), (x+1-2,4), fill: blue)
      rect((x + 5, 3), (x+1+5,4), fill: blue)

      content(
        (x - 1.5, 3.5),
        text(str((1,6,5).at(x - 1))), 
      )
      content(
        (x + 5.5, 3.5),
        text(str((7,9,13).at(x -1))), 
      )
    }
    for x in (1, 2) {
      rect((x + 2, 3), (x+1+2,4), fill: blue)
      rect((x + 9, 3), (x+1+9,4), fill: blue)

      content(
        (x + 2.5, 3.5),
        text(str((3,4).at(x - 1))), 
      )
      content(
        (x + 9.5, 3.5),
        text(str((2,8).at(x - 1))), 
      )
    }

    line((0.5,5), (0.5,4), stroke: (thickness: 5pt), mark: (end: ">"))
    line((4,5), (4,4), stroke: (thickness: 5pt), mark: (end: ">"))
    line((7.5,5), (7.5,4), stroke: (thickness: 5pt), mark: (end: ">"))
    line((11,5), (11,4), stroke: (thickness: 5pt), mark: (end: ">"))

  }
  if (logic.subslide.at(here()).first() > 2) {
    // mergesort
    for x in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10) {
      rect((x, 0), (x+1,-1), fill: blue)
      // text((x+0.5, 0.5), str(numbers.at(x - 1)), anchor: "middle")
      content(
        (x+0.5, -0.5),
        text(str((1,2,3,4,5,6,7,8,9,13).at(x - 1))), 
      )
    }
    for x in (1, 2, 3, 4, 5) {
      rect((x - 1, 1), (x+1-1,2), fill: blue)
      rect((x + 6, 1), (x+1+6,2), fill: blue)
      
      content(
        (x - 0.5, 1.5),
        text(str((1,3,4,5,6).at(x - 1))), 
      )
      content(
        (x - 0.5+7, 1.5),
        text(str((2,7,8,9,13).at(x - 1))), 
      )
    }
    line((1,0), (0,1), stroke: (dash: "dashed"))
    line((6,0), (5,1), stroke: (dash: "dashed"))
    line((6,0), (7,1), stroke: (dash: "dashed"))
    line((11,0), (7+5,1), stroke: (dash: "dashed"))
    
    line((0,2), (-1,3), stroke: (dash: "dashed"))
    line((3,2), (2,3), stroke: (dash: "dashed"))
    line((3,2), (3,3), stroke: (dash: "dashed"))
    line((5,2), (5,3), stroke: (dash: "dashed"))
    line((7,2), (6,3), stroke: (dash: "dashed"))
    line((10,2), (9,3), stroke: (dash: "dashed"))
    line((10,2), (10,3), stroke: (dash: "dashed"))
    line((12,2), (12,3), stroke: (dash: "dashed"))
  
  }

  })
  // ]
  ][
    #uncover("4-")[
    #cetz.canvas({
      import cetz.plot
      import cetz.draw: *

      line((0,4), (9,4), name: "line2")
      line((0,2), (9,2), name: "line1")
      line((0,0), (9,0), name: "line0")

      content(
        "line2.start",
        text(size:17pt)[a[2]=7],
        anchor: "east",
        padding: 0.2cm
      )
      content(
        "line1.start",
        text(size:17pt)[a[1]=8],
        anchor: "east",
        padding: 0.2cm
      )
      content(
        "line0.start",
        text(size:17pt)[a[0]=9],
        anchor: "east",
        padding: 0.2cm
      )

      circle((2,0), radius: 0.2, fill: black, name: "c1_b")
      circle((2,2), radius: 0.2, fill: black, name: "c1_t")
      line("c1_b", "c1_t", name: "l1")
      circle((4,0), radius: 0.2, fill: black, name: "c2_b")
      circle((4,4), radius: 0.2, fill: black, name: "c2_t")
      line("c2_b", "c2_t", name: "l2")
      circle((6,2), radius: 0.2, fill: black, name: "c3_b")
      circle((6,4), radius: 0.2, fill: black, name: "c3_t")
      line("c3_b", "c3_t", name: "l3")

      content(
        "c1_b.north-east",
        text(size:17pt)[8],
        anchor: "south-west",
        padding: 0.1cm
      )
      content(
        "c1_t.north-east",
        text(size:17pt)[9],
        anchor: "south-west",
        padding: 0.1cm
      )
      content(
        "c2_b.north-east",
        text(size:17pt)[7],
        anchor: "south-west",
        padding: 0.1cm
      )
      content(
        "c2_t.north-east",
        text(size:17pt)[8],
        anchor: "south-west",
        padding: 0.1cm
      )
      content(
        "c3_b.north-east",
        text(size:17pt)[8],
        anchor: "south-west",
        padding: 0.1cm
      )
      content(
        "c3_t.north-east",
        text(size:17pt)[9],
        anchor: "south-west",
        padding: 0.1cm
      )
    })]

    #uncover("5-")[
      // #align(center)[
      ```nasm
      mov rdi, rax
      cmp rbx, rax
      cmovl rax, rbx
      cmovl rbx, rdi
      ```
      // ]
    ]

  ]
]


#slide[
  #toolbox.pdfpc.speaker-note("all kernels -> faster, minimal")
  = State of the Art
  /*
  handoptimized
  hard problem (present later)

  AlphaDev finds code

  we find 
  - faster
  - all -> faster kernel
  - minimal
  */

  #toolbox.side-by-side()[
    - #only("1")[sorting network #icon("icons/snail-svgrepo-com.svg")] #only("2-")[handoptimized #icon("icons/bug-color-svgrepo-com.svg")]
    #show: later
    #show: later
    - #only("-3")[2024 AlphaDev#footnote(text(size:15pt)[Mankowitz, Daniel J., et al. "Faster sorting algorithms discovered using deep reinforcement learning." Nature 618.7964 (2023): 257-263.])]
      - $n=3$: #only("-3")[6min ] #only("4-")[#strike[6min] $97$ms]
      - $n=4$: #only("-3")[30min] #only("4-")[#strike[30min] $2.4$s]
      - $n=5$: #only("-3")[17.5h] #only("4-")[#strike[17.5h] $11$min]
  ][
    #item-by-item(start:4)[
      / #icon("icons/speed-svgrepo-com.svg"): faster synthesis
      / #icon("icons/speedometer-svgrepo-com.svg"): faster sorting kernels
      / #icon("icons/minimize-square-minimalistic-svgrepo-com.svg"): minimality proof
    ]
  ]
]

#slide[
  #alternatives(repeat-last: true)[
    = Model
  ][
    = Search Space
    // = Enumerative Synthesis
  ]

  /*



  */


  #toolbox.side-by-side()[

  #cetz.canvas({
    import cetz.plot
    import cetz.decorations: *
    import cetz.draw: *

    let bg = rgb("#99adcc")
    let bg2 = rgb("#a6d1e3")
    let bg3 = rgb("#9ea6aa")

    let registers = (
      ("2","1","-", "-", "-"),
      ("2","1","1", "-", "-"),
      ("2","1","1", "-", ">"),
      ("2","2","1", "-", ">"),
      ("1","2","1", "-", ">"),
    )
    let instruction = (
      `mov s1 r2`,
      `cmp r1 r2`,
      `cmovg r2 r1`,
      `cmovg r1 s1`,
      ""
    )

    for y in (0, 1, 2, 3, 4) {
      for x in (0, 1, 2, 3, 4) {
        rect((x, -y), (x+1,-y - 1), fill: (bg,bg,bg2,bg3,bg3).at(x),name: "r"+str(y)+"c"+str(x))
      }
      content("r"+str(y)+"c0.west", anchor: "east", instruction.at(y), padding:0.5cm)
    }
    content("r0c2.north",anchor: "south", text(15pt)[swap])
    content("r0c3.north",anchor: "south", text(20pt)[lt], padding: 0.3cm)
    content("r0c4.north",anchor: "south", text(20pt)[gt], padding: 0.1cm)

    line("r0c1.center", "r1c2.center", stroke: (dash: "dashed", paint:white),mark: (end: ">"))
    line("r1c0.center", "r1c1.center", stroke: (dash: "dashed", paint:white))
    line("r2c0.center", "r3c1.center", stroke: (dash: "dashed", paint:white),mark: (end: ">"))
    line("r3c2.center", "r4c0.center", stroke: (dash: "dashed", paint:white),mark: (end: ">"))

    for y in (0, 1, 2, 3, 4) {
      for x in (0, 1, 2, 3, 4) {
        content(
          (x+0.5, -y - 0.5),
          text(registers.at(y).at(x)),
        )
      }
    }


    // brace over the last two boxes
    flat-brace((0, 0), (2, 0), name: "brace1")
    content("brace1.center", text(15pt)[register], anchor: "south", padding: 0.2cm)


  })

  #only("2-3")[
    `min(a,min(b,c) = min(min(max(c,b),a),min(b,c))`
  ]

  #uncover("4-")[
    #align(center)[
      #place(
        bottom+center,
        dy: 3.0cm,
        box[
      #image("imgs/solutions_cut_all_commands_no_early__scattered_a70_p50_i3000_scaled.svg", height: 5cm)
      #place(
        bottom+center,
        dy: 0.5cm,
        text(15pt)[TSNE-embedding of solutions]
      )
      ]
      )
  ]]

  ][

  // | $n$ | Program Length | Search Space |
  // | --- | --------------- | ------------ |
  // | 3   | 3               | 5            |
  #uncover("3-")[
  #table(
    columns: (auto,auto,auto),
    table.header(
      [$n$], [Program Length], [Search Space]
    ),

    $3$, $11$, $10^19.9$,
    $4$, $20$, $10^40$,
    $5$, $approx 33$, $10^71.2$,
    $6$, $approx 45$, $10^108.4$

  )
  
  $5602$ solutions for $n=3$
  ]
  // $n=3$ has $5602$ solutions
  
  
  
  ]
]


  // alternatives-cases(("1"), case => [
  //   #set highlight() if case == 1
  //   #content
  // ]))


#slide[
    = Enumerative Synthesis


  #cetz.canvas(
  {
    import cetz.plot
    import cetz.decorations: *
    import cetz.draw: *

    // cetz.draw.set-style(scale: 0.2)
    cetz.draw.set-viewport(
      (0,0), (0.5,0.5),
      // bounds: (100,100)
    )

  // set-style(
  //   // mark: (fill: black, scale: 2),
  //   // stroke: (thickness: 0.4pt, cap: "round"),
  //   // angle: (
  //   //   radius: 0.3,
  //   //   label-radius: .22,
  //   //   fill: green.lighten(80%),
  //   //   stroke: (paint: green.darken(50%))
  //   // ),
  //   content: (padding: 5pt)
  // )

    let blue = rgb("#739ede")
    // let yellow = rgb("#e8c872")
    let yellow = rgb("#e8cb72")
    let red = rgb("#e87272")

    let group(name,x,y,xs) = (
      for (i,c) in xs.enumerate() {
        rect((x+i, y), (x+i+1,y+1), fill: c, name: name+"_"+str(i))
        // content((x+i+0.5, y+0.5), name: name+"_"+str(i),
        
        // )
      }
    )

    let mid = (3*3+2)/2

    let x = 0
    let y = 0
    group("c0_0_a",x+0,y, (blue,yellow,red))
    group("c0_0_b",x+4,y, (yellow,blue,red))
    group("c0_0_c",x+8,y, (yellow,red,blue))

    let x = -15
    let y = -6
    group("c1_0_a",x+0,y, (blue,yellow,red))
    group("c1_0_b",x+4,y, (yellow,yellow,red))
    group("c1_0_c",x+8,y, (yellow,yellow,blue))
    content(
      (x+mid,y - 2),
      image("icons/cross-mark-svgrepo-com.svg", width: 1em)
    )
    // line(
    //   (mid,0),(x+mid,-2),
    //   mark: (end: ">"),
    // )
    // 
    // let from = (mid,0)
    // let to = (x+mid,-2)
    // let from = "c0_0_b_1"
    // let to = "c1_0_b_1"
    // line(
    //   "c0_0_b_1.south",
    //   "c1_0_b_1.north",
    //   // mark: (end: ">",length:1.0cm),
    //   mark: (end: ">", scale:3, fill:black),
    //   stroke: (thickness: 2pt),
    // )
    // line((a: from, number: .6, b: to),
    //      (a: to, number: .6, b: from), mark: (end: ">"))

    let x = 0
    let y = -6
    group("c1_1_a",x+0,y, (yellow,blue,red))
    group("c1_1_b",x+4,y, (blue,yellow,red))
    group("c1_1_c",x+8,y, (red,yellow,blue))

    let x = 15
    let y = -6
    group("c1_2_a",x+0, y, (blue,yellow,red))
    group("c1_2_b",x+4, y, (yellow,blue,red))
    group("c1_2_c",x+8, y, (yellow,blue,red))

    let x = 15
    let y = -12
    group("c2_0_a",x+0, y, (yellow,blue,red))
    group("c2_0_b",x+4, y, (yellow,blue,red))
    group("c2_0_c",x+8, y, (yellow,blue,red))
    content(
      (x+mid,y - 2),
      image("icons/check-mark-button-svgrepo-com.svg", width: 1em)
    )


    line(
      "c0_0_b_1.south",
      "c1_0_b_1.north",
      mark: (end: ">", scale:3, fill:black),
      stroke: (thickness: 2pt),
    )
    line(
      "c0_0_b_1.south",
      "c1_1_b_1.north",
      mark: (end: ">", scale:3, fill:black),
      stroke: (thickness: 2pt),
    )
    line(
      "c0_0_b_1.south",
      "c1_2_b_1.north",
      mark: (end: ">", scale:3, fill:black),
      stroke: (thickness: 2pt),
    )
    line(
      "c1_2_b_1.south",
      "c2_0_b_1.north",
      mark: (end: ">", scale:3, fill:black),
      stroke: (thickness: 2pt),
    )

  })


]


#slide[
    = Enumerative Synthesis

    /*

    General idea:
    trace partitions, dedup

    show tree red, blue, yellow


    Alg Steps

    then details


    show cut effect

    */

    // #alternatives-match((
    //   "1": highlight("Select open state"),
    //   "2-": "Select open state",
    // ))
    //

    #toolbox.side-by-side[
    1. #icon("icons/eye-show-svgrepo-com.svg") #limelight("1","2-","Select open state") \
    2. #icon("icons/transform-02-svgrepo-com.svg") #limelight("2","1,3-")[Apply Instruction] \
    3. #icon("icons/search-look-inspect-magnifying-glass-svgrepo-com.svg") #limelight("3","1-2,4-")[Check for viability] \
    4. #icon("icons/check-read-svgrepo-com.svg") #limelight("4","1-3,5-")[Check for solution] \
    5. #icon("icons/cut-svgrepo-com.svg") #limelight("5","1-4,6-")[Cut non-promising] \
    6. #icon("icons/duplicate-svgrepo-com.svg") #limelight("6","1-5")[Deduplicate states]
    ][
      
      #alternatives()[
        // select open
        A$star$ with heuristics:
        - permutations
        - #highlight(fill:green.lighten(60%))[permutations + \ scratch register]
        - delete-relaxed \ 
          (maximum per permutation)
      ][
        // apply instruction
        Remove redundant/non-sensical:
        - `cmp r1 r2;cmp r1 r3`
        - #highlight(fill:green.lighten(60%))[`cmp r1 r1`]
        Restrict to beneficial:
        - #highlight(fill:green.lighten(60%))[delete-relaxed]
        - #highlight(fill:green.lighten(60%))[`cmp r2 r1` → `cmp r1 r2`]
      ][
        // check for viability
        Cut programs:
        - #highlight(fill:green.lighten(60%))[number eliminated]
        - #highlight(fill:green.lighten(60%))[longer than bound/solution]
        - #highlight(fill:green.lighten(60%))[can not be completed in time]
      ][
        // check for solution
        #highlight(fill:green.lighten(60%))[All permutations already sorted]
      ][
        // cut non-promising
        #highlight(fill:green.lighten(60%))[Cut if \ permutation count > k × best]

        #table(
          columns: 2,
          stroke: tableStroke,
          table.header(
            [Cut], [Solutions]
          ),
          [$k=1$], [222],
          [$k=1.5$], [838],
          [$k=2$], [5602],
          [$k=infinity $], [5602]
        )
      ][
        // deduplicate states
        #highlight(fill:green.lighten(60%))[Hashset-based deduplication \ of states]
      ]
    ]


]

#slide[

  #toolbox.pdfpc.speaker-note("only rearrange elements and copy")

  = Solver-Based Techniques
  // (correctness Section 2)

  #align(center)[
  #alternatives(repeat-last: false)[
    $
    forall r: P(r) = o -> \
    underbrace((forall 1 <= i <= |r|: o_i <= o_(i+1)), "ascending") and \
    underbrace((forall x: |{i: r_i = x}| = |{i: o_i = x}|), "same elements")
    $
  ][
    $
      r in "Perm"(1..n)
    $
    $
    forall r: P(r) = o -> 
    forall 1 <= i <= r: o_i = i
    $
  ][
    $
      and.big_(r in "Perm"(1..n)) and.big_(1 <= i <= n) P(r)_i = i
    $
  ]
  ]
]

  // - Encode Instructions
  // - Encode Goal
  // SMT, ILP, CP
  
#slide[
  = Solver-Based Techniques
    $
      and.big_(r in "Perm"(1..n)) and.big_(1 <= i <= n) P(r)_i = i
    $
  Heuristics:
  - `cmp r1 r2; cmp r2 r3` $->$ `cmp r2 r3`
  - `cmp r1 r1` $->$ `noop`
  - `cmp r3 r2` $->$ `cmp r2 r3`
  - only read initialized
  - do not make uncompleteable
  
  // different goal encodings

  // heuristics
]

#slide[
  #toolbox.pdfpc.speaker-note("timeout 5h, for 4: 1week")
  = Solver-Based Synthesis

  #set text(size: 25pt)

  #layout(size =>
  grid(
    columns: (50%,50%),
    // rows: (40%*size.height,40%*size.height),
    rows: (40%*size.height,auto),
    stroke: (x,y) =>
      if(x == 0 and y == 0) {
        (right: 0.7pt + black, bottom: 0.7pt + black)
      } else if x == 0 {
        (right: 0.7pt + black)
      } else {
      }
    ,
    pad(10pt)[
      #table(
        columns: 2,
        stroke: tableStroke,
        table.header(
          [SMT], [Approach]
        ),
        [$97$min], [CEGIS, arbitrary inputs],
        [$25$min], [CEGIS, 1..n],
        [$44$min], [all permutations],
        [---], [SyGuS (CVC5, Metalift)]
      )
    ],
    grid.cell(rowspan: 2,
    pad(10pt)[
      // #set text(size: 18pt)
      #uncover("2-")[
      #table(
        columns: 2,
        stroke: tableStroke,
        table.header(
          [CP], [Approach]
        ),
        [---], [ILP, MIP],
        [---], [CP (MiniZinc other)],
        [$232$s], [chuffed, no heuristic],
        [$70$s], [chuffed, h, $=1..n$],
        [$30$s], [chuffed, h, $<=$,$#1..3$],
        [$0.9$s], [+init],
      )
      ]
    ]),
    pad(10pt)[
      #uncover("3-")[
      #table(
        columns: 2,
        stroke: tableStroke,
        table.header(
          [Planning], [Approach]
        ),
        [$679$s], [Scorpion planner],
        [$216$s], [Lama planner grounded],
        [$3.54$s], [Lama Planner],
      )
      ]
    ],
    pad(10pt)[
      // #uncover("4-")[
      // #table(
      //   columns: 2,
      //   stroke: tableStroke,
      //   table.header(
      //     [Time], [Approach]
      //   ),
      // )
      // ]
    ]
  ))

  // CEGIS (full loop vs directly)
  // SyGus (metalift)

  // Table


  // CP 
  // ILP ->  (problem with cmovl)
  // MiniZinc

  // Table


  // Planning

  // Table
]

#include "eval.typ"


#friendly.last-slide(
  title: [Conclusion],
  project-url: "https://github.com/NeuralCoder3/cgo25_artifact",
  // font: "Excalifont"
  qr-caption: text()[Project on GitHub],
  // contact-appeal: [Get in touch #emoji.hand.wave],
  contact-appeal: none,
  // leave out any of the following if they don't apply to you:
  email: "ullrich@cs.uni-saarland.de",
  // mastodon: "@foo@baz.org",
  // website: "bar.org"
)[
      / #icon("icons/speed-svgrepo-com.svg"): faster synthesis
      / #icon("icons/speedometer-svgrepo-com.svg"): faster sorting kernels
      / #icon("icons/minimize-square-minimalistic-svgrepo-com.svg"): minimality proof
]
