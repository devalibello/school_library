require './nameable'
require './decorators'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id

  def initialize(age, name = 'unknown', _parent_permission: true)
    @age = age
    @name = name
    @id = Random.rand(1..1000)
    @rentals = []
    super()
  end

  def can_use_services?
    return true if @age >= 18 || @parent_permission == true

    false
  end

  def add_rental(date, book)
    Rental.new(date, book, self)
  end

  def correct_name
    @name
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end
end
