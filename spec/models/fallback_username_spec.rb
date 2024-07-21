require 'rails_helper'

RSpec.describe FallbackUsername, type: :model do
  describe "#valid?" do
    let(:fallback_username) { build(:fallback_username) }

    subject do
      fallback_username.valid?
    end

    it 'returns true' do
      expect(subject).to be_truthy
    end

    context 'when username is not defined' do
      let(:fallback_username) { build(:fallback_username, username: nil) }

      it 'returns false with adequate error' do
        expect { subject }.to change { fallback_username.errors.count }.from(0).to(2)

        expect(subject).to be_falsey
        expect(fallback_username.errors.details[:username][0]).to eq({ error: :blank })
        expect(fallback_username.errors.details[:username][1]).to eq({ error: :invalid, value: fallback_username.username })
      end
    end

    context 'when username is invalid' do
      let(:fallback_username) { build(:fallback_username, username: 42) }

      it 'returns false with adequate error' do
        expect { subject }.to change { fallback_username.errors.count }.from(0).to(1)

        expect(subject).to be_falsey
        expect(fallback_username.errors.details[:username][0]).to eq({ error: :invalid, value: fallback_username.username })
      end
    end
  end
end
