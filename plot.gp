tags   = 'youtube blog comic emacs myself'
width  = 1200
height = 800
color  = '#aa00bb'

set terminal pngcairo size width, height
set datafile separator ','
set style fill solid noborder
set linetype 1 lc rgb color
set boxwidth 0.75

set xtics 0, 1, 23
do for [i = 1:words(tags)] {
  tag = word(tags, i)
  infile = sprintf('< grep ^%s transient/hours.csv', tag)
  outfile = sprintf('graphs/hours-%s.png', tag)
  set output outfile
  plot infile using 2:3 with boxes title tag
}

set xtics 0, 1, 6
set xtics add ("Sun" 0, "Mon" 1, "Tue" 2, "Wed" 3, "Thu" 4, "Fri" 5, "Sat" 6)
do for [i = 1:words(tags)] {
  tag = word(tags, i)
  infile = sprintf('< grep ^%s transient/weekdays.csv', tag)
  outfile = sprintf('graphs/weekdays-%s.png', tag)
  set output outfile
  plot infile using 2:3 with boxes title tag
}

set xtics 1, 1, 12
set xtics add ("Jan" 1, "Feb" 2, "Mar" 3, "Apr" 4,  "May"  5, "Jun"  6, \
               "Jul" 7, "Aug" 8, "Sep" 9, "Oct" 10, "Nov" 11, "Dec" 12)
do for [i = 1:words(tags)] {
  tag = word(tags, i)
  infile = sprintf('< grep ^%s transient/months.csv', tag)
  outfile = sprintf('graphs/months-%s.png', tag)
  set output outfile
  plot infile using 2:3 with boxes title tag
}

set boxwidth 1
set xtics 0, 10, 100
set xrange [0:100]
do for [i = 1:words(tags)] {
  tag = word(tags, i)
  infile = sprintf('< grep ^%s transient/lengths-by-tag.csv', tag)
  outfile = sprintf('graphs/lengths-%s.png', tag)
  set output outfile
  plot infile using 2:3 with boxes title tag
}

unset key
set style fill transparent solid 0.25 noborder
set style circle radius 0.04
set xrange [0:24]
set xtic 0, 1, 23
set yrange [0:100]
set output 'graphs/length-vs-daytime.png'
set terminal pngcairo size width, height * 2 / 3
plot 'transient/length-vs-daytime.csv' using 1:2 with circles
