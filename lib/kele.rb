$LOAD_PATH << '.'

require 'HTTParty'
require 'json'
require 'lib/roadmap.rb'
class Kele
  include HTTParty
  include Roadmap
  def initialize (email,password)
    @api = "https://www.bloc.io/api/v1/sessions"
    @email = email
    @password = password
    response = self.class.post(@api, query: { email: @email, password: @password })
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

  def get_messages(v = nil)
    url = "https://www.bloc.io/api/v1/message_threads"
    messages = self.class.get(url, headers: { "authorization" => @auth_token }, values: {"page" => v})
  end

  def send_message
    url = "https://www.bloc.io/api/v1/messages"
    sendersEmail = @email
    mentor_id = @profile["current_enrollment"]["mentor_id"]
    puts "What would you like the subject of the message to be?"
    subject = gets.chomp
    puts "What would you like your message to be?"
    message = gets.chomp
    response = self.class.post(url, headers: { "authorization" => @auth_token }, values: {"sender"=> sendersEmail, "recipient_id" => mentor_id, "subject" => subject, "stripped-text" => message})
  end

end
