require 'HTTParty'
class Kele
  include HTTParty
  def initialize (email,password)
    @api = "https://www.bloc.io/api/v1/sessions"

    @auth_token = self.class.post(@api, query: { email: email, password: password })

  end
end
