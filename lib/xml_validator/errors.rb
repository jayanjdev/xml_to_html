class Errors
  attr_reader :errors
  
  def initialize()
    @errors = []
  end

  def add(a)
    errors << a
  end

  def each(&block)
    errors.each do |e|
      yield(e)
    end
  end

  def empty?
    errors.empty?
  end

  def any?
    !empty?
  end
end
