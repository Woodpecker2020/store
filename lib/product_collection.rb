class ProductCollection
  # Создадим константу со всеми возможными типами продуктов. Это массив,
  # элементы которого — ассоциативные массивы с название папки (где лежат
  # файлы этого типа) и ссылкой на класс.
  PRODUCT_TYPES = [
    {dir: 'books', class: Book},
    {dir: 'disks', class: Disk},
    {dir: 'movies', class: Movie}
  ]

  # Конструктор коллекции принимает на вход массив продуктов, но если ничего не
  # передали на вход, то он записывает в переменную экземпляра @products пустой
  # массив.
  def initialize(products = [])
    @products = products
  end

  def self.from_dir(dir_path)
    products = []

    PRODUCT_TYPES.each do |hash|
      product_dir = hash[:dir]
      product_class = hash[:class]

      Dir["#{dir_path}/#{product_dir}/*.txt"].each do |file_name|
        products << product_class.from_file(file_name)
      end
    end

    self.new(products)
  end

  # Простой метод, чтобы достать все продукты коллекции
  def to_a
    @products
  end

  # Метод sort! меняет экземпляр класса ProductCollection (меняет порядок)
  # продуктов в коллекции, поэтому он назван с восклицательным знаком. Этот
  # метод принимает на вход ассоциативный массив, в котором могут быть два
  # ключа: :by и :order. Например, чтобы отсортировать продукты по возрастанию
  # цены, можно вызвать этот метод так:
  #
  # collection.sort!(by: :price, order: :asc)
  def sort!(params)
    # Делает выбор по параметру by
    case params[:by]
    when :title
      # Если запросили сортировку по наименованию
      @products.sort_by! { |product| product.to_s }
    when :price
      # Если запросили сортировку по цене
      @products.sort_by! { |product| product.price }
    when :amount
      # Если запросили сортировку по количеству
      @products.sort_by! { |product| product.amount }
    end

    # Если запросили сортировку по возрастанию
    @products.reverse! if params[:order] == :desc

    # Возвращаем ссылку на экземпляр, чтобы у него по цепочке можно было вызвать
    # другие методы.
    self
  end
end
