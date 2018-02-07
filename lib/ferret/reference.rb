module Ferret
  # Points to something related to the code at this point.
  class Reference
    attr_reader :name

    abstract :url

    abstract :type

    def initialize(name)
      @name = name
      freeze
    end

    def ==(other)
      other.class == self.class && other.name == name
    end
  end
end