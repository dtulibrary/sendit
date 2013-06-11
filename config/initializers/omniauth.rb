Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cas,
  :host => Rails.application.config.cas[:host],
  :ssl => true,
  :name => :dtu_cas
end

if Rails.application.config.stub_authentication
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:dtu_cas, {
                             :uid => "username",
                             :info => { :name => "Test User" },
                             :extra => {
                               :user => "username",
                             }
                           })
end
