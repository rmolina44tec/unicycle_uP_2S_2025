`include "adder_tb.sv"

module top_tb #(parameter WIDTH = 32)();

    logic clk;
    int finish, error;

    adder_tb adder_tb #(.WIDTH(WIDTH))();

    initial begin
        clk = 0;

        finish = 0;
        error  = 0;

        fork
            adder_tb.adder_sim();
            end_sim_checker();
        join
    end
    
    always begin
        #10 clk = !clk;
    end

    task end_sim_checker();
        forever begin
            @(posedge clk);
            finish = adder_tb.finish;
            error  = adder_tb.error;
            if (finish == 1) begin
                if (error == 1) $display("[TOP TB] Test FAILED!!!");
                $display("[TOP TB] Simulation has ended.");
                $finish;
            end
        end
    endtask

endmodule