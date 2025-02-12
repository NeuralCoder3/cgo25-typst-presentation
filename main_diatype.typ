#import "@preview/diatypst:0.4.0": *


#show: slides.with(
  title: 
    text[
      Synthesis of Sorting Kernels
  ],
  subtitle: context(
    if (counter(page).get() == (1,)) {
      place(
        bottom+right,
        image("uni_logo.png", width: 2cm, height: 2cm)
      )
    } else {
      let heading = query(selector(heading).before(here())).last();
      heading.body
      align(
        right,
        place(
          bottom+right,
          dy: -.5cm,
          box[
            #image("uni_logo.png", width: 1cm, height: 1cm)
            #let slide_number = counter(page).get().at(0)-1;
            #place(center, 
              dy: -.5cm,
              text(
                white,
                stroke: 2.5pt+white,
                size: 2.0em,
                str(slide_number)
              )
            )
            #place(center, 
              dy: -.5cm,
              text(
                black,
                size: 2.0em,
                str(slide_number)
              )
            )
          ]
        )
      )
    }
  ),
  date: "03.03.2025",
  // authors: ("Marcel Ullrich", "Sebastian Hack"),
  authors: ("Marcel Ullrich and Sebastian Hack \n(Saarland University, Saarland Informatics Campus)"),

  // Optional Styling (for more / explanation see in the typst universe)
  ratio: 16/9,
  // footer-subtitle: text("Page 1"),
  layout: "medium",
  title-color: blue.darken(60%),
  toc: false,
  // theme: "full"
)

// image at the bottom right



// = First Section

// == First Slide

// #lorem(20)

// / *Term*: Definition

== Sorting Kernels

/*
mergesort/quicksort

sorting network
code lowering
*/

#lorem(20)

== State of the Art

/*
handoptimized
hard problem (present later)

AlphaDev finds code

we find 
- faster
- all -> faster kernel
- minimal

*/

#lorem(20)

== Enumerative Synthesis

#lorem(20)

== Solver Based Techniques

#lorem(20)

== Evaluation

#lorem(20)

== Conclusion

#lorem(20)


/*

Goal (Section 2)

Our Approach (Section 3)

Comparison (Section 4)
-> what learned

Results of Kernels (Section 5)


*/


// appendix

// == Backup Slides