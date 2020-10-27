#include "sim_clk_gen.h"

sim_clk_gen::sim_clk_gen(sc_core::sc_module_name name,xsc::common_cpp::properties model_param_props) :
	sc_module(name){
		reset_polarity =model_param_props.getLongLong("RESET_POLARITY");
		clock_period =model_param_props.getFloat("CLOCK_PERIOD");
		initial_reset_clk_cycles=model_param_props.getLongLong("INITIAL_RESET_CLOCK_CYCLES");
		clktype=model_param_props.getString("CLOCK_TYPE");
		if("Single_Ended"==clktype)
		{	
			clk.initialize(false);
			sync_rst.initialize((reset_polarity == 0) ? false :true);
			clk_p(out);
			clk_n(out2);
		}
		else
		{
			clk_n.initialize(true);
			clk_p.initialize(false);
			clk(out);
			sync_rst(out2);
		}
		SC_THREAD(generateClk);
		SC_THREAD(updateReset);	
	}
void sim_clk_gen::generateClk() {
	while (1) {
		wait(clock_period/2,SC_NS);
		clk.write(!clk.read());
		clk_p.write(!clk_p);
		clk_n.write(!clk_n);
	}
}

void sim_clk_gen::updateReset() {
	wait((clock_period*initial_reset_clk_cycles+clock_period/2),SC_NS);
	sync_rst.write((reset_polarity == 0) ? true :false);
}
