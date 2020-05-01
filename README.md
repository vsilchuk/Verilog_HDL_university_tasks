## "Verilog HDL Basics" university course.

###### NTUU KPI, The Faculty of Electronics, The Department of Design of Electronic Digital Equipment (DEDEC/KEOA).

**Laboratory works materials for "Verilog HDL Basics" course. This course includes the following topics:**

1. LW1 — ModelSim basics — [Link][1].
2. LW2 — Combinational devices and Verilog features — [Link][2].
3. LW3 — Implementation of typical combinational devices — [Link][3].
4. LW4 — Sequential logic devices. Verilog operators — [Link][4].
5. LW5 — Verilog and arithmetic units — [Link][5].
6. LW6 — Finite state machines — [Link][6].
7. LW7 — Multifunctional devices — [Link][7].
8. LW8 — [Development of a simple processor module][8] — [Link][9].
9. Test 1.
10. Test 2.

Notice, that the [LW8][10] project **is not the same** with [this project][8]. [This][10] is a [“pure”][13] single-cycle MIPS processor, without the BAM module. There is also [another][11] [firmware][12] provided here, which is designed to check all the MIPS available instructions.

---

I used the **ModelSim** simulation environment to simulate the operation of the designed devices.
In my case, the simulation could be started by executing the `vsim -do sim.do` command using the terminal. You can also directly transfer the script to be executed by the simulator using the graphical interface of the program.

[1]: http://fpga.in.ua/fpga/cad-pld/verilog-basics-laboratory-works/lr1-znakomstvo-so-sredoj-modelirovaniya-modelsim.html
[2]: http://fpga.in.ua/fpga/cad-pld/verilog-basics-laboratory-works/lr2-issledovanie-kombinacionnyx-ustrojstv-osobennosti-yazyka-verilog.html
[3]: http://fpga.in.ua/fpga/cad-pld/verilog-basics-laboratory-works/lr3-realizaciya-tipovyx-kombinacionnyx-ustrojstv.html
[4]: http://fpga.in.ua/fpga/cad-pld/verilog-basics-laboratory-works/lr4-issledovanie-posledovatelnostnyx-logicheskix-ustrojstv-operatory-verilog.html
[5]: http://fpga.in.ua/fpga/cad-pld/verilog-basics-laboratory-works/lr5-yazyk-verilog-issledovanie-arifmeticheskix-ustrojstv.html
[6]: http://fpga.in.ua/fpga/cad-pld/verilog-basics-laboratory-works/lr6-issledovanie-konechnyx-avtomatov.html
[7]: http://fpga.in.ua/fpga/cad-pld/verilog-basics-laboratory-works/lr7-issledovanie-mnogofunkcionalnyx-ustrojstv.html
[8]: https://github.com/vsilchuk/Verilog_HDL_single_cycle_MIPS_processor/
[9]: http://fpga.in.ua/fpga/cad-pld/verilog-basics-laboratory-works/lr8-razrabotka-prostogo-processornogo-modulya-na-verilog.html
[10]: https://github.com/vsilchuk/Verilog_HDL_university_tasks/LW8/
[11]: https://github.com/vsilchuk/Verilog_HDL_university_tasks/LW8/blob/master/instr_test_pure_mips.asm
[12]: https://github.com/vsilchuk/Verilog_HDL_university_tasks/LW8/blob/master/instr_test_pure_mips.bin
[13]: https://github.com/vsilchuk/Verilog_HDL_single_cycle_MIPS_processor/blob/master/img/proc_structure_wb.png
