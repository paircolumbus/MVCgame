class Beer
  attr_reader :id, :name, :brewer, :rating

  def initialize args
    @id = args[:id]
    @name = args[:name]
    @brewer = args[:brewer]
    @rating = args[:rating]
  end

  def edit input
    @name = input[:name]
    @brewer = input[:brewer]
    @rating = input[:rating]
  end

  def to_s
    "##{@id} #{@name} - #{@brewer} (#{@rating} / 100)"
  end
end

class List
  attr_reader :beers

  def initialize
    @id = 0
    @beers = []
    populate
  end

  def add_beer input
    @beers << Beer.new(input.merge(generate_id))
  end

  def delete_beer id
    @beers.delete_if { |b| b.id == id }
  end

  def edit_beer input, id
    b = find_beer id
    fail "No beer matching id #{id}" unless b
    b.edit input
  end

  def find_beer id
    @beers.find { |b| b.id == id }
  end

  def sort_by_brewer!
    @beers.sort_by! { |b| b.brewer }
  end

  def sort_by_id!
    @beers.sort_by! { |b| b.id }
  end

  def sort_by_name!
    @beers.sort_by! { |b| b.name }
  end

  def sort_by_rating!
    @beers.sort_by! { |b| 100 - b.rating }
  end

  private

  def generate_id
    { id: @id += 1 }
  end

  def populate
    list = [
      { name: "Dortmunder Gold", brewer: "Great Lakes", rating: 95 },
      { name: "Fat Tire", brewer: "New Belgium", rating: 78 },
      { name: "Ohio Native Lager", brewer: "Sibling Revelry", rating: 83 },
      { name: "Inverness", brewer: "Columbus  Brewing Company", rating: 72 },
      { name: "Black & Tan", brewer: "Yuengling", rating: 80 },
    ]
    list.each { |b| add_beer(b) }
  end
end
