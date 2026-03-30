// Simple 4-bit up-counter with enable and synchronous reset
module counter #(
    parameter WIDTH = 4
) (
    input  logic             clk,
    input  logic             rst_n,   // active-low synchronous reset
    input  logic             en,
    output logic [WIDTH-1:0] count
);

    always_ff @(posedge clk) begin
        if (!rst_n)
            count <= '0;
        else if (en)
            count <= count + 1'b1;
    end

    // ---------------------------------------------------------------
    // SVA properties
    // ---------------------------------------------------------------

    // After reset deasserts, count must be 0 the next cycle
    property p_reset_clears_count;
        @(posedge clk) $fell(rst_n) |=> (count == '0);
    endproperty

    // When enable is low, count must not change
    property p_hold_when_disabled;
        @(posedge clk) disable iff (!rst_n)
            !en |=> $stable(count);
    endproperty

    // Count must never exceed MAX (wrap-around is expected, but let's
    // verify the simple no-overflow case when WIDTH == 4 and en is
    // constrained to stop at 15 — useful for FPV bounded proofs)
    property p_count_increments;
        @(posedge clk) disable iff (!rst_n)
            (en && count != '1) |=> (count == $past(count) + 1'b1);
    endproperty

    RST_CLEARS:   assert property (p_reset_clears_count)
        else $error("FAIL: reset did not clear count");

    HOLD_STABLE:  assert property (p_hold_when_disabled)
        else $error("FAIL: count changed while enable was low");

    COUNT_INCR:   assert property (p_count_increments)
        else $error("FAIL: count did not increment correctly");

    // Cover: counter reaches max value
    COV_MAX: cover property (
        @(posedge clk) disable iff (!rst_n) count == '1
    );

endmodule
