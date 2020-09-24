# file: spec/request_helper.rb

def login(user, password = 'password')
  post user_session_path, params: { 'user[email]' => user.email, 'user[password]' => password }
end

def logout
  delete destroy_user_session_path
end
