function split_text_to_list(filename)
	local file = io.open(filename, "r")
	local content = file:read("*a")
	local characters_list = {}
	for i = 1, #content do
		characters_list[i] = content:sub(i, i)
	end
	file:close()
	return characters_list
end

local folder_path = "unichunks"

local unicodeChunks = {}

for filename in io.popen('ls "' .. folder_path .. '"'):lines() do
	local file_path = folder_path .. "/" .. filename
	local characters_list = split_text_to_list(file_path)
	table.insert(unicodeChunks, characters_list)
end

io.write("Length of key: ")
local length = tonumber(io.read())

local result = ""
math.randomseed(os.time())
while #result < length do
	local current_chunk = unicodeChunks[math.random(#unicodeChunks)]
	local selected = current_chunk[math.random(#current_chunk)]
	if #result + #selected <= length then
		result = result .. selected
	end
end

io.write("Do you want to save the password to a file? (y/n): ")
local choice = io.read()

if choice == "y" then
	io.write("Enter the file name to save the password: ")
	local file_name = io.read()
	local file = io.open(file_name, "w")
	file:write(result)
	file:close()
	print("Password saved to file:", file_name)
else
	print("Password:", result)
end
