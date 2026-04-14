local mat = require("matrix")

local M = {}

function M.init(layers)
   local nn = {}

   nn["a0"] = mat.init(1, layers[1])
   for i = 1, #layers-1 do
      nn["w" .. i] = mat.init(layers[i], layers[i+1])
      nn["b" .. i] = mat.init(1, layers[i+1])
      nn["a" .. i] = mat.init(1, layers[i+1])
   end

   return nn
end

function M.print(nn)
   for k, v in pairs(nn) do
      print(k .. ": ")
      mat.print(v)
   end
end

function M.randomf(nn, low, high)
   for k, _ in pairs(nn) do
      mat.randomf(nn[k], low, high)
   end
end

function M.fill(nn, x)
   for k, _ in pairs(nn) do
      mat.fill(nn[k], x)
   end
end

function M.ti(training_data)
   -- enter the training data in the format {input11, input12, output13},  {input21, input22, output23}, ...
   -- for example:
   -- nua.ti({
   --  {1, 1, 0},
   --  {1, 0, 1},
   -- })
   local number_of_training_data = #training_data
   local input_matrix = mat.init(number_of_training_data, 3)
   for i = 1, number_of_training_data do
      input_matrix[i][1] = training_data[i][1]
      input_matrix[i][2] = training_data[i][2]
      input_matrix[i][3] = training_data[i][3]
   end
   -- makes the input matrix from the training data
   local training_inputs = mat.init(number_of_training_data, 2)
   local training_outputs = mat.init(number_of_training_data, 1)
   for i =1, number_of_training_data do
      training_inputs[i][1] = input_matrix[i][1]
      training_inputs[i][2] = input_matrix[i][2]
      training_outputs[i][1] = input_matrix[i][3]
   end
   -- separates the input matrix into training inputs and training outputs

   -- however, this is still basic and needs to be improved to handle more complex training data
   -- for now it can only do 2 input and 1 output for each row
end

-- this is a slow function that needs to manually key in training data

-- function M.ti()

--   io.write("enter how many training data u want:")
--   local number_of_training_data = io.read("*n")
--   local notd = tonumber(number_of_training_data)
-- if not notd then
-- error("Please enter a valid number.")
--   end
--
--   io.write("You have entered: " .. notd .. "\n")
--   io.write("enter training data in format: input1, input2, output\n")
--   io.write("For example: 0.5, 0.5, 1.0\n")
--   io.write("Which makes ur input1 and input2 0.5, and output 1.0\n")

--   local user_input_matrix = mat.init(notd, 3)
--   for i = 1, notd do

--      io.write("this is the " .. i .. "th training data\n")
--      io.write("enter input1, input2, output:\n")

--      local ai,bi,ci = io.read("*n", "*n", "*n")
--     local an, bn, cn = tonumber(ai), tonumber(bi), tonumber(ci)
--      user_input_matrix[i][1] = an
--      user_input_matrix[i][2] = bn
--      user_input_matrix[i][3] = cn
--      io.write("For this row, input1 is: " .. an .. ", input2 is: " .. bn .. ", and output is: " .. cn .. "\n")
--   end
--   print("this is the training data you entered:")
--   print("input1  input2  output")
--   mat.print(user_input_matrix)
--   local training_inputs = mat.init(notd, 2)
--   local training_outputs = mat.init(notd, 1)
--   for i = 1, notd do
--      training_inputs[i][1] = user_input_matrix[i][1]
--      training_inputs[i][2] = user_input_matrix[i][2]
--      training_outputs[i][1] = user_input_matrix[i][3]
--   end
--   local training_inputs = a
--   print("The program has separated the training data into inputs and outputs:")
--   print("Training Inputs:")
--   mat.print(training_inputs)
--   print("Training Outputs:")
--   mat.print(training_outputs)
--end

return M
