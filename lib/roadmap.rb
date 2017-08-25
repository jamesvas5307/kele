module Roadmap
  def get_roadmaps
    roadmap_id = @profile['current_enrollment']['roadmap_id']
    roadmap = self.class.get("https://www.bloc.io/api/v1/roadmaps/#{roadmap_id}", headers: { "authorization" => @auth_token })
    roadmap = JSON.parse(roadmap.body)
  end

  def get_checkpoint (id)
    checkpoint = self.class.get("https://www.bloc.io/api/v1/checkpoints/#{id}", headers: { "authorization" => @auth_token })
    checkpoint = JSON.parse(checkpoint.body)
   end
end
