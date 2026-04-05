local mat = require("matrix")

local function forward(Xor)
   mat.dot(Xor.a1, Xor.x, Xor.w1)
   mat.sum(Xor.a1, Xor.b1)
   mat.sigmoid(Xor.a1)

   mat.dot(Xor.a2, Xor.a1, Xor.w2)
   mat.sum(Xor.a2, Xor.b2)
   mat.sigmoid(Xor.a2)

   return Xor.a2[1][1]
end

local function cost(Xor, ti, to)
   local result = 0.0

   for i = 1, #ti do
      Xor.x[1][1] = ti[i][1]
      Xor.x[1][2] = ti[i][2]

      local y = forward(Xor)
      local d = y - to[i][1]
      result = result + d*d
   end
   return result / #ti
end

local function finite_diff(Xor, keys, Grad, eps, ti, to)
   local c = cost(Xor, ti, to)

   for _, k in ipairs(keys) do
      for i = 1, #Xor[k] do
         for j = 1, #Xor[k][i] do
            local temp = Xor[k][i][j]

            Xor[k][i][j] = Xor[k][i][j] + eps
            Grad[k][i][j] = (cost(Xor, ti, to) - c) / eps
            Xor[k][i][j] = temp
         end
      end
   end
end


-- Main
local ti = {
   {0.0, 0.0},
   {0.0, 1.0},
   {1.0, 0.0},
   {1.0, 1.0},
}

local to = {
   {0.0},
   {1.0},
   {1.0},
   {1.0},
}

local Xor = {
   x  = mat.init(1, 2),

   w1 = mat.init(2, 2),
   b1 = mat.init(1, 2),
   a1 = mat.init(1, 2),

   w2 = mat.init(2, 1),
   b2 = mat.init(1, 1),
   a2 = mat.init(1, 1),
}

local Grad = {
   x  = mat.init(1, 2),

   w1 = mat.init(2, 2),
   b1 = mat.init(1, 2),
   a1 = mat.init(1, 2),

   w2 = mat.init(2, 1),
   b2 = mat.init(1, 1),
   a2 = mat.init(1, 1),
}

-- Due to behaviour in lua with kv pairs,
-- kv pairs are unordered, which may cause bugs
-- Hence sort keys manually
local keys = {}
for k in pairs(Xor) do
   keys[#keys+1] = k
end
table.sort(keys)

local eps = 1e-2
local rate = 1e-2

-- Abstract later
for k, _ in pairs(Xor) do
   mat.randomf(Xor[k], 0, 1)
end

-- for k, _ in pairs(Xor) do
--    print(k .. ":")
--    mat.print(Xor[k])
-- end

mat.print(Xor.x)

mat.print(Xor.w1)
mat.print(Xor.b1)
mat.print(Xor.a1)

mat.print(Xor.w2)
mat.print(Xor.b2)
mat.print(Xor.a2)
print(cost(Xor, ti, to))
finite_diff(Xor, keys, Grad, eps, ti, to)

mat.print(Xor.x)

mat.print(Xor.w1)
mat.print(Xor.b1)
mat.print(Xor.a1)

mat.print(Xor.w2)
mat.print(Xor.b2)
mat.print(Xor.a2)

mat.print(Grad.a1)
mat.print(Grad.a2)
mat.print(Grad.x)
mat.print(Grad.w1)

-- Print result
print("---------------------------------")
print("Xor gate: ")
for i = 0, 1 do
   for j = 0, 1 do
      Xor.x[1][1] = i
      Xor.x[1][2] = j
      print(string.format("%d ^ %d = %f", i, j, forward(Xor)))
   end
end
