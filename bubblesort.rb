def bubble_sort(unsorted)
	sorted = false
	until (sorted) do
		complete = true
		for x in 0..(unsorted.length() - 2) do
			puts "Comparing #{unsorted[x]} and #{unsorted[x+1]}"
			puts "#{unsorted[x] <=> unsorted[x+1]}"
			if ((unsorted[x] <=> unsorted[x+1]) > 0)
				unsorted[x], unsorted[x+1] = unsorted[x+1], unsorted[x]
				complete = false
			end
			puts "Array state: #{unsorted}"
		end
		if complete
			sorted = true
		end
	end
	unsorted
end

def bubble_sort_by(unsorted)
	sorted = false
	until (sorted) do
		complete = true
		for x in 0..(unsorted.length() - 2) do
			puts "Comparing #{unsorted[x]} and #{unsorted[x+1]}"
			puts yield(unsorted[x],unsorted[x+1])
			if (yield(unsorted[x],unsorted[x+1]) > 0)
				unsorted[x], unsorted[x+1] = unsorted[x+1], unsorted[x]
				complete = false
			end
			puts "Array state: #{unsorted}"
		end
		if complete
			sorted = true
		end
	end
	unsorted
end


puts "Let's bubble sort an array!"
puts "Enter a set of data values for your array using commas(,)."
input = gets.chomp.split(",")

puts "Regular bubble sort: #{bubble_sort(input)}"
puts "Bubble sort with static array and passed in block: #{bubble_sort_by(["hi","hello","hey"]) do |left,right|
	left.length - right.length
end}"
puts "Bubble sort your input and passed in block: #{bubble_sort_by(input) do |left,right|
	left.length - right.length
end}"