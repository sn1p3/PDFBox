module PDFBox
  class Document
    attr_reader :path

    def initialize(path)
      @path = File.expand_path(path)
    end

    def text(options={})
      Tempfile.open(['pdfbox', '.txt']) do |file|
        PDFBox.cli.run_command 'ExtractText', path, file.path, options
        file.read
      end
    end
  end
end
