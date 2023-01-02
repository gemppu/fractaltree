-- title:   Fractal (binary) tree
-- author:  gemppu
-- desc:    https://en.wikipedia.org/wiki/L-system
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

PI4 = 0.785
n = 14
mp = 1.35

-- s:     scale
-- theta: angle
-- n:     depth
-- n0:    fist iteration depth

function fractalTree(x,y,s,theta,n,n0)
  local nx = x+math.sin(theta)*mp^n*s*1/mp^n0
  local ny = y+math.cos(theta)*mp^n*s*1/mp^n0
  n=n-1
  if n>0 then
    fractalTree(nx,ny,s,theta-PI4,n,n0)
    fractalTree(nx,ny,s,theta+PI4,n,n0)
  end
  line(x,y,nx,ny,(n-n0-1)%15+1)
end


function BOOT()
  palletteAddr = tonumber("0x03fc0")
  for i= 0,15,1 do
    addr = palletteAddr + i*3
    col = i*8
    poke(addr+0,col)
    poke(addr+1,col)
    poke(addr+2,col)
  end
end


function TIC()

	if btn(0) then n = math.min(14,n+1) end
	if btn(1) then n = math.max(0,n-1) end
	if btn(2) then mp = mp-.01 end
	if btn(3) then mp = mp+.01 end

  cls()
  xStart = 240/2
  yStart = 136
  theta = 3.1416
  scale = 136/3
  fractalTree(xStart,yStart,scale,theta,n,n)
  print("n: "..string.format("%.0f",n),0,124,15,true)
  print("length: "..string.format("%.2f",mp).."^n",0,130,15,true)
end