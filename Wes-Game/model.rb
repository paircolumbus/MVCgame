class Wine
  attr_reader :name, :type, :comments, :rating
  def initialize args
    @name = args[:name]
    @type = args[:type]
    @comments = args[:comments]
    @rating = args[:rating]
  end
end

class List
  attr_reader :wines
  def initialize
    @wines = []
  end

  def add_wine(input)
    @wines << Wine.new(input)
  end

  def delete_wine(name)
    @wines.delete_if { |n| n.name == name }
  end

end
