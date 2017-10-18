Capybara.javascript_driver = :poltergeist
  options = { js_errors: false, js: true , timeout: 60, phantomjs_logger: StringIO.new, logger: nil, :phantomjs_options => ['--debug=no', '--ignore-ssl-errors=yes', '--ssl-protocol=TLSv1','--load-images=no',"--cookies-file=cookies.txt"], :debug => false }
  Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new app, options
end