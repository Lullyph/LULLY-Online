///pb_state_stairL()
//The Stair Left State for Platform Girl
if(state_new)
{
    x_speed=0;
    y_speed=0;
    image_speed=0;
    sprite_index=spr_ketty_walk;
    image_index=0;
}


//Stair ASCEND
if(self.up_held && self.left_held)
    {
        image_speed = 0.25;
        image_xscale=-1;
        x_speed=0;
        y_speed=2;
        x-=2;
        y-=2;
        
} else {

            if(!self.down_held && !self.right_held)
            image_speed = 0;
            x_speed=0;
            y_speed=0;
        }


    
//Stair DESCEND
if(self.down_held && self.right_held)

    {
        image_speed = 0.25;
        image_xscale=1;
        x_speed=0;
        y_speed=2;
        x+=2;
        y+=2;
        
} else {
    
        if(!self.up_held && !self.left_held)
        image_speed = 0;
        x_speed=0;
        y_speed=0;
    }


    
//Jump Off
if(self.jump_pressed)
{
    y_speed=0;
    y_speed-=jump_strength/1.5;
    state_switch("Air");
}

if(self.jump_pressed && self.left_held)
{
    state_switch("Air");
    x_speed=1;
    x_speed-=2;
    //y_speed-=jump_strength/2;
}

if(self.jump_pressed && self.right_held)
{
    state_switch("Air");
    x_speed+=2;
    //y_speed-=jump_strength/2;
}
    
    
//Check for GROUND

if(self.up_held && self.left_held){
if((position_meeting_rounded(x,y+4,PAR_Platform) && !place_meeting_rounded(x,y,obj_stairL)))
    {
        state_switch("Stand");
    }
}

if(self.down_held && self.right_held){
if(position_meeting_rounded(x,y+1,obj_ramp) || (position_meeting_rounded(x,y+1,obj_wall) || (position_meeting_rounded(x,y+1,PAR_Platform))))
    {
        state_switch("Stand");
    }
}







