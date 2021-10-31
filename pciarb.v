module pci_arbiter (clk,reset_n,REQ0,REQ1,REQ2,REQ3,GNT0,GNT1,GNT2,GNT3) ;

    input clk ;
    input reset_n ;
    input REQ0 ;
    input REQ1 ;
    input REQ2 ;
    input REQ3 ;
    output GNT0 ;
    output GNT1 ;
    output GNT2 ;
    output GNT3 ;
    reg GNT0 ;
    reg GNT1 ;
    reg GNT2 ;
    reg GNT3 ;
    reg [2:0] arbiter_state ;

    always @ (posedge clk or negedge reset_n)
    begin
        if (reset_n == 0)
            begin
                GNT0 <= 0 ;
                GNT1 <= 0 ;
                GNT2 <= 0 ;
                GNT3 <= 0 ;
                arbiter_state <= 0 ;
            end
        else
            case (arbiter_state)
                0: begin
                    GNT0 <= 0 ;
                    GNT1 <= 0 ;
                    GNT2 <= 0 ;
                    GNT3 <= 0 ;
                    if (REQ0 == 1)
                        arbiter_state <= 1 ;
                    else if (REQ1 == 1)
                        arbiter_state <= 2 ;
                    else if (REQ2 == 1)
                        arbiter_state <= 3 ;
                    else if (REQ3 == 1)
                        arbiter_state <= 4 ;
                    else
                        arbiter_state <= 0 ;
                end
                1: begin
                    GNT0 <= 1 ;
                    GNT1 <= 0 ;
                    GNT2 <= 0 ;
                    GNT3 <= 0 ;
                    if (REQ0 == 1)
                        arbiter_state <= 1 ;
                    else if (REQ1 == 1)
                        arbiter_state <= 2 ;
                    else if (REQ2 == 1)
                        arbiter_state <= 3 ;
                    else if (REQ3 == 1)
                        arbiter_state <= 4 ;
                    else
                        arbiter_state <= 1 ;
                end
                2: begin
                    GNT0 <= 0 ;
                    GNT1 <= 1 ;
                    GNT2 <= 0 ;
                    GNT3 <= 0 ;
                    if (REQ1 == 1)
                        arbiter_state <= 2 ;
                    else if (REQ2 == 1)
                        arbiter_state <= 3 ;
                    else if (REQ3 == 1)
                        arbiter_state <= 4 ;
                    else
                        arbiter_state <= 1 ;
                end
                3: begin
                    GNT0 <= 0 ;
                    GNT1 <= 0 ;
                    GNT2 <= 1 ;
                    GNT3 <= 0 ;
                    if (REQ2 == 1)
                        arbiter_state <= 3 ;
                    else if (REQ0 == 1)
                        arbiter_state <= 1 ;
                    else if (REQ1 == 1)
                        arbiter_state <= 2 ;
                    else if (REQ3 == 1)
                        arbiter_state <= 4 ;
                    else
                        arbiter_state <= 1 ;
                end
                4: begin
                    GNT0 <= 0 ;
                    GNT1 <= 0 ;
                    GNT2 <= 0 ;
                    GNT3 <= 1 ;
                    if (REQ3 == 1)
                        arbiter_state <= 4 ;
                    else
                        arbiter_state <= 1 ;
                end
                default: arbiter_state <= 0 ;
            endcase
    end
endmodule