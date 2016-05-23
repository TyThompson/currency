##Code to make tests pass
require "pry"

class Currency
attr_reader :amount, :denomination
	def initialize(amount, currency)
		@amount = amount
		@denomination = currency
	end
	def times(n)
		Currency.new(@amount * n, @denomination)
	end
	def plus(c)
		if c.denomination != @denomination
			c.to(@denomination)
		end
		Currency.new(@amount + c.amount, @denomination)
	end
	def + c
		if c.denomination != @denomination
			c.to(@denomination)
		end
		Currency.new(@amount + c.amount, @denomination)
	end
	def minus(c)
		if c.denomination != @denomination
			c.to(@denomination)
		end
		Currency.new(@amount - c.amount, @denomination)
	end
	def - c
		if c.denomination != @denomination
			c.to(@denomination)
		end
		Currency.new(@amount - c.amount, @denomination)
	end
	def == c
		@amount == c.amount && @denomination == c.denomination
	end
	def convert_to_usd(amount, currency)
		case currency
		when :gbp
			@amount = (@amount * 1.45).round(2)
			@denomination = :usd
		when :euro
			@amount = (@amount * 1.12).round(2)
			@denomination = :usd
		else
			puts "USD error, Enter a valid currency"
		end
	end
	def convert_to_gbp(amount, currency)
		case currency
		when :usd
			@amount = (@amount * 0.69).round(2)
			@denomination = :gbp
		when :euro
			@amount = (@amount * 0.77).round(2)
			@denomination = :gbp
		else
			puts "GBP error, Enter a valid currency"
			puts @denomination
			puts @amount
		end
	end
	def convert_to_euro(amount, currency)
		case currency
		when :usd
			@amount = (@amount * 0.89).round(2)
			@denomination = :euro
		when :gbp
			@amount = (@amount * 1.29).round(2)
			@denomination = :euro
		else
			puts "euro error, Enter a valid currency"
		end
	end
	def to(currency)
		case currency
		when :usd
			convert_to_usd(@amount,@denomination)
		when :gbp
			convert_to_gbp(@amount,@denomination)
		when :euro
			convert_to_euro(@amount,@denomination)
		else
			puts "Enter a valid currency"
		end
		return self
	end
	def number_to_currency
		symbol =case @denomination
				when :usd 
					"$"
				when :gbp 
					"£"
				when :euro 
					"€"
				else
					"no currency"
				end
		return symbol+@amount.to_s
	end
end


a = Currency.new(5, :usd)
b = Currency.new(10, :usd)
c = Currency.new(5, :gbp)
d = Currency.new(5, :usd)


##Tests
puts a.amount == 5
puts a.denomination == :usd
puts a.times(4).amount
puts a.times(4).denomination
# a.times(4) == Currency.new(20, :usd)
puts a.plus(b).amount
puts a.plus(b).denomination 
# a.plus(b) == Currency.new(15, :usd)
puts b.minus(a).amount
puts b.minus(a).denomination
# b.minus(a) == Currency.new(5, :usd)
puts a.plus(c).denomination
puts a.plus(c).amount
# a.plus(c) == Currency.new(?, :usd) #$5+5GBP


# mathematical operators + - ==
puts a.== d 
puts a == d
# "20 USD to GBP, 13.8"
# Currency.new(20, :usd).to(:gbp)
puts Currency.new(20, :usd).to(:gbp).amount
puts Currency.new(20, :usd).to(:gbp).denomination
puts Currency.new(20, :usd).to(:gbp).number_to_currency


# initialize currency objects with a string Currencynew("$5") or Currency.parse("$5")
# allow users to convert: Currency.new(20, :usd).to(:gbp)
# level 3, automatically convert if user tries to add two different denomination
# b.amount == 7
# b.denomination == :gbp

