class Class
  private
  # Creates a place-holder method that is expected to be overridden.
  # This simulates having abstract methods in Ruby.
  # If the method is not overridden by a sub-class and the method is called,
  # then a +NoMethodError+ is raised.
  # @param method [Symbol] Name of the method to define.
  # @return [void]
  # @!visibility public
  def abstract(method)
    define_method(method) do
      raise NoMethodError, "Unimplemented abstract method #{self.class}##{method} called"
    end
  end
end