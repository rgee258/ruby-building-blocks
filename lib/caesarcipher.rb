def caesar_cipher(text, shift_count, direction)
	alphabet = ("a".."z").to_a.join("")
	text = text.split("")

	# Use map! to modify the array values of text instead of mapping them to a new one
	text.map! { |x|
		# Check for any non-letter character with match, which does not return nil if it is
		if (!(x.match(/[^A-Za-z]/).nil?))
			# If it's not nil, then return the non-letter character
			x
		else
			# Check for caps
			is_capped = false
			if (x == x.upcase)
				is_capped = true
				x.downcase!
			end
			# Convert x into matching index val
			current_index = alphabet.index(x)
			if (direction == "right")
				current_index = (current_index + shift_count) % 26
			else
				current_index = (current_index - shift_count) % 26
			end
			x = alphabet[current_index]
			# Make cap again
			if (is_capped)
				x.upcase!
			end
			# Return conversion
			x
		end
	}

	text.join("")
end

puts "Enter whatever string you would like to use with the Caesar cipher."
input = gets.chomp
puts "Which direction would you like to shift? Enter left or right."
shift_direction = gets.chomp
shift_direction.downcase!
unless (shift_direction == "left" || shift_direction == "right")
	puts "Incorrect direction, please try again."
	exit
end
puts "How many times would you like to shift?"
shift_value = gets.chomp.to_i

puts caesar_cipher(input, shift_value, shift_direction)