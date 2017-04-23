require 'rails_helper'

RSpec.describe StateAir::FeedController, type: :controller do

  describe "GET #latest" do
    it "returns http success" do
      get :latest, params: { city: :beijing }
      expect(response).to have_http_status(:success)
    end
  end

end
