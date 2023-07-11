class PdfManager
  def self.call()
  end

  def write(pdf_data)
    # Save the PDF data to a temporary file with a timestamp
    require "fileutils"

    timestamp = DateTime.now.strftime("%Y%m%d%H%M%S")
    temp_pdf_path = Rails.root.join("tmp", "pdf", "temp_#{timestamp}.pdf")

    # Create the directory if it doesn't exist
    FileUtils.mkdir_p(File.dirname(temp_pdf_path))
    
    File.open(temp_pdf_path, "wb") { |file| file << pdf_data }
    # Return the temporary file path
    return temp_pdf_path
  end
  def delete_file(file_path)
    puts file_path && File.exist?(file_path)
    File.delete(file_path) if file_path && File.exist?(file_path)
  end

  def html2pdf(html)
    url = ENV["REACT_APP_API_URL"]
    base_url = url.match(%r{^https?://[^/]+}).to_s
    absolute_html = Grover::HTMLPreprocessor.process html, base_url + "/", "http"
    grover = Grover.new(absolute_html)
    Grover.configure do |config|
      config.options = { format: "A5", print_background: true }
    end
    pdf_data = grover.to_pdf
    return pdf_data
  end
end
