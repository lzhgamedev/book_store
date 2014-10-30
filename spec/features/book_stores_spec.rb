require 'rails_helper'

feature "BookStores", :type => :feature do
  before do
    cat = FactoryGirl.create(:category, name: '日本文学')
    FactoryGirl.create(:book, title: 'きぬぎぬ川', isbn: '1234567890', category: cat,
                       price: 1000, description: '白い兎をさずかった令室の行方をさがして...')
    FactoryGirl.create(:customer, email: 'yama@book.com')
  end

  context "ログインせずに" do
    it "カテゴリー一覧 → 書籍一覧 → 書籍詳細 とページをたぐれる" do
      # ここを考えてください
    end
  end

  context "ログインして" do
    before do
      visit "/" 
      click_link "ログイン" 
      fill_in "e-mail", with: "yama@book.com" 
      fill_in "パスワード", with: "test0000" 
      click_button "ログイン" 
    end

    it "ログインするとカート表示リンクが表示される" do
      expect(page.text).to match "カート表示" 
    end

    describe "書籍ページでカートに入れると" do
      before do
        visit "/" 
        click_link "日本文学" 
        click_link "きぬぎぬ川" 
        click_on "カートに入れる" 
      end

      it "カートに入れた書籍がカートにある" do
        expect(page.text).to match "ショッピングカート" 
        expect(page.text).to match "きぬぎぬ川" 
      end

      # 以降のテストを考えてください

    end
  end
end