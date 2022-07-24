mchain = {}

function mchain.run(chapter, count)
  tokens = {}
  words = {}

  for token in string.gmatch(chapter, "[^%s,.]+")
  do
    local found = false
    
    for i, t in ipairs(tokens)
    do
      if t == string.lower(token) then
        found = true
        break
      end
    end
    
    if not found then
      table.insert(tokens, string.lower(token))
    end
    
    table.insert(words, string.lower(token))
  end

  print(#tokens)

  chain = {}

  for i = 0, #tokens, 1
  do
    chain[i] = {}
    
    for j = 0, #tokens, 1
    do
      chain[i][j] = 0
    end
    
    --print(t)
  end

  for i = 1, #words, 1
  do
    local word_a, word_b = words[i-1], words[i]
    local index_a, index_b = 0, 0
    
    for j, t in ipairs(tokens)
    do
      if t == word_a then
        index_a = j
      end
      
      if t == word_b then
        index_b = j
      end
    end
    
    chain[index_a][index_b] = chain[index_a][index_b] + 1
  end

  for i = 0, #chain, 1
  do
    local line = ""
    local sum = 0
    
    for j = 0, #chain[i], 1
    do    
      sum = sum + chain[i][j]
    end
    
    for j = 0, #chain[i], 1
    do
      if sum > 0 then
        chain[i][j] = chain[i][j] / sum
      end
      
      line = line..chain[i][j].." "
    end
    
    --print(line)
  end

  start = "Ще"

  start_index = 0

  for i = 0, #tokens, 1
  do
    if tokens[i] == start then
      start_index = i
      break
    end
  end

  index = 0

  math.randomseed(os.time())

  text = " "

  for i = 0, count, 1
  do
    if tokens[index] ~= nil then
        text = text..tokens[index].." "
        
        if string.sub(tokens[index], -1) == ";" or string.sub(tokens[index], -1) == "{" or string.sub(tokens[index], -1) == "}" then
          text = text.."\n"
        end
    end
    
    local curr_probabilities = {}
    
    for j = 0, #chain[index], 1
    do
      if chain[index][j] > 0 then
        local entry = {}
        
        entry.index = j
        entry.value = chain[index][j]
        
        table.insert(curr_probabilities, entry)
      end
    end
    
    local num = math.random(0, 100)
    
    num = num / 100
    
    local p_sum = 0
    
    for j = 1, #curr_probabilities, 1
    do
      p_sum = p_sum + curr_probabilities[j].value
      
      if num < p_sum or j == #curr_probabilities then
        index = curr_probabilities[j].index
        
        break
      end
    end
  end

  return text
end

return mchain