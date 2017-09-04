module Api::V1
  class Haha < Grape::API
    format :json

    get :ping do
      { data: "pong" }
    end
  end
end
