# frozen_string_literal: true

module Users
  class Signup
    include Interactor

    USER_CREATION_ERROR = 'CREATION_FAILED'
    NO_FALLBACK_USERNAME_FOUND_ERROR = 'NO_FALLBACK_USERNAME_FOUND'

    def call
      user = try_to_create_user(context.username) || try_to_create_user(find_fallback_username_value)

      context.fail!(error: USER_CREATION_ERROR) if user.nil?

      context.user = user
    end

    private

    def try_to_create_user(username)
      ActiveRecord::Base.transaction do
        user = User.create!(username: username)
        FallbackUsername.where(username: username).destroy_all

        user
      end
    rescue ActiveRecord::RecordInvalid, PG::UniqueViolation, ActiveRecord::RecordNotUnique
      nil
    end

    def find_fallback_username_value
      fallback_username = FallbackUsername.from("#{FallbackUsername.table_name} TABLESAMPLE system_rows(1)").first

      context.fail!(error: NO_FALLBACK_USERNAME_FOUND_ERROR) if fallback_username.nil?

      fallback_username.username
    end
  end
end
