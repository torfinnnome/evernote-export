tell application "Evernote"
	-- This tiny script appends tags, as hashtags, to your Evernote notes.
	-- Warning: Spaces in tags are replaced with "-" (or whatever you choose).
	-- Inspired by http://stackoverflow.com/a/31709089
	-- By Torfinn Nome, 2016
	
	-- Replace space with this:
	set newDelimiter to "-"
	
	set notesToAppend to (notes in notebook "Inbox")
	
	repeat with n in notesToAppend
		set tagList to {}
		set noteTags to (the tags of n)
		
		repeat with currentTag in noteTags
			if tagList does not contain name of currentTag then
				set the end of tagList to name of currentTag
			end if
		end repeat
		
		set outputTags to "<pre>"
		repeat with currentTag in tagList
			
			-- Replace space with dash.
			set my text item delimiters to " "
			set split_list to every text item of currentTag
			set my text item delimiters to newDelimiter
			set currentTagReplace to (split_list as text)
			
			set outputTags to outputTags & "#" & currentTagReplace & " "
		end repeat
		set outputTags to outputTags & "</pre>"
		
		-- Append tags to note		
		append n html outputTags
		-- Or, if you prefer, append tags to title
		--set title of n to (title of n) & " " & outputTags
	end repeat
end tell

