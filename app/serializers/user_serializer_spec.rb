require 'rails_helper'

RSpec.describe UserSerializer do
  describe "#as_json" do
    let(:user) { create(:user)}

    subject do
      described_class.new(user).as_json
    end

    it "serializes the user as a JSON object" do
      expect(subject).to match(
        {
          id: user.id,
          username: user.username,
        }
      )
    end
  end
end
