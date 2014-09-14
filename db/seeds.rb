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
      for z in 1..3 do
        Inventory.create([ product_id: k+j*10-10, color: "black", size: "XXL", amount: "20", price: (i+z)*100 ])
      end
      InventoryImage.create([ inventory_id: k+j*10-10])
    end
  end
end

puts "3 catalogs and 3 subclasses belonging to each catalog has been built"
puts "10 products and their own infos & images has been built"

for a in 101..110 do
  Bug.create([name: "user#{a}", email: "user#{a}@gmail.com", title: "bug#{a}", content: "This is bug no.#{a}", status: "#{a}"])
end

User.create([ email: "admin@gmail.com", password: "adminadmin", password_confirmation: "adminadmin"])
User.find(1).add_role "admin"
User.create([ email: "service@gmail.com", password: "serviceguy", password_confirmation: "serviceguy"])
User.find(2).add_role "service"
User.create([ email: "shopper@gmail.com", password: "shopperguy", password_confirmation: "shopperguy"])
User.find(3).add_role "shopper"
User.create([ email: "analyst@gmail.com", password: "analystguy", password_confirmation: "analystguy"])
User.find(4).add_role "analyst"

for i in 1..10 do
  Faq.create([question: "This is faq question no.#{i}", answer: "This is faq answer no.#{i}"])
  User.create([ email: "user#{i}@gmail.com", password: '11111111', password_confirmation: '11111111' ])
  for j in 1..3 do
    Contact.create([user_id: i, name: "name#{j}user#{i}", cellphone: "0912-345678", address: "This is contact adress no.#{j} of user#{i}"])
    Coupon.create([user_id: i , expired_at: "20150101", title: "coupon#{j}", content: "This is coupon no.#{j}", amount: "888"])
    MemberQuestion.create([user_id: "#{i}", title: "Member_question#{j}", content: "This is member_question no.#{j} of user no.#{i}", status: "#{j}"])
    Order.create([user_id: "#{i}", contact_id: "#{j}", pay_method: "#{j}", ship_method: "#{j}", status: "#{j}", total_price: "999"])
    for k in 1..3 do
      Answer.create([member_question_id: "#{j}", user_id: "#{i}", content: "This is the answer no.#{k} of question no.#{j}"])
      OrderInventory.create([ order_id: (i-1)*3+j, inventory_id: k*3 ])
    end
  end
  Cart.create([ user_id: i, receive_address: "This is receive_address of user#{i}", invoice_address: "This is invoice_address of user#{i}" ])
  for l in 1..3 do
    CartInventory.create([ cart_id: "#{i}", inventory_id: l*5, amount: l ])
  end
end

puts "seed.rb is executed!"