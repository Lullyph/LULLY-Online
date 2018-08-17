///pb_state_air()
//The in air State for Platform Girl
if(state_new)
{
    image_speed=0;
    image_index=0;
    state_var[0]=false;
    state_var[1]=false;
    if(air_control_enabled && self.jump_held && y_speed<0)
    {
        if(abs(x_speed)>=run_max)
            state_var[1]=true;
        state_var[0]=true;   //Keep track of whether I am jumping and if I have let go of jump.
    }
}

//Adjust Y Speeds
if(self.jump_held && state_var[0] && state_timer < jump_hold_limit)
{
    //show_debug_message("Jump Held");
    y_speed=-jump_strength;
}

if(self.jump_released)
    state_var[0]=false;

//Apply Gravity
y_speed=min(y_speed+grav,max_grav);


//Basic Vertical Collision Checking
if(place_meeting_rounded(x,y+y_speed,obj_wall) || position_meeting_rounded(x,y+y_speed,obj_ramp)) 
{   //Snap to floor
    x=round(x);
    y=round(y);
    while(!place_meeting_rounded(x,y+sign(y_speed),obj_wall) && !position_meeting_rounded(x,y+sign(y_speed),obj_ramp))
        y+=sign(y_speed);
    y_speed=0;
    state_var[0]=false;
}
else
{   //Fall
    y+=y_speed;
}

//PLATFORM V-Check
if (y_speed >= 0 && (place_meeting_rounded(x,y+y_speed,PAR_Platform)))
{
    x=round(x);
    y=round(y);
    while(!place_meeting_rounded(x,y+sign(y_speed),PAR_Platform))
    y+=sign(y_speed);
    y_speed=0;
    state_switch("Walk");
}

//PLATFORM H-Check
if(x_speed != 0)
{
    if(place_meeting_rounded(x+x_speed,y,PAR_Platform))
    {
       state_switch("PlatformFall");
    }
}

if(x_speed = 0)
{
    if(place_meeting_rounded(x+x_speed,y,PAR_Platform))
    {
       state_switch("PlatformFall");
    }
}



//FIX FOR RAMP LANDING
if(position_meeting_rounded(x,y+y_speed,obj_ramp))
{
    state_switch("Walk");
    y_speed=0;
}



//Change Sprite
if(!state_var[1])
{
    if(y_speed>0)
        sprite_index=spr_ketty_fall;
    else
        sprite_index=spr_ketty_jump;
}
else
    sprite_index=spr_ketty_run_jump;  
    
//Adjust x_speed
if(air_control_enabled && (self.right_held||self.left_held))
{
    if(self.right_held-self.left_held != 0)
        image_xscale=self.right_held-self.left_held;
    if(!self.run_held)
        x_speed=approach(x_speed,walk_max*(self.right_held-self.left_held),walk_accel)//x_speed+=(right_held-left_held)*walk_accel;
    else
        x_speed=approach(x_speed,run_max*(self.right_held-self.left_held),run_accel)//x_speed+=(right_held-left_held)*run_accel;
}

    
///check for horizontal collision
if(x_speed != 0)
{
    if(place_meeting_rounded(x+x_speed,y,obj_wall))
    {
        x=round(x);
        y=round(y);
        while(!place_meeting_rounded(x+sign(x_speed),y,obj_wall))
        {
            x+=sign(x_speed);
        }
        x_speed=0;
    }
    else
        x+=x_speed;
}

//Look For State Switches
if((place_meeting_rounded(x,y+1,obj_wall) || position_meeting_rounded(x,y,obj_ramp) || place_meeting_rounded(x,y,PAR_Platform)) && y_speed == 0)
{
    if(x_speed==0)
        state_switch("Stand");
    else
        state_switch("Walk");
}







///////////////////////////////////////////////////
//LULLY STUFFS NEW////////////////////////////////
//////////////////////////////////////////////////


//LADDER state switch
if(self.up_held && place_meeting_rounded(x,y,par_LADDER))
{
    state_switch("Ladder");
}


//PLATFORMS



