require './person'

# Represents a student subclass with a specific specialization.
class Student < Person
  attr_accessor :name
  attr_reader :classroom

  def initialize(age, classroom, name = 'unknown', parent_permission: true)
    super(age, name, parent_permission)
    @classroom = classroom
  end

  def classroom=(classroom)
    @classroom = classroom
    @classroom.students << self unless @classroom.students.include?(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
