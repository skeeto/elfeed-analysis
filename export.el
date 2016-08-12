(require 'elfeed-csv)
(elfeed-csv-export "data/feeds.csv" "data/entries.csv" "data/tags.csv")
(kill-emacs)
