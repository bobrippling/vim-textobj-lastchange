" textobj-lastchange - Text objects for the last change ('[, '])

function! textobj#lastchange#I()
	let start = getpos("'[")
	let end = getpos("']")
	let type = getregtype()

	return [type, start, end]
endfunction

function! textobj#lastchange#A()
	let [type, start, end] = LastChangeI()

	if type ==# 'v'
		" extend to start/end of lines
		let start[2] = 1
		let end[2] = len(getline(end[1]))

	elseif type ==# 'V'
		" extend into whitespace lines
		while start[1] > 1 && len(getline(start[1])) is 0
			let start[1] -= 1
		endwhile

		while end[1] < line('$') && len(getline(end[1])) is 0
			let end[1] += 1
		endwhile
	endif

	return [type, start, end]
endfunction
