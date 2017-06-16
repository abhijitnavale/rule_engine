require 'json'
require 'yaml'
require 'date'
  
class Engine
  RAW_DATA_FILE = 'data/raw_data.json'.freeze
  RULES_FILE = 'config/rules.yml'.freeze
  
  INTEGER_TYPE = 'Integer'.freeze
  STRING_TYPE = 'String'.freeze
  DATETIME_TYPE = 'Datetime'.freeze

  DATETIME_FORMAT = '%Y-%m-%d %H:%M:%S'
  
  def initialize
  end

  def read_data_stream
    file = File.read(RAW_DATA_FILE)
    @data_stream = JSON.parse(file)
  end

  def read_rules
    @rules = YAML.load_file(RULES_FILE)

    # create list of signals who has rules set for them
    @rule_set = []    
    @rules.keys.each do |r|
      @rule_set.push(r)
    end
  end

  def apply_rules
    @data_stream.each do |stream|
      signal = stream['signal']
      # check if rule for this signal exist or not
      if (@rule_set.include? signal)
        process_rule(stream)
      end
    end
  end

  def process_rule(input_signal)
    signal = input_signal['signal']
    input_type = input_signal['value_type']

    # check if rule exist for this data type and signal combination
    if rule_exists(signal, input_type)
      # if exist call respective rule function
      case input_type
      when INTEGER_TYPE
        apply_integer_rule(input_signal)
      when STRING_TYPE
        apply_string_rule(input_signal)
      when DATETIME_TYPE
        apply_date_rule(input_signal)
      else
        puts 'ERROR! WRONG TYPE.'
      end
    end
  end

  def rule_exists(signal, input_type)
    sub_hash = @rules["#{signal}"]
    
    if (@rules.key?(signal) && sub_hash.key?(input_type))
      return true
    else
      return false
    end
  end

  def apply_integer_rule(input_signal)
    set_common_values(input_signal, INTEGER_TYPE)

    # execute the mathematical operation
    success = @value.to_f.send(@op, @ref_value.to_f)

    puts "FAILED: #{input_signal}" if not success
  end

  def apply_string_rule(input_signal)
    set_common_values(input_signal, STRING_TYPE)

    # execute the string operation
    success = @value.send(@op, @ref_value)

    puts "FAILED: #{input_signal}" if not success
  end

  def apply_date_rule(input_signal)
    puts '########################'
    puts input_signal
    set_common_values(input_signal, DATETIME_TYPE)
    puts @key
    puts @rule
    puts @value
    puts @op
    puts @ref_value
    puts "Operation: #{@value} #{@op} #{@ref_value}"
    if @op == 'in future'
      t = DateTime.strptime(@value, DATETIME_FORMAT)
      puts t.to_date.inspect
      t.to_date.future?
    end
    # result = value.to_f.send(op, ref_value.to_f)
    # puts "RESULT #{result}"

    # puts "FAILED: #{input_signal}" if not result
    puts '========================='
  end

  def set_common_values(input_signal, data_type)
    @key = input_signal['signal']
    @rule = @rules[@key][data_type]
    @value = input_signal['value']

    if data_type == DATETIME_TYPE
      @op = @rule['rule']
    else
      @op = @rule['rule'].split(" ")[1]
    end
    
    @ref_value = @rule['rule'].split(" ")[2] # reference value
  end
end
