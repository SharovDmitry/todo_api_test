Apipie.configure do |config|
  config.app_name                = "Todo API"
  config.api_base_url            = "/"
  config.doc_base_url            = "/docs"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.app_info                = "This app is token-based authenticable, so you should put aaccess-token, client and uid parameters in each request headers. Access-token header will change after each request."
end
