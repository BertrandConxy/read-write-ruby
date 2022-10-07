require_relative './generate_pdf'
require 'pdf/reader'

def app
    puts "Enter pdf file path"
    pdf_input = gets.chomp

    puts "Enter grouping keyword"
    search_input = gets.chomp

    reader = PDF::Reader.new(pdf_input)

    new_file = File.new("file.txt", "w")

    reader.pages.each do |page|
        File.write(new_file, "#{page.text}.", mode: "a+")
    end

    file = File.open(new_file)
    file_data = file.readlines.map(&:chomp)
    $string  = ''
    file_data.each_with_index do |line, index|
        if line.include?(search_input)
            if $string.length > 0 &&  $string.include?(search_input)
                generate_pdf = GeneratePdf.new
                generate_pdf.generate($string, index)
                $string = ''
            end
            
        end
        if (index == file_data.length - 1)
            $string << file_data[index]
            generate_pdf = GeneratePdf.new
            generate_pdf.generate($string, index)
        end

         $string << line
    end

    file.close
end

app()