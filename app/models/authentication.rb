class Authentication < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :provider, :uid, :user

  def self.find_or_create(auth)
    unless login = find_by_provider_and_uid(auth["provider"], auth["uid"])
      user = User.find_by_email(auth["user_info"]["email"]) || User.create_with_omniatuh(auth)
      login = create :user => user, :provider => auth["provider"], :uid => auth["uid"]
    end

    login
  end
end
