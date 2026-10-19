# Run the Program using
# ruby fix_firefox_pinned_shortcuts_urls.rb firefox_urls.json fixed_firefox_urls.json

require 'json'

# Helper method to parse text from a given file
def read_file(file_path)
  extension = File.extname(file_path).downcase

  case extension
  when '.txt'
    File.read(file_path)
  when '.json'
    File.read(file_path)
  else
    puts "Unsupported file format. Supported formats: .txt, .json"
    exit
  end
end

# Method to remove unnecessary spaces after 'https:' in URLs
def clean_urls(content)
  json_data = JSON.parse(content)

  json_data.each do |entry|
    if entry['url']
      entry['url'].gsub!('https: //', 'https://')
    end
  end

  json_data
end

# Method to write cleaned data to a JSON file
def write_json_file(data, output_file)
  File.open(output_file, 'w') do |f|
    f.write(JSON.pretty_generate(data))
  end
  puts "Output written to #{output_file}"
end

# Main program logic
def process_file(input_file, output_file)
  file_content = read_file(input_file)

  begin
    # Clean up URLs and create new JSON data
    cleaned_data = clean_urls(file_content)

    # Write the cleaned data into the output JSON file
    write_json_file(cleaned_data, output_file)
  rescue JSON::ParserError
    puts "Invalid JSON format in the input file."
  end
end

# Run the program
if ARGV.length != 2
  puts "Usage: ruby script.rb <input_file> <output_file>"
else
  input_file = ARGV[0]
  output_file = ARGV[1]

  process_file(input_file, output_file)
end
