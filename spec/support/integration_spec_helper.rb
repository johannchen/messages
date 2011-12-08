module IntegrationSpecHelper
  def login_with_oauth(service = :facebook)
    visit "/auth/#{service}"
    User.last
  end
end

