module Api::V2
  class Xixi < Grape::API
    format :json

    get :ping do
      { data: "pong" }
    end
  end
end
