#!/usr/bin/lua
--[[
TODO:
- Uodate the titlebar
- Update the bottom bar
- Update the themes (global)
- Update the script (global)
- 
]]
function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function updateFileShelf(fileName, contentInsert)
-- Step 1: Read the file
local file = io.open(fileName, "r")
local lines = {} -- Table to hold the lines
for line in file:lines() do
    table.insert(lines, line)
end
file:close()

-- Step 2: Modify the content
for i = #lines, 1, -1 do
    if string.sub(lines[i], 1, 5) == "<!--H"  then
		print("Found newline... inserting...")
        --table.insert(lines, i, contentInsert) -- Insert "Hello World" above the target line
        lines[i-1]=contentInsert
        break -- Exit the loop once the target line is found
    end
end

-- Step 3: Write the modified content back
local file = io.open(fileName, "w")
for _, line in ipairs(lines) do
    file:write(line, "\n") -- Ensure each line ends with a newline character
end
file:close()
end

function readAll(file)
    local f = assert(io.open(file, "r"))
    local content = f:read("*l")
    f:close()
    return content
end







barFiles={"index.html", "blog/index.html", "notebox.html", "about.html", "btgp.html", "gol.html", "projects.html", "site-core.html", "todo.html", "blog/blogcore.html"}
--barFiles={"index.html", "about.html", "todo.html"}
print("Spielprofessor.github.io - update and configure webpage;\n! MAKE SURE YOU EXECUTE THIS FROM WEBPAGE ROOT")
print("[1] Create new blogpost")
print("[2] Update shelf")

print("-=-=-=-=-=-=-=-=-=-=-=-")
io.write("> ")
input=io.read()
if tonumber(input)==1 then
	os.execute("cd blog && ./newblogpost.lua")
elseif tonumber(input)==2 then
	titleBarContent=readAll("titleshelf.html")
	
	insertPipe=false
	print("Please insert whether or not you want to add a pipe between the previous pipe content and the new one [Y/N]")
	agree=io.read()
	if agree=="y" or agree=="Y" then
		agree=true
	else
		agree=false
	end
	if agree then
		insertPipe=true
	end
	print('Please insert the text to attach to the end of the top bar. HTML support. Example link: <a class="titlebar" href="index.html">home</a>')
	textAttach=io.read()
	i=1
	while i<=#barFiles do
		if insertPipe then
			updateFileShelf(barFiles[i], titleBarContent.." | "..textAttach.." </h2>")
		else
			updateFileShelf(barFiles[i], titleBarContent..textAttach.." </h2>")
		end
		i=i+1
	end
	file=io.open("titleshelf.html", "w")
	if insertPipe then
		file:write(titleBarContent.." | "..textAttach)
	else
		file:write(titleBarContent..textAttach)
	end
	file:close()
end
