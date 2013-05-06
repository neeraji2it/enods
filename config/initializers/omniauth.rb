Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '359071230859326', '8fb56ca5b9abe20737ba930b6260206a', :scope => 'email,publish_actions,offline_access'
  provider :twitter, 'wkSR9O44uuC6bdXshxDFg', 'hf3qQNEEF94f1OiURoNCa3LRjpEwq3bynXzC5BWvQ'
end