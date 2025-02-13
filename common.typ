#import "@preview/polylux:0.4.0": *
// #import "@preview/friendly-polylux:0.1.0" as friendly
#import "lib.typ" as friendly
#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0": plot, chart
#import friendly: titled-block


#let tableStroke(x,y) = (
  if (x == 0 and y == 0) {
    (right: 0.7pt + black, bottom: 0.7pt + black)
  }else if y == 0 {
    (bottom: 0.7pt + black)
  } else if x==0 {
    (right: 0.7pt + black)
  } else {
  }
)

#let limelight(slide1,slide2,content) = [#alternatives-match((
  (slide1, highlight(content)),
  (slide2, content)
))
]

#let icon(file) = box(image(file, width: 1em))

#let best(content) = table.cell(fill: green.lighten(60%),content)