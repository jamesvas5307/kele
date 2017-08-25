require 'HTTParty'
require 'json'
class Kele
  include HTTParty
  def initialize (email,password)
    @api = "https://www.bloc.io/api/v1/sessions"

    response = self.class.post(@api, query: { email: email, password: password })
    @auth_token = response['auth_token']
  end

  def get_me
    r = self.class.get('https://www.bloc.io/api/v1/users/me', headers: { "authorization" => @auth_token })
    @profile = JSON.parse(r.body)
  end

  def get_mentor_availability
    mentor_id = @profile["current_enrollment"]["mentor_id"]
    availability = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    @mentor_availabile = JSON.parse(availability.body)
  end
end
