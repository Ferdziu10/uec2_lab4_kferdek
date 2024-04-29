`timescale 1 ns / 1 ps

module draw_rct (
    vga_if.in vii, 
    vga_if.out vio,
    input  logic [11:0] xpos,
    input  logic [11:0] ypos,
    input  logic clk,
    input  logic rst, 
    input  logic [11:0] rgb_pixel,
    output logic [11:0] pixel_addr

    );
    import vga_pkg::*;
 /* Local variables and signals
 */

 vga_if vga_nxt ();
 logic [11:0] pixel_addr_nxt;

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        vio.vcount <= '0;
        vio.vsync  <= '0;
        vio.vblnk  <= '0;
        vio.hcount <= '0;
        vio.hsync  <= '0;
        vio.hblnk  <= '0;
        vio.rgb    <= '0;
        pixel_addr <= '0;

    end else begin
        vio.vcount <= vii.vcount;
        vio.vsync  <= vii.vsync;
        vio.vblnk  <= vii.vblnk;
        vio.hcount <= vii.hcount;
        vio.hsync  <= vii.hsync;
        vio.hblnk  <= vii.hblnk;
        vio.rgb    <= vga_nxt.rgb;
        pixel_addr <= pixel_addr_nxt;
    end
end


always_comb begin
    pixel_addr_nxt = {6'(vii.vcount - ypos), 6'(vii.hcount - xpos)};
    if ( vii.hcount >= xpos + 2 && vii.hcount <= xpos + WID_RCT + 2  && vii.vcount >= ypos && vii.vcount <= ypos + HGH_RCT ) begin
    vga_nxt.rgb = rgb_pixel;

/*
    else if ( vcount_in >= X_RCTSTR && vcount_in <= X_RCTSTR + WID_RCT && hcount_in == Y_RCTSTR + HGH_RCT )
        rgb_nxt = COL_RCT;
    else if ( hcount_in >= Y_RCTSTR && hcount_in <= Y_RCTSTR + HGH_RCT && vcount_in == X_RCTSTR + WID_RCT )
        rgb_nxt = COL_RCT;
    else if ( hcount_in >= Y_RCTSTR && hcount_in <= Y_RCTSTR + HGH_RCT && vcount_in == X_RCTSTR )
        rgb_nxt = COL_RCT;
*/
    end else begin 
    vga_nxt.rgb = vii.rgb;
    end
end
endmodule