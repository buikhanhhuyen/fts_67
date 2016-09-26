User.create name: "Example User", email: "admin@admin.com",
  password: "password",password_confirmation: "password", is_admin: true

40.times do |n|
  name = "user#{n}"
  email = "user#{n}@email.com"
  password = "password"
  User.create name: name, email: email, password: password
end
