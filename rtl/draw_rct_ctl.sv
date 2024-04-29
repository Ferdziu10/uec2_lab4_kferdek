`timescale 1 ns / 1 ps

module draw_rct_ctl ( 
        input  logic [11:0] mouse_xpos,
        input  logic [11:0] mouse_ypos,
        input  logic clk,
        input  logic rst,
        input  logic mouse_left,
        input  logic mouse_right,
        output logic [11:0] xpos,
        output logic [11:0] ypos
        );

        logic [11:0] ypos_nxt;
        logic mouse_left_prv;
        logic left_nxt;
        logic [20:0] counter;
        logic [20:0] counter_nxt;
        logic [15:0] a;
        logic [15:0] a_nxt;
        logic [10:0] a_counter;
        logic [10:0] a_counter_nxt;
        logic [11:0] mouse_ypos_save;
        logic [11:0] mouse_ypos_save_nxt;
        logic bounce;
        logic bounce_nxt;
 
        always_ff @(posedge clk) begin 
            if (rst) begin
                xpos <= '0;
                ypos <= '0;
                mouse_left_prv <= '0;
                left_nxt <= '0;
                counter <= '0;
                a <= '0;
                a_counter <= '0;
                mouse_ypos_save <= '0;
                bounce <='0;
            end else begin
                mouse_left_prv <= mouse_left;
                xpos <= mouse_xpos;
                ypos <= ypos_nxt;
                mouse_ypos_save <= mouse_ypos_save_nxt;
                counter <= counter_nxt;
                a <= a_nxt;
                a_counter <= a_counter_nxt;
                bounce <= bounce_nxt;
                if (mouse_left_prv && !mouse_left) 
                    left_nxt <= 1;
                 else if (mouse_right)
                    left_nxt <= 0;
                    
            end
        end
        
        always_comb begin 
            if (left_nxt && (ypos < 536) && !bounce ) begin
                if (counter >= 1000000) begin
                    ypos_nxt = ypos + 1;
                    counter_nxt = '0; //counter
                    mouse_ypos_save_nxt = mouse_ypos_save;
                    bounce_nxt = bounce;
                    if (a_counter == 12) begin
                        a_nxt = a + 1;
                        a_counter_nxt = '0;
                    end else begin
                        a_nxt = a;
                        a_counter_nxt = a_counter + 1;
                    end
                end else begin
                    ypos_nxt = ypos;
                    counter_nxt = counter + a + 1;
                    a_nxt = a;
                    a_counter_nxt = a_counter;
                    mouse_ypos_save_nxt = mouse_ypos_save;
                    bounce_nxt = bounce;

                end end else if (bounce && left_nxt && (ypos > mouse_ypos_save) ) begin
                    if (counter >= 1000000) begin
                        ypos_nxt = ypos - 1;
                        counter_nxt = '0; //counter
                        mouse_ypos_save_nxt = mouse_ypos_save;
                        bounce_nxt = bounce;
                        if (a_counter == 12) begin
                            a_nxt = a + 1;
                            a_counter_nxt = '0;
                        end else begin
                            a_nxt = a;
                            a_counter_nxt = a_counter + 1;
                        end
                    end else begin
                        ypos_nxt = ypos;
                        counter_nxt = counter - a + 40;
                        a_nxt = a;
                        a_counter_nxt = a_counter;
                        mouse_ypos_save_nxt = mouse_ypos_save;
                        bounce_nxt = bounce;
                    end 
                end
                
                else if (left_nxt && mouse_ypos_save < 502) begin
                ypos_nxt = ypos;
                a_nxt = '0;
                counter_nxt = '0;
                a_counter_nxt = '0;
                bounce_nxt = ~bounce;
                mouse_ypos_save_nxt = mouse_ypos_save + 60;
                end
                
                else if (left_nxt) begin
                    ypos_nxt = 536;
                    a_nxt = '0;
                    counter_nxt = '0;
                    a_counter_nxt = '0;
                    bounce_nxt = bounce;
                    mouse_ypos_save_nxt = mouse_ypos_save;
                end
            else begin
                ypos_nxt = mouse_ypos;
                a_nxt = '0;
                counter_nxt = '0;
                a_counter_nxt = '0;
                bounce_nxt = '0;
                mouse_ypos_save_nxt = mouse_ypos;
            end
        end
    

        /*always_ff @(posedge clk) begin
            if (!rst && !mouse_left) begin
                ypos_nxt <= mouse_ypos + 1;
                end
        end
*/
      
endmodule
