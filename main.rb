require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/movie'

movie_leon = Movie.new(price: 290, amount: 4)

puts "Фильм Леон стоит #{movie_leon.price} руб."
puts "Фильм Леон остался в количестве #{movie_leon.amount} шт."
