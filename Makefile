SQLITE = sqlite3
GNUPLOT = gnuplot5

all : graphs

transient : process.sql
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
