require 'faker'

member = User.new(email: "paulmhenke@gmail.com", password: "helloworld")
member.skip_confirmation!
member.save!

member_two = User.new(email: "phenke@hotmail.com", password: "helloworld")
member_two.skip_confirmation!
member_two.save!

member_three = User.new(email: "paulmhenke+2@gmail.com", password: "helloworld")
member_three.skip_confirmation!
member_three.save!

Application.create!(name: "ESPN", url: "espn.com", user_id: member.id)
Application.create!(name: "SI", url: "si.com", user_id: member.id)
Application.create!(name: "CNN", url: "cnn.com", user_id: member_two.id)
Application.create!(name: "Bloc", url: "bloc.io", user_id: member_three.id)

puts "Seed finished"
puts "#{User.count} users, #{Application.count} apps."