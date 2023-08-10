class Nameable
  def correct_name
    raise NotImplementedError, "#{self.class} has not implemented method #{__method__}"
  end
end

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'unknown', parent_permission: true)
    super()
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def can_use_services?
    return true if @age >= 18 || @parent_permission == true

    false
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

class BaseDecorator < Nameable
  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable
  end
end

class CapitalizedDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.upcase
  end
end

class TrimmerDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name[0, 10]
  end
end

person = Person.new(22, 'maximilianus')
person.correct_name
capitalized_person = CapitalizedDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
