module ToDo
  class Task
    attr_accessor :description

    def initialize(description)
      @description = description
    end
  end
end