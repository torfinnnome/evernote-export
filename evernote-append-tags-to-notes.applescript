tell application "Evernote"
        -- This tiny scripts appends tags, as hashtags, to your Evernote notes.
        -- Warning: Tags with spaces are treated just as tags without spaces.
	-- Inspired by http://stackoverflow.com/a/31709089
	-- By Torfinn Nome, 2016
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
			set outputTags to outputTags & "#" & currentTag & " "
		end repeat
		set outputTags to outputTags & "</pre>"
		
		-- Append tags to note		
		append n html outputTags
		-- Or, if you prefer, append tags to title
		--set title of n to (title of n) & " " & outputTags
	end repeat
end tell
