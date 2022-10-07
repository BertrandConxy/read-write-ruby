class GeneratePdf
    def generate(string, index)
        new_pdf = File.new("doc#{index}.pdf", "w")
        string.split('.').each do |line|
            File.write(new_pdf, "#{line}.\n", mode: "a+")
        end
        new_pdf.close
    end
end