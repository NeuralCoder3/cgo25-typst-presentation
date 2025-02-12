#import "@preview/polylux:0.4.0": *
// #import "@preview/friendly-polylux:0.1.0" as friendly
#import "lib.typ" as friendly
#import friendly: titled-block

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
    dx: 2.1cm,
    box(
      clip: true,
      width: 7cm,
      align(left,
        image("owl.png", width: 12cm, height: 12cm)
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
  = Sorting Kernels
  /*
  mergesort/quicksort

  sorting network
  code lowering
  */
]

#slide[
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
]

#slide[
  = Enumerative Synthesis
]

#slide[
  = Solver-Based Techniques
]

#slide[
  = Evaluation
]

#friendly.last-slide(
  title: [Conclusion],
  project-url: "https://github.com/NeuralCoder3/cgo25_artifact",
  qr-caption: text(font: "Excalifont")[Project on GitHub],
  // contact-appeal: [Get in touch #emoji.hand.wave],
  contact-appeal: none,
  // leave out any of the following if they don't apply to you:
  email: "ullrich@cs.uni-saarland.de",
  // mastodon: "@foo@baz.org",
  // website: "bar.org"
)
