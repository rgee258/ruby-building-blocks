module Enumerable
	def my_each
		return to_enum(:my_each) unless block_given?
		for x in 0..self.length-1 do
			yield(self[x])
		end
		self
	end

	def my_each_with_index
		return to_enum(:my_each_with_index) unless block_given?
		output = {}
		for x in 0..self.length-1 do
			yield(self[x], x)
			output[self[x]] = x
		end
		output
	end

	def my_select
		return to_enum(:my_select) unless block_given?
		output = []
		for x in 0..self.length-1 do
			if (yield(self[x]))
				output.push(self[x])
			end
		end
		output
	end

	missing_block = Proc.new { |obj|
		obj
	}

	def my_all? (args = nil)
		if (block_given?)
			for x in 0..self.length-1 do
				if (yield(self[x]) == false)
					return false
				end
			end
		else
			if (args.nil?)
				for x in 0..self.length-1 do
					if (self[x].nil? || self[x] == false)
						return false
					end
				end
			else
				for x in 0..self.length-1 do
					if (args === self[x])
					else
						return false
					end
				end
			end
		end
		true
	end

	def my_any? (args = nil)
		if (block_given?)
			for x in 0..self.length-1 do
				if (yield(self[x]) == true)
					return true
				end
			end
		else
			if (args.nil?)
				for x in 0..self.length-1 do
					if (self[x] == true)
						return true
					end
				end
			else
				for x in 0..self.length-1 do
					if (args === self[x])
						return true
					end
				end
			end
		end
		false
	end

	def my_none? (args = nil)
		if (block_given?)
			for x in 0..self.length-1 do
				if (yield(self[x]) == true)
					return false
				end
			end
		else
			if (args.nil?)
				for x in 0..self.length-1 do
					if (self[x] == true)
						return false
					end
				end
			else
				for x in 0..self.length-1 do
					if (args === self[x])
						return false
					end
				end
			end
		end
		true
	end

	def my_count(args = nil)
		output = 0;
		if (block_given?)
			for x in 0..self.length-1 do
				if (yield(self[x]) == true)
					output += 1
				end
			end
		elsif (args.nil?)
			return self.length
		else
			for x in 0..self.length-1 do
				if (self[x] == args)
					output += 1
				end
			end
		end
		output
	end

	def my_map(some_proc = nil)
		#return to_enum(:my_select) unless block_given?
		output = []
		if (some_proc.nil?)
			for x in 0..self.length-1 do
				output.push(yield(self[x]))
			end
		else
			for x in 0..self.length-1 do
				output.push(some_proc.call(self[x]))
			end
		end
		output
	end

	def my_inject(initial = nil, sym = nil)
		usable = self.to_a
		output = nil
		if (block_given?)
			for x in 0..usable.length-1 do
				if (x == 0)
					output = usable[x]
				else
					output = yield(output, usable[x])
				end
			end
			if (initial.nil? == false)
				output = yield(output, initial)
			end
		else
			if (initial.is_a? Symbol)
				for x in 0..usable.length-1 do
					if (x == 0)
						output = usable[x]
					else
						# Send invokes the method based on the symbol
						output = output.send(initial, usable[x])
					end
				end
			elsif (initial.nil? == false && sym.nil? == false)
				for x in 0..usable.length-1 do
					if (x == 0)
						output = usable[x]
					else
						output = output.send(sym, usable[x])
					end
				end
				output = output.send(sym, initial)
			end
		end
		output
	end
end

def multiply_els(new_arr)
	new_arr.my_inject(:*)
end

my_proc = Proc.new { |elem|
	elem + elem
}

# Commented outputs, uncomment whichever method to test
# Further testing can be done using the Enumerables method details found in the Ruby docs

#arr_example = ["here","we","go","again"]
#num_arr_example = [1,2,4,2]

#puts "my_each: #{arr_example.my_each { |elem| puts "#{elem}" }}"
#puts "my_each_with_index: #{arr_example.my_each_with_index { |elem, index| puts "#{elem}: index #{index}" }}"
#puts "my_select: #{arr_example.my_select {|elem| elem.is_a? String}}"
#puts "my_all? true: #{arr_example.my_all? {|elem| elem.length > 1}}"
#puts "my_all? false: #{arr_example.my_all? {|elem| elem.length > 2}}"
#puts "my_any? true: #{arr_example.my_any? {|elem| elem == "here"}}"
#puts "my_any? false: #{arr_example.my_any? {|elem| elem == "not here"}}"
#puts "my_none? true: #{arr_example.my_none? {|elem| elem == "none here"}}"
#puts "my_none? false: #{arr_example.my_none? {|elem| elem == "here"}}"
#puts "my_count nil args: #{num_arr_example.my_count}"
#puts "my_count with args: #{num_arr_example.my_count(2)}"
#puts "my_count with block: #{num_arr_example.my_count{|elem| elem < 4}}"
#puts "my_map with nums and block: #{num_arr_example.my_map {|elem| elem*elem}}"
#puts "my_map with strings and block: #{arr_example.my_map {|elem| elem+"!"}}"
#puts (5..10).my_inject(2) {|sum, n| sum + n}
#puts (5..10).my_inject(10, :+)
#puts (5..10).my_inject(:+)
#puts multiply_els([2,4,5])
#puts "my_map with proc: #{num_arr_example.my_map(my_proc)}"
#puts "my_map with proc and block: #{num_arr_example.my_map(my_proc) {|elem| elem+elem}}"
