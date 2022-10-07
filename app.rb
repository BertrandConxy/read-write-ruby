require 'pdftotext'
require_relative './generate_pdf'

def app
    file_path = './HEADING.pdf'
    text_file = Pdftotext.text(file_path)
    input = gets.chomp
    file = File.open(text_file)
    file_data = file.readlines.map(&:chomp)
    $string  = ''
    file_data.each_with_index do |line, index|
        if line.include?(input)
            if $string.length > 0 &&  $string.include?(input)
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