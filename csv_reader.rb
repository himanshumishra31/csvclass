class CsvReader
  FILE_EXTENSION_VALIDATOR_REGEX = /(.csv)$/
  FILENAME_UPPERCASE_VALIDATOR_REGEX = /\A[A-Z]/
  FILENAME_SPACE_VALIDATOR_REGEX = /\s/
  attr_accessor :classname, :data_array, :klass

  def initialize(pathname)
    self.classname = File.basename(pathname,'.csv')
    raise FileExtensionError, 'The file extension is not valid' unless FILE_EXTENSION_VALIDATOR_REGEX.match?(pathname)
    raise FileNameError, 'File name does not start with uppercase letter' unless FILENAME_UPPERCASE_VALIDATOR_REGEX.match?(classname)
    raise FileNameError, 'File name contains space' if FILENAME_SPACE_VALIDATOR_REGEX.match?(classname)
  end

  def execute
    self.klass = CsvClassCreator.new(classname)
    self.data_array = read
    klass.create_method_object(data_array)
    display_values
  end

  def display_values
    klass.array_object.each do |obj_id|
      data_array.headers.each do |method_name|
        puts "#{method_name} : #{obj_id.public_send(method_name)}"
      end
      puts "End of entry\n "
    end
    puts 'End of a csv file'
  end

  def read
    CSV.read("#{classname}.csv", headers: true)
  end
end
