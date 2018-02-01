class Numeric
  def seconds
    self
  end
  alias second seconds

  def minutes
    self * 60
  end
  alias minute minutes

  def hours
    minutes * 60
  end
  alias hour hours

  def days
    hours * 24
  end
  alias day days

  def weeks
    days * 7
  end
  alias week weeks

  def months
    days * 30
  end
  alias month months

  def years
    days * 365
  end
  alias year years

  def ago
    Time.now - self
  end

  def from_now
    Time.now + self
  end
end