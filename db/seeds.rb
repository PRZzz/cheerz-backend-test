already_taken_usernames = User.pluck(:username)
available_chars = ('A'..'Z').to_a

available_chars.each do |char_1|
  available_chars.each do |char_2|
    available_chars.each do |char_3|
      username = "#{char_1}#{char_2}#{char_3}"
      next if already_taken_usernames.include?(username)

      FallbackUsername.find_or_create_by!(username: username)
    end
  end
end
