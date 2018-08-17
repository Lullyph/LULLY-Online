///pb_state_ladder()
//The Ladder State for Platform Girl
if(state_new)
{
    x_speed=0;
    y_speed=0;
    image_speed=0;
    sprite_index=spr_ketty_climb;
    image_index=0;
}


//Ladder Climb
if(place_meeting_rounded(x,y,par_LADDER) && up_held)
    {
        x=par_LADDER.x+16;
        x_speed=0;
        y_speed=2;
        y-=2.5;
    }
        else if(!place_meeting_rounded(x,y,par_LADDER) && up_held)
    {
    y_speed=0;
    state_switch("Air");    
}

    
//Jump Off
if(jump_pressed)
{
    state_switch("Air");
    y_speed-=jump_strength/2;
}

if(jump_pressed && left_held)
{
    state_switch("Air");
    x_speed=1;
    x_speed-=2;
    //y_speed-=jump_strength/2;
}

if(jump_pressed && right_held)
{
    state_switch("Air");
    x_speed+=2;
    //y_speed-=jump_strength/2;
}
    
//MOVE DOWN LADDER
if(down_held)

    {
        x_speed=0;
        y_speed=2;
        y+=2.5;
    }


    
    
//Check for GROUND
if(place_meeting_rounded(x,y,par_LADDER) && ((position_meeting_rounded(x,y+1,obj_ramp) || (position_meeting_rounded(x,y+1,obj_wall) || (position_meeting_rounded(x,y+5,PAR_Platform)))&& down_held)))
{
    state_switch("Air");
}


















/*0x000000:
    if !(bool self.state_new) goto 0x00004C
0x000010:
    self.x_speed = 0s
    self.y_speed = 0s
    self.image_speed = 0s
    self.sprite_index = 90s
    self.image_index = 0s
0x00004C:
    if !(bool (place_meeting_rounded[]:int32 (var 125s) self.y self.x)) goto 0x000104
0x000074:
    self.x = (int32 (instance_nearest[]:int32 (var 125s) self.y self.x)):x
    self.x_speed = 0s
    self.y_speed = 0s
    if !(bool self.up_held) goto 0x000104
0x0000D0:
    self.y_speed = (- self.y_speed 3s)
    self.y = (+ self.y self.y_speed)
0x000104:
    if !(bool (place_meeting_rounded[]:int32 (var 125s) (+ self.y 32s) self.x)) goto 0x0001FC
0x000134:
    self.x = (int32 (instance_nearest[]:int32 (var 125s) self.y self.x)):x
    self.x_speed = 0s
    self.y_speed = 0s
    if !(bool self.down_held) goto 0x0001C0
0x000190:
    push (bool (place_meeting_rounded[]:int32 (var 125s) (+ self.y 2s) self.x))
    goto 0x0001C4
0x0001C0:
    push 0s
0x0001C4:
    if !pop goto 0x0001FC
0x0001C8:
    self.y_speed = (- self.y_speed 3s)
    self.y = (- self.y self.y_speed)
0x0001FC:
    if !(~ (bool (place_meeting_rounded[]:int32 (var 125s) self.y self.x))) goto 0x00024C
0x000228:
    self.y_speed = 0s
    call (state_switch[]:int32 (var "Stand"))
0x00024C:
    if !(bool self.jump_pressed) goto 0x00029C
0x00025C:
    self.y_speed = (- self.y_speed (/ self.jump_strength (double 2s)))
    call (state_switch[]:int32 (var "Air"))
0x00029C:
    if (bool self.left_held) goto 0x0002BC
0x0002AC:
    push (bool self.right_held)
    goto 0x0002C0
0x0002BC:
    push 1s
0x0002C0:
    if !pop goto 0x0002F0
0x0002C4:
    push (~ (bool (place_meeting_rounded[]:int32 (var 125s) self.y self.x)))
    goto 0x0002F4
0x0002F0:
    push 0s
0x0002F4:
    if !pop goto 0x000310
0x0002F8:
    call (state_switch[]:int32 (var "Walk"))
0x000310:
    if !(bool (place_meeting_rounded[]:int32 (var 129s) (+ self.y 1s) self.x)) goto 0x000364
0x000340:
    self.y_speed = 0s
    call (state_switch[]:int32 (var "Stand"))
0x000364:
    exit

