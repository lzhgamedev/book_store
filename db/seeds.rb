# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

IMAGE_PATH = "/book_images"

def create_books(category_name, tsv_file)
  category = Category.create!(:name => category_name, :display_order => @category_order)
  @category_order += 1

  IO.readlines("db/book_data/" + tsv_file).each_with_index do |book, ix|
    d = book.split("\t")
    Book.create!(
      :title  => d[0],
      :author => d[1],
      :price  => d[2].gsub(',', '').to_i,
      :isbn   => d[3],
      :icon_path => "#{IMAGE_PATH}/S#{d[4]}.jpg",
      :picture_path => "#{IMAGE_PATH}/L#{d[4]}.jpg",
      :description => d[5],
      :display_order => ix + 1,
      :category_id => category.id)
  end
  puts "-- #{category_name}"
end

Category.delete_all
Book.delete_all

@category_order = 1
create_books('文学', 'literature.tsv')
create_books('歴史', 'history.tsv')
create_books('哲学', 'philosophy.tsv')
create_books('美術', 'art.tsv')
create_books('心理学', 'psychology.tsv')
create_books('ビジネス', 'business.tsv')
create_books('法律', 'law.tsv')
create_books('コミック', 'comic.tsv')
create_books('プログラミング', 'programing.tsv')
create_books('絵本', 'picture_book.tsv')

#
Customer.delete_all
Manager.delete_all
Customer.create!(:name => '山田 太郎', :email => 'yama@book.com', :password => 'test1234', :password_confirmation => 'test1234',
  :zip => '101-0033', :address => '東京都渋谷区神山町1-1-1', :tel => '03-5555-1234')
Manager.create!(:name => 'Mr.Admin', :email => 'admin@book.com', :password => 'test1234', :password_confirmation => 'test1234')