require './book'
require './rental'
require './person'
require './student'
require './teacher'

class App
  attr_accessor :books, :rentals, :people, :student, :teacher

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    person_type = person_type_input
    if person_type == 1
      person = create_student
    elsif person_type == 2
      person = create_teacher
    else
      puts 'Invalid input.'
      return
    end
    push_person_to_list(person)
    puts 'Person created successfully'
  end

  def person_type_input
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    gets.chomp.to_i
  end

  def create_student
    puts 'Age:'
    age = gets.chomp
    puts 'Name:'
    name = gets.chomp
    puts 'Has Parent Permission? [Y/N]:'
    parent_permission = gets.chomp.downcase == 'y'
    Student.new(age, name, parent_permission)
  end

  def create_teacher
    create_person_with_specialization(Teacher)
  end

  def create_person_with_specialization(person_class)
    puts 'Age:'
    age = gets.chomp
    puts 'Name:'
    name = gets.chomp
    puts 'Specialization:'
    specialization = gets.chomp
    person_class.new(age, name, specialization)
  end

  def push_person_to_list(person)
    @people.push(person)
  end

  def create_book
    title = user_input('Title:')
    author = user_input('Author:')

    book = Book.new(title, author)
    @books.push(book)

    puts 'Book created successfully'
  end

  def user_input(prompt)
    puts prompt
    gets.chomp
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    book = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id):'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person = gets.chomp.to_i

    puts 'Date (YYYY-MM-DD):'
    date = Date.parse(gets.chomp)

    rental = Rental.new(date, @books[book], @people[person])
    @rentals.push(rental)
    puts 'Rental created successfully'
  end

  def list_rentals_for_person
    puts 'ID of person:'
    person_id = gets.chomp.to_i
    rentals = @rentals.select { |rental| rental.person.id == person_id }
    puts 'Rentals:'
    rentals.each do |rental|
      puts "Date: #{rental.date}, Book: '#{rental.book.title}' by #{rental.book.author}"
    end
  end

  private :push_person_to_list, :create_teacher, :create_student, :person_type_input
end
