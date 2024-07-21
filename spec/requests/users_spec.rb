require "rails_helper"

context "Users API endpoints", type: :request do
  describe 'POST users' do
    let(:username) { 'BOB' }

    subject do
      post "/users", params: { username: username }
      response
    end

    let(:expected_user) { create(:user) }
    let(:expected_serialization) { { "fake" => 'serialization' } }
    before do
      allow(Users::Signup).to receive(:call).with(username: username) do
        double('Users::Signup double', success?: true, user: expected_user)
      end

      allow(UserSerializer).to receive(:new).with(expected_user) do
        double('UserSerializer double', as_json: expected_serialization)
      end
    end

    it 'serializes a page of users' do
      expect(subject).to have_http_status(:ok)

      json_body = JSON.parse(subject.body)
      expect(json_body['data']).to eq(expected_serialization)
    end

    context 'when signup encounters an error' do
      let(:error) { 'rspec_fake_error' }
      before do
        allow(Users::Signup).to receive(:call).with(username: username) do
          double('Users::Signup double', success?: false, error: error)
        end
      end

      it 'serializes the error' do
        expect(subject).to have_http_status(:bad_request)

        json_body = JSON.parse(subject.body)
        expect(json_body['error']).to eq(error)
      end
    end
  end
end
