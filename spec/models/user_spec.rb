require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    let(:user) { build(:user) }

    subject do
      user.valid?
    end

    it 'returns true' do
      expect(subject).to be_truthy
    end

    context 'when username is not defined' do
      let(:user) { build(:user, username: nil) }

      it 'returns false with adequate error' do
        expect { subject }.to change { user.errors.count }.from(0).to(2)

        expect(subject).to be_falsey
        expect(user.errors.details[:username][0]).to eq({ error: :blank })
        expect(user.errors.details[:username][1]).to eq({ error: :invalid, value: user.username })
      end
    end

    context 'when username is invalid' do
      let(:user) { build(:user, username: 42) }

      it 'returns false with adequate error' do
        expect { subject }.to change { user.errors.count }.from(0).to(1)

        expect(subject).to be_falsey
        expect(user.errors.details[:username][0]).to eq({ error: :invalid, value: user.username })
      end
    end
  end
end
