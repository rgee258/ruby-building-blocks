def substrings(phrase, dictionary)
	list_of_substrings = {}
	dictionary.each { |word|
		word.downcase!
		if (phrase.downcase.scan(word).size > 0)
			list_of_substrings[word] = phrase.downcase.scan(word).size
		end
	}
	list_of_substrings
end

puts "Enter your dictionary values using commas (,) in between them."
dictionary_words = gets.chomp
puts "Now enter your string to test the dictionary values with."
input_string = gets.chomp

puts substrings(input_string, dictionary_words.split(","))