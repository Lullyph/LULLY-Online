///pb_state_stand()
//The Walking State for Platform Girl
if(state_new)
{
    image_index=1;
    image_speed = 0.25;
    sprite_index=spr_ketty_walk;
    stick_to_ground=true;
}

//Adjust Speed
if(self.right_held||self.left_held)
{
    var _accel;
    if(self.run_held)
        _accel=run_accel;
    else
        _accel=walk_accel;
    
    if((x_speed<0 && self.right_held) || (x_speed>0 && self.left_held))
        _accel*=slide_factor;
    
    if(!self.run_held)
        x_speed=approach(x_speed,walk_max*(self.right_held-self.left_held),_accel)//x_speed+=(right_held-left_held)*walk_accel;
    else
        x_speed=approach(x_speed,run_max*(self.right_held-self.left_held),_accel)//x_speed+=(right_held-left_held)*run_accel;
}
else
    x_speed=approach(x_speed,0,walk_accel);

    

///Check for no speed.
if(x_speed == 0)
{
    state_switch("Stand");
}
else
{   //Update Sprite
    if(self.right_held)
        image_xscale=1;
    else if(self.left_held)
        image_xscale=-1;
    
    if((self.right_held && x_speed>0)) || (self.left_held && x_speed<0)
    {
        if(!self.run_held || abs(x_speed)<run_max)
            sprite_index=spr_ketty_walk;
        else
            sprite_index=spr_ketty_run;
    }
    /*else if(right_held || left_held)
        sprite_index=spr_ketty_slide;
    image_speed=lerp(0,.4,abs(x_speed)/run_max);*/
}



///Check for no ground.
if(!position_meeting_rounded(x,y+1,obj_ramp) && !place_meeting_rounded(x,y+1,PAR_Wall) && !place_meeting_rounded(x,y+1,PAR_Platform))
{
    state_switch("Air");
}

//Horizontal Collision
if(place_meeting_rounded(x+x_speed,y,PAR_Wall))
{
    x=round(x);
    y=round(y);
    while(!place_meeting_rounded(x+sign(x_speed),y,PAR_Wall))
    {
        x+=sign(x_speed);
    }
    x_speed=0;
    if(position_meeting_rounded(x,y,obj_ramp))
    {
        while(position_meeting_rounded(x,y,obj_ramp))
        {   //Ramp Up
            y--;
        }
    }
    state_switch("Stand");
}
else
{
    x+=x_speed;
    //Check For Ramps
    if(position_meeting_rounded(x,y,obj_ramp))
    {
        while(position_meeting_rounded(x,y,obj_ramp))
        {   //Ramp Up
            y--;
        }
    }
    else if(stick_to_ground)
    {
        var _check_distance=8;
        for(var i=0;i<_check_distance;i++)
        {
            if(position_meeting_rounded(x,y+i,obj_ramp))
            {
                while(!position_meeting_rounded(x,y+1,obj_ramp))
                    y++;
                    
                if(abs(x_speed)>0)
                    state_switch("Walk");
                else
                    state_switch("Stand");
                break;
            }
        }
        
    }
}

if(self.jump_pressed)
{ 
    state_switch("Air");
    y_speed-=jump_strength;
}





///////////////////////////////////////////////////
//LULLY STUFFS NEW////////////////////////////////
//////////////////////////////////////////////////


///LADDERS///

//LADDER state switch climb UP
if(self.up_held && place_meeting_rounded(x,y,par_LADDER))
{
    state_switch("Ladder");
}

//LADDER state switch climb DOWN
if(self.down_held && place_meeting_rounded(x,y+16,par_LADDER))
{
    self.x=par_LADDER.x+16;
    y += 1;
    state_switch("Ladder");
}


///PLATFORMS///

//To NOT get stuck in platform
if((!place_meeting_rounded(x,y+1,PAR_Wall) && !position_meeting_rounded(x,y+1,obj_ramp)) && !place_meeting_rounded(x,y+5,PAR_Platform))
{
    state_switch("PlatformFall");
}

///STAIRS///

//Stair Right and Left TOP

if((self.down_held && self.left_held) && place_meeting_rounded(x,y,obj_stairTOPR))
{
    
    state_switch("StairR");
}

if((self.down_held && self.right_held) && place_meeting_rounded(x,y,obj_stairTOPL))
{
    state_switch("StairL");
}

///STAIRS///

//Stair Right and Left BOT

if((self.up_held && self.right_held) && place_meeting_rounded(x,y,obj_stairBOTR))
{
    state_switch("StairR");
}

if((self.up_held && self.left_held) && place_meeting_rounded(x,y,obj_stairBOTL))
{
    state_switch("StairL");
}

