ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  :access_key_id     => Rails.application.config.aws_access_key_id,
  :secret_access_key => Rails.application.config.aws_secret_access_key