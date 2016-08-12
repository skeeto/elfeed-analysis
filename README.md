# Elfeed Database Analysis

Generate a small analysis of your Elfeed repository:

1. Edit your tag selection at the top of `plot.gp`. Change other
   options as desired.

2. Run `make`. The results will be `graphs/`.

This will automatically run an Emacs instance to dump your Elfeed
database as CSV tables. If this isn't correct, or if the Makefile
invokes Emacs incorrectly, do this step manually instead:

~~~cl
(require 'elfeed-csv)
(elfeed-csv-export "feeds.csv" "entries.csv" "tags.csv")
~~~

Then put these three files under the `data/` directory in this
repository. This directory is only removed by the `distclean` target.

## Dependencies

* [Elfeed](https://github.com/skeeto/elfeed) with an established database
* [SQLite](https://sqlite.org/) command shell (`sqlite3`)
* [gnuplot](http://gnuplot.info/) (version 5.0 or higher works best)
