Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '489309741123184', 'af02149e8eda81abc3249708f3aba81b', {:scope => 'email,publish_actions,offline_access'} if Rails.env == 'development'
  provider :facebook, '359071230859326', '8fb56ca5b9abe20737ba930b6260206a', {:scope => 'email,publish_actions,offline_access'} if Rails.env == 'production'
  provider :twitter, 'wkSR9O44uuC6bdXshxDFg', 'hf3qQNEEF94f1OiURoNCa3LRjpEwq3bynXzC5BWvQ'
end