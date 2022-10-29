class Disk < Product
  attr_reader :title, :genre, :performer, :year
  attr_writer :title, :genre, :performer, :year

  # В конструкторе класса Book вызовем конструктор класса-родителя Product,
  # он заполнит переменные экземпляра @price и @amount, а остальные поля,
  # специфичные только для книги, заполним мы самостоятельно.
  def initialize(params)
    super

    @title = params[:title]
    @performer  = params[:performer]
    @genre = params[:genre]
    @year = params[:year]
  end

  # Метод to_s возвращает строку с описанием книги и дергает родительский метод
  # to_s, чтобы склеить эту строку с ценой и остатком.
  def to_s
    "Альбом #{@performer} - «#{@title}», #{@genre}, #{@year}, #{super}"
  end

  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
      title: lines[0],
      performer: lines[1],
      genre: lines[2],
      year: lines[3],
      price: lines[4].to_i,
      amount: lines[5].to_i
    )
  end
end
