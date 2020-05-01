force reset 1 0ns, 0 10ns;
force clk 0 0ns, 1 {6ns} -repeat 10ns;
force data_a 10#0 0ns, 10#40 20ns, 10#80 40ns, 10#120 60ns, 10#160 80ns;
force data_b 10#177 0ns, 10#161 25ns, 10#145 50ns, 10#129 75ns;
run 150ns


