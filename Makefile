EMACS   = emacs
SQLITE  = sqlite3
GNUPLOT = gnuplot

all : graphs

## Can't use -batch: must leverage user's Elfeed configuration.
data :
	@mkdir -p data
	$(EMACS) -nw -l export.el

transient : process.sql data
	@rm -rf $@
	@mkdir -p $@
	$(SQLITE) :memory: < $<

graphs : transient plot.gp
	@rm -rf $@
	@mkdir -p $@
	$(GNUPLOT) plot.gp

.PHONY : clean

clean :
	rm -rf transient graphs

distclean :
	rm -rf data transient graphs
