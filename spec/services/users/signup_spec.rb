require 'rails_helper'

RSpec.describe Users::Signup do
  describe "#call" do
    let(:username) { nil }

    subject do
      described_class.call(username: username)
    end

    context 'when specifying an available username' do
      let(:username) { 'BOB' }

      it 'creates a user with the specified username' do
        expect(subject.success?).to be_truthy
        expect(subject.user).to be_a(User)
        expect(subject.user.username).to eq(username)
      end

      context 'when there was a fallback with the same username value' do
        let!(:fallback_username) { create(:fallback_username, username: username) }

        it 'creates a user with the specified username' do
          expect(subject.success?).to be_truthy
          expect(subject.user).to be_a(User)
          expect(subject.user.username).to eq(username)
        end

        it 'destroys the fallback' do
          subject
          expect(FallbackUsername.find_by(id: fallback_username.id)).to eq(nil)
        end
      end
    end

    context 'when specifying an already taken username' do
      let(:existing_user) { create(:user, username: 'BOB') }
      let(:username) { existing_user.username }

      context 'when there is an available fallback' do
        let!(:fallback_username) { create(:fallback_username, username: 'FAL') }

        it 'creates a user with the fallback username' do
          expect(subject.success?).to be_truthy

          expect(subject.user).to be_a(User)
          expect(subject.user.username).to eq(fallback_username.username)

          expect(FallbackUsername.find_by(id: fallback_username.id)).to eq(nil)
        end
      end

      context 'when there is no fallback' do
        it 'fails with adequate error' do
          expect(subject.success?).to be_falsy
          expect(subject.user).to eq(nil)
          expect(subject.error).to eq(described_class::NO_FALLBACK_USERNAME_FOUND_ERROR)
        end
      end
    end

    context 'when not specifying any username' do
      let(:username) { nil }

      context 'when there is an available fallback' do
        let!(:fallback_username) { create(:fallback_username, username: 'FAL') }

        it 'creates a user with the fallback username' do
          expect(subject.success?).to be_truthy

          expect(subject.user).to be_a(User)
          expect(subject.user.username).to eq(fallback_username.username)

          expect(FallbackUsername.find_by(id: fallback_username.id)).to eq(nil)
        end
      end

      context 'when there is no fallback' do
        it 'fails with adequate error' do
          expect(subject.success?).to be_falsy
          expect(subject.user).to eq(nil)
          expect(subject.error).to eq(described_class::NO_FALLBACK_USERNAME_FOUND_ERROR)
        end
      end
    end

    context 'when specifying an invalid username' do
      let(:username) { 42 }

      context 'when there is an available fallback' do
        let!(:fallback_username) { create(:fallback_username, username: 'FAL') }

        it 'creates a user with the fallback username' do
          expect(subject.success?).to be_truthy

          expect(subject.user).to be_a(User)
          expect(subject.user.username).to eq(fallback_username.username)

          expect(FallbackUsername.find_by(id: fallback_username.id)).to eq(nil)
        end
      end

      context 'when there is no fallback' do
        it 'fails with adequate error' do
          expect(subject.success?).to be_falsy
          expect(subject.user).to eq(nil)
          expect(subject.error).to eq(described_class::NO_FALLBACK_USERNAME_FOUND_ERROR)
        end
      end
    end

    context 'when fallback found is already taken' do
      let(:username) { nil }
      let(:existing_user) { create(:user, username: 'BOB') }
      let!(:fallback_username) { create(:fallback_username, username: existing_user.username) }

      it 'fails with adequate error' do
        expect(subject.success?).to be_falsy
        expect(subject.user).to eq(nil)
        expect(subject.error).to eq(described_class::USER_CREATION_ERROR)
      end
    end
  end
end
