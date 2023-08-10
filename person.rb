# Represent a super class from where teacher and student classes inherit
class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'unknown', parent_permission: true)
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def can_use_services?
    return true if @age >= 18 || @parent_permission == true

    false
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end
end
