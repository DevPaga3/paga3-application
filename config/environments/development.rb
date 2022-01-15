Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.perform_deliveries = true

  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: 587,
    domain: 'localhost:3000',
    user_name: "apikey",
    password: Rails.application.credentials.sendgrid[:access_token], #ENV["SENDGRID_ACCESS_TOKEN"],
    authentication: :login,
    enable_starttls_auto: true
  }
  
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker


  #ActionMailer::Base.smtp_settings = {
  #  address: 'smtp.sendgrid.net',
  #  port: 587,
  #  domain: 'paga3.com',
  #  user_name: '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', #"suporte@paga3.com",
  #  password: '4RNgHTK-TImey06ob34GjQ',#"ANGOLA12345paga3#",
  #  authentication: :login,
  #  enable_starttls_auto: false
  #}


end