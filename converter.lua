conv = {}

function conv.encode()
  local result = ""
  
  local imagedata = love.image.newImageData("monalisa.jpg")
  
  for i=0, imagedata:getHeight()-1, 1
  do    
    for j=0, imagedata:getWidth()-1, 1
    do
      local r, g, b
      
      r, g, b = imagedata:getPixel(j, i)
      
      r = math.floor(r * 255)
      r = math.max(0, math.min(255, r))
      
      result = result..r.." "
    end
  end
  
  return result
end

function conv.decode()
  
end

return conv