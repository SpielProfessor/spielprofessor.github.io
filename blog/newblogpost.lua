#!/usr/bin/lua
------------------------------------------------------------------------------------------------------------------------------
--TODO
-- Add Title & Date to main blog page
-- Add blog management UI
-- Maybe add text editor
--
------------------------------------------------------------------------------------------------------------------------------

-- Settings --
EDITOR="nano"

-- library stuff --
function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end


function updateFile(fileName, contentInsert)
-- Step 1: Read the file
local file = io.open(fileName, "r")
local lines = {} -- Table to hold the lines
for line in file:lines() do
    table.insert(lines, line)
end
file:close()

-- Step 2: Modify the content
for i = #lines, 1, -1 do
    if string.sub(lines[i], 1, 5) == "<!--N"  then
		print("Found newline... inserting...")
        table.insert(lines, i, contentInsert) -- Insert "Hello World" above the target line
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


function main()
------------------------------------------------------------------------------------------------------------------------------
-- get blogpost ID
print("Creating a new blog post? Please insert the blog post ID")
io.write("> ")
id=io.read()
print("Please insert title of the post:")
title=io.read()
------------------------------------------------------------------------------------------------------------------------------
-- create blog core file
print("1 - Creating a new blog post HTML file...")
command="cp blogcore.html ".. tostring(id).. ".html"
if file_exists(tostring(id)..".html") then
	print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
	print("! W A R N I N G: File "..tostring(id)..".html already exists!")
	print("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
end
print("Execute wish for: '".. command.."' Would you like to continue? [Y/N]")
agree=io.read()
if agree=="y" or agree=="Y" then
	agree=true
else
	agree=false
	print("Aborted!")
																													return 1;
end
if agree then
	os.execute(command)
end

------------------------------------------------------------------------------------------------------------------------------
-- edit file
print("2 - Update index.html")
command="cp index.html index-BACKUP.html"
print("Would you like to continue backing up index.html to index-BACKUP.html? ("..command..") [Y/N]")
agree=io.read()
if agree=="y" or agree=="Y" then
	agree=true
else
	agree=false
	print("Aborted!")
																													return 1;
end
if agree then
	os.execute(command)
end

------------------------------------------------------------------------------------------------------------------------------
-- 2.1 actually updating index file

print("Would you like to update the index.html file? [Y/N]")

agree=io.read()
if agree=="y" or agree=="Y" then
	agree=true
else
	agree=false
	print("Aborted!")
																													return 1;
end
if agree then
	updateFile("index.html", '		<a href="'..tostring(id)..'.html">* '..tostring(id)..' - '..title..' ['..os.date("%d.%m.%Y, %H:%M")..'] </a><br>')
end
print("Would you like to see the updated file? [Y/N]")
agree=io.read()
if agree=="y" or agree=="Y" then
	agree=true
else
	agree=false
	print("Aborted!")
end
if agree then
	print("-=-=-=-=-=-Contents-=-=-=-=-=-")
	os.execute("cat index.html")
	print("-=-=-=-=-=-The end!-=-=-=-=-=-")
end
------------------------------------------------------------------------------------------------------------------------------
-- 2.2 Update the n.html file
print("Add blog post's title to the document...")
updateFile(tostring(id)..".html", [[
	<title>Blogs - ]]..id..[[</title>
	<div class="body">
		<p style="text-align:left"><a href="index.html" style="text-align:left; text-decoration:none;"><-- Back to blogs</a></p>
		<h1>]]..id.." - "..title..[[</h1>
    </div>
	<p style="text-align:right;">- MrVollbart ]]..os.date("%d.%m.%Y, %H:%M")..[[</p>
	<br>
	<br>
	<br>
	<br>]])


print("Now edit the file!")
os.execute(EDITOR.." "..id..".html")


------------------------------------------------------------------------------------------------------------------------------
-- END

																													return 0;
end

main()
