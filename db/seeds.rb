# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
for i in 1..10 do
  User.create([{ email: "user#{i}@gmail.com", password: '11111111', password_confirmation: '11111111' }])
  Cart.create([{ user_id: "#{i}", receiver_address: "This is receiver_address of user#{i}", invoice_address: "This is invoice_address of user#{i}" }])

  for j in 1..3 do
    Contact.create([name: "name#{j}user#{i}", cellphone: "0912-345678", address: "This is contact adress no.#{j} of user#{i}"])
    Coupon.create([user_id: "#{i}", expired_at: "20150101", title: "coupon#{j}", content: "This is coupon no.#{j}", amount: "888"])
    Member_question.create([user_id: "#{i}", title: "Member_question#{j}", content: "This is member_question no.#{j}", status: "#{j}"])
    for k in 1..3 do
      Answer.create([member_question_id: "#{j}", user_id: "#{i}", content: "This is the answer no.#{k} of question no.#{j}"])
      Order.create([user_id: "#{i}", contact_id: "#{j}", pay_method: "#{k}", ship_method: "#{k}", status: "#{k}", total_price: "999"])
    end
    #Order_product.create([{ order_id: "#{i}", product_id: "#{j}" }])
    #Cart_product.create([{ cart_id: "#{i}", product_id: "#{j}" }])
  end
end

for i in 1..3
  Faq.create([question: "This is faq question no.#{i}", answer: "This is faq answer no.#{i}"])
  Bug.create([name: "user#{i}", email: "user#{i}@gmail.com", title: "bug#{i}", content: "This is bug no.#{i}", status: "#{i}"])
end

for i in 1..20 do
  Product.create([name: "product#{i}", description: "This is product no.#{i}", ])
end

puts "seed.rb is executed!"