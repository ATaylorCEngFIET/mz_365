#include "systemc.h"
#ifndef sim_clk_gen_H
#define sim_clk_gen_H
#include "xtlm.h"
#include <iostream>
#include <string>
class sim_clk_gen:public sc_module {
public:
	sim_clk_gen(sc_core::sc_module_name name,
			xsc::common_cpp::properties model_param_props);
        SC_HAS_PROCESS(sim_clk_gen);
	sc_core::sc_out<bool> clk_p;
	sc_core::sc_out<bool> clk;
	sc_core::sc_out<bool> clk_n;
	sc_core::sc_out< bool > sync_rst;
	sc_core::sc_signal<bool> out;
	sc_core::sc_signal<bool> out2;
	std::string clktype;
	void generateClk();
	void updateReset();
	float clock_period;
	long initial_reset_clk_cycles;
	long reset_polarity;
	
};
#endif
