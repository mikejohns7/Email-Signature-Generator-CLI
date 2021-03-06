require_relative 'templates'

class Signature
  include Templates
  attr_reader :file_name

  def initialize(options = {})
    puts "\n\nGenerating HTML File".blue
    @first = options[:first].capitalize
    @last = options[:last].capitalize
    @title = options[:title].capitalize
    @company = options[:company].capitalize
    @phone = options[:phone]
    @email = options[:email]
    @twitter = options[:twitter] ? options[:twitter].downcase : false
    @image_link = options[:image_link]
    create_file
    generate_html
    close_file
    move_file_to_desktop
    puts "SUCCESS: #{@file_name}".green
  end

  private

  def create_file
    @file_name = "#{@first.downcase}-#{@last.downcase}-signature.html"
    @signature_file = File.open(@file_name, "w")
  end

  def close_file
    @signature_file.close
  end

  def move_file_to_desktop
    system("mv #{@file_name} ~/Desktop/")
  end

  def generate_html
    if @twitter != false
      @signature_file.puts generate_with_twitter
    else
      @signature_file.puts generate_without_twitter
    end
  end
end
