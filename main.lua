function love.load()
  conv = require("converter")
  
  chapter = conv.encode()

  mchain = require("markov")
  
  values = mchain.run(chapter, 50 * 50)
  
  image = {}
  
  local index = 0
  
  for token in string.gmatch(values, "[^%s]+") do
    image[index] = tonumber(token)
    
    index = index + 1
  end
end

function love.update(dt)
  values = mchain.run(chapter, 50 * 50)
  
  image = {}
  
  local index = 0
  
  for token in string.gmatch(values, "[^%s]+") do
    image[index] = tonumber(token)
    
    index = index + 1
  end
end

function love.draw()
  --for i = 0, #chain, 1
  --do
    --for j = 0, #chain[i], 1
    --do
      --love.graphics.setColor(chain[i][j], chain[i][j], chain[i][j])
      
      --love.graphics.rectangle("fill", j, i, 1, 1)
    --end
  --end
  
  for i = 0, 49, 1
  do
    for j = 0, 49, 1
    do
      local b = image[i*50 + j]
      
      print(b)
      
      love.graphics.setColor(b / 255., b / 255., b / 255.)
      
      love.graphics.rectangle("fill", j * 5, i * 5, 5, 5)
    end
  end
end