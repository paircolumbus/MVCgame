require 'faker'
require 'pry'
require 'date'

class NoPeopleError < StandardError; end

class Attendance
  @@primary_id = 0
  attr_reader :id, :date, :attended

  def initialize args
    @id = Attendance.fetch_id
    @person = args[:person]
    @date = Date.parse args.fetch(:date, Date.today.to_s)
    @attended = nil
  end

  def to_s
    if present?
      presence = "\u2705"
    elsif absent?
      presence = "\u274C"
    else
      presence = "\u2753"
    end
    "#{presence}  #{@id.to_s.rjust(2)} || #{@date} - #{@person.name}(#{@person.id})"
  end

  def person_id
    @person.id
  end

  def mark_present
    @attended = true
  end

  def mark_absent
    @attended = false
  end

  def present?
    @attended == true
  end

  def absent?
    @attended == false
  end

  private

  def self.fetch_id
    @@primary_id += 1
  end
end

class Person
  @@primary_id = 0
  attr_reader :id, :name, :attendances

  def initialize args
    @id = Person.fetch_id
    @name = args[:name]
  end

  def to_s
    "#{id} || #{name}"
  end

  private

  def self.fetch_id
    @@primary_id += 1
  end
end

class List
  attr_reader :attendances, :people

  def initialize
    @attendances = []
    @people = []
    populate_dummy_people
    populate_dummy_attendances
  end

  def todays_attendances
    @attendances.select { |att| att.date == Date.today }
  end

  def add_person(input)
    @people << Person.new(input)
  end

  def add_attendance(input)
    input[:person] = person_by_id(input[:person].to_i)
    @attendances << Attendance.new(input)
  end

  def mark_present(id)
    attended_item = @attendances.select { |attendance| attendance.id == id }
    fail "No item matching that id" unless attended_item
    attended_item[0].mark_present
  end

  def mark_absent(id)
    absent_item = @attendances.select { |attendance| attendance.id == id }
    fail "No item matching that id" unless absent_item
    absent_item[0].mark_absent
  end

  def person_by_id(id)
    @people.find {|person| person.id == id }
  end

  def delete_person(id)
    @attendances.delete_if { |n| n.person_id == id }
    @people.delete_if { |n| n.id == id }
  end

  def delete_attendance(id)
    @attendances.delete_if { |n| n.id == id }
  end

  def populate_dummy_people
    5.times do
      add_person(name: Faker::Name.name)
    end
  end

  def populate_dummy_attendances
    raise NoPeopleError, "There are no people" if @people.empty?
    10.times do
      add_attendance(person: @people.sample.id, date: Date.today.to_s)
    end
  end
end
