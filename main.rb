require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/disk'
require_relative 'lib/movie'
require_relative 'lib/product_collection'

collection = ProductCollection.from_dir("#{__dir__}/data")
collection.sort!(by: :title)

basket = []

loop do
  puts
  puts "Что хотите купить:"
  puts

  collection.to_a.each.with_index(1) do |product, index|
    puts "#{index}. #{product}"
  end
  puts "0. Выход"
  puts
  print "> "

  choice_user = $stdin.gets.to_i

  if (1..collection.to_a.size).include?(choice_user)
    if collection.to_a[choice_user - 1].amount > 0
      basket << collection.to_a[choice_user - 1]
    end
    collection.to_a[choice_user - 1].amount -= 1
    puts
    puts "Вы выбрали: #{collection.to_a[choice_user - 1]}"
  elsif choice_user.zero?
    break
  end
end

puts
puts "Ваша корзина:"
puts
puts basket

prices = basket.to_a.map { |product| product.price }

puts
puts "Стоимость корзины: #{prices.sum} руб."
