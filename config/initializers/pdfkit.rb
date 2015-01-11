PDFKit.configure do |config|
  if File.executable? '~/.apt/usr/local/bin/wkhtmltopdf'
    config.wkhtmltopdf = '~/.apt/usr/local/bin/wkhtmltopdf'
  end
end