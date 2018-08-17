///pb_state_stand()
//The Walking State for Platform Boy
if(state_new)
{
    image_index=1;
    image_speed = 0.25;
    sprite_index=spr_ketty_walk;
    stick_to_ground=true;
}

//Adjust Speed
if(right_held||left_held)
{
    var _accel;
    if(run_held)
        _accel=run_accel;
    else
        _accel=walk_accel;
    
    if((x_speed<0 && right_held) || (x_speed>0 && left_held))
        _accel*=slide_factor;
    
    if(!run_held)
        x_speed=approach(x_speed,walk_max*(right_held-left_held),_accel)//x_speed+=(right_held-left_held)*walk_accel;
    else
        x_speed=approach(x_speed,run_max*(right_held-left_held),_accel)//x_speed+=(right_held-left_held)*run_accel;
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
    if(right_held)
        image_xscale=1;
    else if(left_held)
        image_xscale=-1;
    
    if((right_held && x_speed>0)) || (left_held && x_speed<0)
    {
        if(!run_held || abs(x_speed)<run_max)
            sprite_index=spr_ketty_walk;
        else
            sprite_index=spr_ketty_run;
    }
    /*else if(right_held || left_held)
        sprite_index=spr_ketty_slide;
    image_speed=lerp(0,.4,abs(x_speed)/run_max);*/
}



///Check for no ground.
if(!position_meeting_rounded(x,y+1,obj_ramp) && !place_meeting_rounded(x,y+1,obj_wall) && !place_meeting_rounded(x,y+1,PAR_Platform))
{
    state_switch("Air");
}

//Horizontal Collision
if(place_meeting_rounded(x+x_speed,y,obj_wall))
{
    x=round(x);
    y=round(y);
    while(!place_meeting_rounded(x+sign(x_speed),y,obj_wall))
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

if(jump_pressed)
{ 
    state_switch("Air");
    y_speed-=jump_strength;
}





///////////////////////////////////////////////////
//LULLY STUFFS NEW////////////////////////////////
//////////////////////////////////////////////////


//LADDER state switch
if(up_held && place_meeting_rounded(x,y,par_LADDER))
{
    state_switch("Ladder");
}

//PLATFORMS

if(place_meeting_rounded(x,y-16,PAR_Platform))
{
    state_switch("PlatformFall");
}

///check for horizontal collision
if(x_speed != 0)
{
    if(place_meeting_rounded(x+x_speed,y,PAR_Platform))
    {
       state_switch("PlatformFall");
    }
}

