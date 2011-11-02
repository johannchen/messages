module IntegrationSpecHelper
  def login_with_oauth(service = :twitter)
    visit "/auth/#{service}"
    User.last
  end
end

