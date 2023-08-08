# frozen_string_literal: true

# Represent a super class from where teacher and student classes inherit
class Person
  attr_accessor :name, :age
  attr_reader :id

  def initialize(name = 'unknown', age = nil, parent_permission: true)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end

  public

  def can_use_services?
    return true if @age >= 18 || @parent_permission == true

    false
  end
end
