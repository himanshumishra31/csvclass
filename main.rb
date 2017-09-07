require_relative 'csv_reader'
require_relative 'csv_class_creator'
require_relative 'exception'
require 'csv'

# begin
  CsvReader.new('/Users/vins/Desktop/advcodes/Student.csv').execute
  p student = Student.new
  p student2 = Student.new
  CsvReader.new('/Users/vins/Desktop/advcodes/Person.csv').execute
  p person = Person.new
  p person2 = Person.new
# rescue StandardError => e
#   puts e.message
# end
