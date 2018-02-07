module Ferret
  # Points to something related to the code at this point.
  class Reference
    include Comparable

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
    alias eql? ==

    def hash
      self.class.hash ^ name.hash
    end

    def <=>(other)
      cmp = type <=> other.type
      if cmp == 0
        name <=> other.name
      else
        cmp
      end
    end
  end
end