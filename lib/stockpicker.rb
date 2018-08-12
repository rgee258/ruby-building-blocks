def stock_picker(stock_prices)
	curr_index = 0
	next_index = 0
	buy = 0
	sell = 0
	best = -1000
	buy_index = 0
	sell_index = 0

	while (curr_index < stock_prices.size - 1)
		buy = -1 * stock_prices[curr_index]
		next_index = curr_index + 1
		while (next_index < stock_prices.size)
			sell = stock_prices[next_index]
			if (buy + sell > best)
				best = buy + sell
				buy_index = curr_index
				sell_index = next_index
			end
			next_index += 1
		end
		curr_index += 1
	end

	best_days = [buy_index, sell_index]
end

puts "Let's pick stocks! Enter your stock prices using commas (,) over as many days as you want."
stocks = gets.chomp.split(",")
stocks.map! {|x| x.to_i}
puts stock_picker(stocks)