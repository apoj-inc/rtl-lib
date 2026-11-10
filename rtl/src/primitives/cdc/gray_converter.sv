module gray_converter #(
    parameter TO_GRAY    = 0 ,
    parameter DATA_WIDTH = 32
) (
    input  logic                  clk   ,
    input  logic                  rst_n ,

    input  logic [DATA_WIDTH-1:0] data_i,
    output logic [DATA_WIDTH-1:0] data_o
);

    logic [DATA_WIDTH-1:0] data_next;

    generate
        if (TO_GRAY) begin : to_gray
            assign data_next = data_i ^ (data_i >> 1);
        end
        else begin : to_bin
            genvar i;
            for (i = 0; i < DATA_WIDTH; i++) begin : to_bin_bits
                assign data_next[i] = ^(data_i >> i);
            end
        end
    endgenerate

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_o <= '0;
        end
        else begin
            data_o <= data_next;
        end
    end
    
endmodule