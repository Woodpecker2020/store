class Movie < Product
  attr_reader :title, :year, :director
  attr_writer :title, :year, :director

  # В конструкторе класса Movie вызовем конструктор класса-родителя Product,
  # он заполнит переменные экземпляра @price и @amount, а остальные поля,
  # специфичные только для фильма, заполним мы самостоятельно.
  def initialize(params)
    super

    @title = params[:title]
    @year = params[:year]
    @director = params[:director]
  end

  # Метод to_s возвращает строку с описанием фильма и дергает родительский метод
  # to_s, чтобы склеить эту строку с ценой и остатком.
  def to_s
    "Фильм «#{@title}», #{@year}, реж. #{@director}, #{super}"
  end

  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
      title: lines[0],
      director: lines[1],
      year: lines[2],
      price: lines[3].to_i,
      amount: lines[4].to_i
    )
  end
end
