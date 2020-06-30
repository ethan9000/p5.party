pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
--init
function _init()
 objs={}
 t=0
 p=obj_init(1,0,0,player_upd)
 upd=game_upd
 drw=game_drw
 str=""
 for x=0,127 do
  for y=0,63 do
   str=str..mget(x,y)..","
  end
 end
-- str=str.."\n"
-- for x=0,127 do
--  for y=0,63 do
--   str=str..fget(mget(x,y))..","
--  end
-- end
 printh(str,"txt.txt",true)
end

function obj_init(s,x,y,upd,drw,w,h)
 return add(objs,{
  s=s,
  x=x or 0,
  y=y or 0,
  upd=upd or empty,
  drw=drw or spr_draw,
  w=w or 8,
  h=h or 8,
 })
end


-->8
--updates
function _update60()
 upd()
 t+=1
end

function title_upd()
 if btnp(🅾️) or btnp(❎) then
  upd=game_update
  drw=game_draw
 end
end

function game_upd()
 foreach(objs,function(o)o:upd()end)
end

function player_upd(self)
 if (btnp(⬅️))self.x-=1
 if (btnp(➡️))self.x+=1
 if (btnp(⬆️))self.y-=1
 if (btnp(⬇️))self.y+=1
end
-->8
--draws
function _draw()

 reset_pal()
 camera(p.x*8-60,p.y*8-60)
 pal(1,0)
 cls(5)
 drw()
end

function title_drw()
 print("placeholder title")
end

function game_drw()
 outline(function()
 map()
 foreach(objs,function(o)o:drw()end)
 ui_draw()
 end)
end

function spr_draw(self)
 spr(self.s,self.x*8,self.y*8,self.w/8,self.h/8)
end

function ui_draw()

end
-->8
--mechanics
-->8
--ai/pathfinding
function ai_upd()

end
-->8
--data/saving
function load_data()
 if dget(0)!=0 then
  
 else
  init_data()
 end
end

function save_data()
 dset(0,t)
end

function init_data()
 dset(0,1)
end
-->8
--helper
function explodeval(s)
 local retval,lastpos,subarray={},1
 local i=1
 while i<=#s do
  local subes=sub(s,i,i)
  if subes=="," and not subarray then
   local subs=sub(s, lastpos, i-1)
   add(retval,tonum(subs) or subs)---#subs!=0 and
   i+=1
   lastpos=i
  end
  if i==#s then
   local subs=sub(s, lastpos, #s)
   add(retval,tonum(subs) or subs)
  end
  i+=1
 end
 return retval
end

dirx,
diry
=
explodeval("-1,1,0,0,1,1,-1,-1,"),
explodeval("0,0,-1,1,-1,1,1,-1,")
dirx[0]=0
diry[0]=0

function outline(func,c)
 local camx,camy=peek(0x5f28)+peek(0x5f29)*256,peek(0x5f2a)+peek(0x5f2b)*256
 for i=0,15 do
  pal(i,c)
 end
 for i=4,0,-1 do
  camera(camx+dirx[i],camy+diry[i])
  if i==0 then
   reset_pal()
  end
  func(i)
 end
end

function reset_pal()
 palt()
 pal()
end

function empty()end
__gfx__
00000000009990000000000001111110666666667777777777777777222222220000000000000000000000000000000000000000000000000000000077a64577
00000000099999000000000001055510666666667777777777777777266a96620077700000000000000000000000000000000000000000000000000077111177
0070070009f1f1000000000001111110666666667777777777777777255955520777770000000000000000000000000000000000000000000000000077576477
0007700009ffff000000000001005010666666667777777777777777266666620677760000000000000000000000000000000000000000000000000077888877
00077000066666000000000001dd8d10dddddddd6666666666666666266666620d666d0000000000000000000000000000000000000000000000000077777777
00700700666666600000000001dddd10d0300ebd6666666666666666222222220d000d0000000000000000000000000000000000000000000000000077777577
00000000f77777f00000000001111110d616666d6aaaaaaaaaaaaaa6eeeeeeee0ddddd0000000000000000000000000000000000000000000000000077555777
00000000070007000000000001111110ddddddddaaaaaaaaaaaaaaaa111111110d000d0000000000000000000000000000000000000000000000000077777577
00000000000000000000000001111110d6b9a2cdaa999999999999aa1d0000d10000000000000000000000000000000000000000000000000000000011111111
00000000000000000000000000000000d666666daa999999999999aa100000010000000000000000000000000000000000000000000000000000000011111111
00000000000000000000000000000000dddddddd999aaaaaaaaaa999100000010000000000000000000000000000000000000000000000000000000011111111
00000000000000000000000000000000d0000c1d9aaaaaaaaaaaaaa9000000000000000000000000000000000000000000000000000000000000000011111111
00000000000000000000000000000000d03b0c1d9aaaaaaaaaaaaaa90000000000000000000000000000000000000000000000000000000000000000dddddddd
00000000000000000000000000000000d644666d09999999999999900000000000000000000000000000000000000000000000000000000000000000d666d666
00000000000000000000000000000000dddddddd09999999999999900000000000000000000000000000000000000000000000000000000000000000d666d666
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d666d666
000000000000000000000000dddddddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d661d661
000000000000000000000000dddddddd0000077777000000000000000000000000000000000000000000000000000000000000000000000000000000d666d666
000000000000000000000000dddddddd0000777777700000000000000000000000000000000000000000000000000000000000000000000000000000d666d666
000000000000000000000000dddddddd0007777777770000000000000000000000000000000000000000000000000000000000000000000000000000d666d666
000000000000000000000000111111110007777777770000000000000000000000000000000000000000000000000000000000000000000000000000d666d666
0000000000000000000000001aa889110007777777770000000000000000000000000000000000000000000000000000000000000000000000000000d666d666
0000000000000000000000001ddddd130006777777760000000000000000000000000000000000000000000000000000000000000000000000000000dddddddd
0000000000000000000000001eeb3311000067777760000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000001ddddd1d000006666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000127acc1d000000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000001ddddd1100000dd5dd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000199cee110000000d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000011111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000001ddddd11000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000011111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777000000007777777766dddd66000000007777777707777770777777777777777777777777777777777777777747777777777777777777877777777777
77777777000000007777777766dddd6666666666777777777777777777777777777777777777777777777777777777774444444777777777777777a777777777
77777777cccccccc7777777766dddd666666666677777777777777777777777777777777777777777777777777777777459895577746667777ccc77777777777
77777777cccccccc7777777766dddd66dddddddd7777777777777777777777777777777777777777777777777777777749995557764996677ca45c7777888877
66666666cccccccc7777777766dddd66dddddddd666666667777777766666666666666666666666666666666666666664989999776498997caf3abc778788877
ddddddd6cccccccc7777777766dddd66dddddddd6666666667777776666666666666666666666666666666666611111645998957766996697c4b3c7777888877
ddddddd6cccccccc7777777766dddd66dddddddd66666666666666666666666688888866161666661166686661666116744444477766667777ccc77777788777
ddddddd6cccccccc7777777700dddd00dddddddd6666666666666666666166666666666661166666616688861111161677777777777777777777777777777777
55555556cccccccc6666666600dddd00dddddddd6666666666666666661616661161111666116666111668661666161677777777777777777777777700000000
55555556cccccccc6600006600dddd00dddddddd66666666666666666166616666666666661611666666666616661616778777777dd777777777777700777000
55555556777777776600006600dddd00dddddddd6666666666666666161616166111616661616666116611161666116676d6686777d777777666667707777700
55555556777777770000000000dddd00dddddddd6666666666666666666666666666666661661666616661161111166676d68887776667777611167707666700
55555556666666660000000000dddd00dddddddd666666666666666666666666666666666166166661161116666666667666686777ccc7777611167706696600
55555556666666660000000000dddd00dddddddd666666666666666666666666666666666666666666666666666666667dddddd777ccc7777666667706966600
55555556666666660000000000dddd0000000000666666666666666666666666666666666666666666666666666666667777777777ccc777ddddddd709666000
55555550000000000000000000dddd00000000000000000006666660000000000000000000000000000000000000000077777777777777777777777709000000
66666666777777770770000000000770000000000000000066666666666666666666666677777777444444444444444077777777777777777777777709000000
66cccc666666666607700000000007700000000000000770660000000000000000000066777716674444444444444440777777777777777777ccdddd09000000
66cccc66611111160776777007776770000000000000076066000000000000000000006677771667222222222222222077666667777777777ddc6c6c09000000
66cccc66611111160776777007776770000000000077677000000000000000000000000077771667244256776752442077666667777777777ddccccc09000000
77cccc776111111606677770077776600000000007777660000000000000000000000000777716672242d76777d24220776767677777777777ccdddc09000000
77cccc7761111116066666600666666000000000067776600000000000000000000000007dddddd7244257767652442077ddddd77e6aaf7777c6c6c609000000
77cccc77666666660660066006600660000000000666666000000000000000000000000077776777222222222222222077777777777777777777777709000000
77cccc7700dddd000000000000000000000000000066660000000000000000000000000077777666444444444444444077777777777777777777777709000000
77cccc7776d6d6d70066660000000000777dd777666666660000000066dd66dd666666667785877746767676767676407b888877776777777777777709000000
77cccc777d666d670677776007777770777d7777666666660000000066dd66dd666666667788877746767676767676408b7a77877776777774f4f4f709000000
77cccc77777777770677776007666670787d7c77667776660000000066dd66dddddddddd7711177746767676767676407b7a7877776767777f4f4f4709000000
77cccc776666666607666670067777606666666767d7d7660000000066dd66dddddddddd771117775255555555555250788887a77777767774f4f4f709000600
77cccc776dddddd607777770067777606ddddd6767d7d7660000000066dd66dd666666667711177752554445444552508b7a77a7776767777f4f4f4709009960
77cccc776777777606666660066666606ccccc67677d77660000000066dd66dd6666666677ccc777525455545554525087bba7a77776777774f4f4f709009900
77cccc776666666606600660066006606ccccc67667776660000000066dd66dddddddddd77c5c77752555555555552507877ba77776777777f4f4f4700990000
66666666d000000d000000000000000066666667666666660000000066dd66dddddddddd77777777020000000000020077777777777777777777777700000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024870087240000240000240000
00000000000024040404040404040000000000000000000000000000000035000000000000003500000000000000000000000000000000350000000000000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024000000242424240000645454
54545454545464545454545454545464000000245454545464545454545454545464545454545454545464545454542400000064000000245454545454545424
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000054141454240000340000245555
55555555555524555555555555555524000000245555555565555555555555555524555555555555555565555555552400000065000000245555555555555524
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055151555240000350000240000
00000000000024000000272700000024000000240000000000000000000000000024000000000000000000000000002400000000000000240000000000000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000242424240000240000
00000000000024000026242436000024000000240000000000000000000000000024000024242424242424242400002400000000000000240026242436000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000240000340000240000
00000000000024000026242436000024000000240000000000000000000000000024000024767666768676862400002400000000000000240026242436000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000240000350000240000
00000000000024000026242436000024000000240000000000000000000000000024000024242424242424242400002400000000000000240026242436000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000242424240000240000
00000000000024000026242436000034000000240000000000000000000000000024000025768666768676862500002400000000000000240026242436000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000240000340000240000
00000000000024000000373700000035000000240000000000000000000000000024000000000000000000000000002400000000000000340026242436000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000240000350000240000
00000000000024000000000000000024000000545454545454545454440000445454544400004454545454545454545400000000000000350026242436000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024541454245454540000645454
54545454545464545454545454545464000000555555555564555555450000455564554500004555555564555555555500000064000000350000668600000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024551555345555550000245555
55555555555524555555555555555524000000000000000065000000000000000065000000000000000065000000000000000065000000350026242436000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024474700350000000000240000
00000000000024000000000000000024000000000000000000000000000000000000000000000000000000000000000000000000000000350000668600000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024545400242424240000240000
00000000000024262626262626000034000000000000000000000000000000000000000000000000000000000000000000000000000000545424545454545424
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024000000240000340000240000
00000000000024262626262626000000000000000000000000000000000000000000000000000000000000000000000000000000000000555534555555555524
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024542454240000350000240000
00000000000024262626262626000024000000000000000000000000000000000000000026242436262424362624243600000000000000000035000000000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024372437242424242400240000
00000000000024545454545454545424000000000000000000000000000000000000000026242436262424362624243600000000000000000024000000000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024545454240000002400240000
00000000000024555555555555555524000000000000000000000000000000000000000000252500002525000025250000000000000000000024000000000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024555555248700872400240000
00000000000024000000000000000024000000000000000000000000000000000000000000000000000000000000000000000000000000000024000000000024
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024000037248700873400645454
54545454440064000000000000000064000000000000000064000000000000000064000000245454545464545454545454440064540044145454545454545424
2454547454845444004454b4a4549454240000000000000000000000000000000000000000000000000000000000000000000024000000240000003500245555
55555555450065000000000000000065000000000000000065000000000000000065000000245555555565555555555555450024550045155555555555555524
2455577555855545004555b5a5559555240000000000000000000000000000000000000000000000000000000000000000000024470000245454545400540000
00000000000000000000000000000000000000000000000000000000000000000000000000240000000000000000000000000024000000000000000000000024
24f50000000000000000000000001600240000000000000000000000000000000000000000000000000000000000000000000024000000345555555500550000
00000000000000000000000000000000000000000000000000000000000000000000000000240000000000000000000000000024002624242436000000000006
24f60026c40026c50026e70000001700240000000000000000000000000000000000000000000000000000000000000000000024240000350000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000240000000000000000000000000024002624862436000000000007
24f60026d40026970026e40000000000240000000000000000000000000000000000000000000000000000000000000000000024245454545454545454545454
54245454545454542400000000000000000000000000000000000000000000000000000000240000000000000000000000000024002624002436000000000024
24f70026250026250026250000f40000240000000000000000000000000000000000000000000000000000000000000000000024245555555555555555555555
55245555555555552400000000000000000000000000000000000000000000000000000000240000000000000000000000000024002624002436000000000024
24000026d50026e60026e50000d63600240000000000000000000000000000000000000000000000000000000000000000000024240000000000000000000000
00240000000000002400000000000000000000000000000000000000000000000000000000240000000000000000000000000024002624002436000000000006
24000026d70026c70026960000250000240000000000000000000000000000000000000000000000000000000000000000000024240000000000000000000000
00240000000000002400000000000000000000000026242436262424362624243626242436240000000000000000000000000024002624242436000000000007
24000026250026250026250000000000240000000000000000000000000000000000000000000000000000000000000000000024240000000000000000000000
00240000000000002400000000000000000000000026242436262424362624243626242436240000000000000000000000000024000025768600000000000024
24000000000000000000000000000000240000000000000000000000000000000000000000000000000000000000000000000024240000000000000000000000
00240000000000002400000000000000000000000000252500002525000025250000252500240000000000000000000000000024000000000000000000000024
54541454541454541454541454541454540000000000000000000000000000000000000000000000000000000000000000000054545414141454141414541414
54545414145454545454141454141454545414145454141454541414545414145454541414545414145454541414545414145454545414145454141454545454
55551555551555551555551555551555550000000000000000000000000000000000000000000000000000000000000000000055555515151555151515551515
55555515155555555555151555151555555515155555151555551515555515155555551515555515155555551515555515155555555515155555151555555555
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101010101010101010101010101000000010101010101010101010101000001000000000000000000000101010000010000000000000000000001010100
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
42454547454845440044454b4a45494542000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
42557557555855540054555b5a55595542000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
425f000000000000000000000000610042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
426f00624c00625c00627e000000710042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
426f00624d00627900624e000000000042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
427f00625200625200625200004f000042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
420000625d00626e00625e00006d630042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
420000627d00627c006269000052000042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4200006252006252006252000000000042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4200000000000000000000000000000042000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4545414545414545414545414545414545000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5555515555515555515555515555515555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004245454542454541414541414542454141454241454542454541454245454545424545454245454245454245454245454245454245454245454545454542
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004245454545454545454542454141454255555542555551515551515542555151554251555542555551554255555555425555554255554255554255554255554255554255554255555555555542
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000605555555555555555554555515155454544454500000000000000004240000000420000004300000065420077770042000000420000420000420000420000420000420000424c4c4c4c4c4c42
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700000000000000000005500000000555554555500000000000000004240000000424000000000004242420077770042454444454444454444454444454444454444454444424c0000004c4c42
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000420000000000000000000000000000000000000000000000000000004240000000424000004274000065420000000042555454555454555454555454555454555454555454424c0000004c4c42
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000004240000000424000004274004242420077770042000000000000000000000000000000000000000000424c0000004c4c42
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000004300000000424000004200000065420077770042000000000000004241414441414142454545454542454c0000004c4c42
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000042000000000000000000000000000000000000000000000000000000000000000042400000424545454545444545454500000000000000425151545151514255555555554355520000004c4c42
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000042400000425555555555545555555500000000000000420000000000004200000000005300000000004c4c42
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000046454545454545454546404040404040404546000000004240000046454545454542454546454545454241414146000000004245454546000000424c4c4c4c4c4c4c42
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004200000000000000000042555555555555555542405050505050505556000000004200000043555555555542555542555555554251515156000000004255555542000000424242424242424242
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004200000000000000000042000000000000000042400000000000000000000000004200000000000000006542424242744242424200000000000000004500000042000000420000000000000042
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004245454542454545440042000000000000000042400000000000000000000000004300000042000000424242000055676767684200000000000000005500000042000000420072727272000042
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004255555543555555540042000000000000000042400040404040400000000000000000000042747400006542000000007200004200000000000000000000000042000000426242424242636342
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004200000053000000000042000000000000000042400050505050500000000000004545454545454545454542000000624263004245454545000045454545454545000000426242424242636342
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004278007842454442004442000000000000000042400000000000000000000000005555555555555555555542000000005200004255555555000055555555555555000000530042424242000042
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004278007842555442005442000000000000000042400000000000000000000000000000000000000000000043000000000000004300000000000000000000000000000000530052525252000042