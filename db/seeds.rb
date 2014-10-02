# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..3 do
  Catalog.create([ name: "目錄#{i}目錄#{i}目錄#{i}目錄#{i}目錄#{i}", description: "這是目錄說明#{i}這是目錄說明#{i}這是目錄說明#{i}這是目錄說明#{i}這是目錄說明#{i}"])
  for j in 1..3 do
    Subclass.create([ name: "類別#{j}位於目錄#{i}類別#{j}位於目錄#{i}類別#{j}位於目錄#{i}", description: "這是類別#{j}位於目錄#{i}的說明這是類別#{j}位於目錄#{i}的說明這是類別#{j}位於目錄#{i}的說明", catalog_id: i])
    for k in 1..5 do
      total_amount_temp = 0
      total_popularity_temp = 0
      for l in 1..3 do
        Inventory.create([ product_id: k+j*10+i*30-40, color: "black", size: "XXL", amount: 270, popularity: 393-l-k*3-j*30-i*90])
        total_amount_temp += 270
        total_popularity_temp += 393-l-k*3-j*30-i*90
        for m in 1..3 do
          InventoryImage.create([ inventory_id: l+k*3+j*30+i*90-123 ])
        end
      end
      Product.create([ name: "商品#{k+j*10+i*30-40}商品商品商品商品商品商品", description: "這是商品說明#{k+j*10+i*30-40}這是商品說明這是商品說明這是商品說明", size_note: "my size", attention: "這是商品說明這是商品說明這是商品說明這是商品說明", price: i*1000+j*100+k, total_amout: 810, total_popularity: total_popularity_temp])
      SubclassProduct.create([ subclass_id: j, product_id: k+j*10+i*30-40 ])
    end
  end
end

puts "3 catalogs and 3 subclasses belonging to each catalog has been built"
puts "10 products and their own infos & images has been built"

for a in 101..110 do
  Bug.create([name: "user#{a}user#{a}user#{a}", email: "user#{a}@gmail.com", title: "錯誤回報#{a}錯誤回報錯誤回報錯誤回報", content: "錯誤回報#{a}錯誤回報錯誤回報錯誤回報錯誤回報錯誤回報", status: 1])
end

User.create([ email: "admin@gmail.com", password: "adminadmin", password_confirmation: "adminadmin"])
User.find(1).add_role "admin"
User.create([ email: "service@gmail.com", password: "serviceguy", password_confirmation: "serviceguy"])
User.find(2).add_role "service"
User.create([ email: "shopper@gmail.com", password: "shopperguy", password_confirmation: "shopperguy"])
User.find(3).add_role "shopper"
User.create([ email: "analyst@gmail.com", password: "analystguy", password_confirmation: "analystguy"])
User.find(4).add_role "analyst"

for i in 1..5 do
  User.create([ email: "user#{i}@gmail.com", password: '11111111', password_confirmation: '11111111' ])
  Faq.create([question: "常見問題#{i}常見問題常見問題常見問題常見問題", answer: "答#{i}答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答答"])
  for j in 1..3 do
    Contact.create([user_id: i, name: "路人#{j}使用者#{i}", cellphone: "0912-345678", address: "這裡是地址#{j}這裡是地址#{j}這裡是地址#{j}這裡是地址#{j}這裡是地址#{j}這裡是地址#{j}", email: "receiver#{i*3-3+j}@gmail.com"])
    Coupon.create([user_id: i , expired_at: "20150101", title: "這裡是標題這裡是標題這裡是標題", content: "這裡是內容這裡是內容這裡是內容這裡是內容這裡是內容", amount: "888"])
    MemberQuestion.create([user_id: "#{i}", title: "會員提問#{j}會員提問會員提問會員提問會員提問", content: "這裡是內容#{j}這裡是內容#{j}這裡是內容#{j}這裡是內容#{j}這裡是內容#{j}", status: j ])
    Order.create([user_id: "#{i}", contact_id: "#{i*3-3+j}", pay_method: "#{j}", ship_method: "#{j}", status: "#{j}", total_price: "999"])
    for k in 1..3 do
      Answer.create([member_question_id: (i-1)*3+j, user_id: "#{i}", content: "這裡是回覆#{k}這裡是回覆這裡是回覆這裡是回覆這裡是回覆"])
      OrderInventory.create([ order_id: (i-1)*3+j, inventory_id: k*3 ])
    end
  end
  Cart.create([ user_id: i, receive_address: "這裡是收件地址#{i}這裡是收件地址這裡是收件地址", invoice_address: "這裡是發票地址#{i}這裡是發票地址這裡是發票地址" ])
  for l in 1..3 do
    CartInventory.create([ cart_id: "#{i}", inventory_id: l*5, amount: l ])
  end
end

puts "seed.rb is executed!"