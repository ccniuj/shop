# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..3 do
  Catalog.create([ name: "catalog#{i}", description: "description of catalog#{i}"])
  for j in 1..3 do
    Subclass.create([ name: "subclass#{j} under catalog#{i}", description: "description of subclass#{j} under catalog#{i}", catalog_id: i])
    for k in 1..10 do
      Product.create([ name: "product#{k+j*10-10}", description: "description of product#{k+j*10-10}", size_note: "my size", attention: "don't put in ur mouth"])
      SubclassProduct.create([ subclass_id: j, product_id: k+j*10-10 ])
      ProductInfo.create([ product_id: k+j*10-10, style: "weird", color: "transparent", amount: k, price: k*100 ])
      ProductImage.create([ product_info_id: k+j*10-10])
    end
  end
end

puts "3 catalogs and 3 subclasses belonging to each catalog has built"
puts "10 products and their own infos & images has been built"
puts "the connection"

for a in 101..110 do
  Bug.create([name: "user#{a}", email: "user#{a}@gmail.com", title: "bug#{a}", content: "This is bug no.#{a}", status: "#{a}"])
end

for i in 1..10 do
  Faq.create([question: "This is faq question no.#{i}", answer: "This is faq answer no.#{i}"])
  User.create([ email: "user#{i}@gmail.com", password: '11111111', password_confirmation: '11111111' ])
  for j in 1..3 do
    Contact.create([name: "name#{j}user#{i}", cellphone: "0912-345678", address: "This is contact adress no.#{j} of user#{i}"])
    Coupon.create([user_id: i , expired_at: "20150101", title: "coupon#{j}", content: "This is coupon no.#{j}", amount: "888"])
    MemberQuestion.create([user_id: "#{i}", title: "Member_question#{j}", content: "This is member_question no.#{j} of user no.#{i}", status: "#{j}"])
    for k in 1..3 do
      Answer.create([member_question_id: "#{j}", user_id: "#{i}", content: "This is the answer no.#{k} of question no.#{j}"])
      Order.create([user_id: "#{i}", contact_id: "#{j}", pay_method: "#{k}", ship_method: "#{k}", status: "#{k}", total_price: "999"])
      OrderProduct.create([ order_id: "#{k}", product_id: "#{k}" ])    
    end
  end
  Cart.create([ user_id: i, receive_address: "This is receive_address of user#{i}", invoice_address: "This is invoice_address of user#{i}" ])
  for l in 1..3 do
    CartProduct.create([ cart_id: "#{i}", product_id: "#{l}" ])
  end
end

puts "seed.rb is executed!"