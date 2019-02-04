require "open3"
require "pdfbox/version"
require "pdfbox/document"
require "pdfbox/cli"

module PDFBox
  def self.text(path, options={})
    Document.new(path).text(options)
  end

  def self.cli
    @cli ||= CLI.new
  end
end
