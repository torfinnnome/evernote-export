tell application "Evernote"
	set notesToRename to (notes in notebook "Inbox")

	repeat with n in notesToRename
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
		-- Or, if you prefere, append tags to title
		--set title of n to (title of n) & " " & outputTags
	end repeat
end tell
