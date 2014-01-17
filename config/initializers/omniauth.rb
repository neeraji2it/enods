Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '489309741123184', 'af02149e8eda81abc3249708f3aba81b', {:scope => 'email,publish_actions,offline_access'} if Rails.env == 'development'
  provider :facebook, '359071230859326', '8fb56ca5b9abe20737ba930b6260206a', {:scope => 'email,publish_actions,offline_access'} if Rails.env == 'production'
  provider :twitter, '5tvBo9ZJsphDXAEiT6SDDA', 'MOqoy57FHqTWqRJ25MzkLg8sMqgRZMEuKufyjxVZA'
  provider :linkedin, '2ezj9y3wnvbr', 'GbuRrOHFDrfTUT8n'
  provider :yahoo, 'dj0yJmk9UWNSek83bXVKbERYJmQ9WVdrOVVHNDBSMDVDTnpZbWNHbzlOemczTnpBeU9EWXkmcz1jb25zdW1lcnNlY3JldCZ4PTY3', '1e0e075c9acd828ecfc9187d46096c4da645fc41'
  provider :google_oauth2, '346351112550.apps.googleusercontent.com', 'BX6eBpvrb5_yID4e9-kEMZZB', {access_type: 'online', approval_prompt: ''}
end