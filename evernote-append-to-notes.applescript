tell application "Evernote"
	-- This script appends tags, as hashtags, and creation- and modification date to your Evernote notes.
	-- Warning: Spaces in tags are replaced with "-".
	-- Inspired by http://stackoverflow.com/a/31709089
	-- By Torfinn Nome, 2016
	
	-- Replace space with this:
	set newDelimiter to "-"
	
	set notesToAppend to (notes in notebook "Inbox")
	-- set notesToAppend to every note of every notebook
	
	repeat with n in notesToAppend
		set tagList to {}
		set noteTags to (the tags of n)
		
		repeat with currentTag in noteTags
			if tagList does not contain name of currentTag then
				set the end of tagList to name of currentTag
			end if
		end repeat
		
		-- Tags:
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
		
		-- Dates:
		set creationDate to creation date of n
		set modificationDate to modification date of n
		
		set creationDateISO to my date_time_to_iso(creationDate)
		set modificationDateISO to my date_time_to_iso(modificationDate)
		
		set outputDates to "<pre>"
		set outputDates to outputDates & "Created: " & creationDateISO & "<br />"
		set outputDates to outputDates & "Modified: " & modificationDateISO
		set outputDates to outputDates & "</pre>"
		
		-- Append tags to note
		append n html outputTags
		-- Or, if you prefer, append tags to title
		--set title of n to (title of n) & " " & outputTags
		-- Append dates to note		
		append n html outputDates
		
		-- We want to keep the original modification date.
		set (modification date of n) to modificationDate
	end repeat
end tell

on date_time_to_iso(dt)
	set {year:y, month:m, day:d, hours:h, minutes:min, seconds:s} to dt
	set y to text 2 through -1 of ((y + 10000) as text)
	set m to text 2 through -1 of ((m + 100) as text)
	set d to text 2 through -1 of ((d + 100) as text)
	set h to text 2 through -1 of ((h + 100) as text)
	set min to text 2 through -1 of ((min + 100) as text)
	set s to text 2 through -1 of ((s + 100) as text)
	return y & "-" & m & "-" & d & "T" & h & ":" & min & ":" & s
end date_time_to_iso
