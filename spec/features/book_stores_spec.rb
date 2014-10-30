require 'rails_helper'

feature "BookStores", :type => :feature, js: true do
  before do
    cat = FactoryGirl.create(:category, name: '日本文学')
    FactoryGirl.create(:book, title: 'きぬぎぬ川', isbn: '1234567890', category: cat,
                       price: 1000, description: '白い兎をさずかった令室の行方をさがして...')
    FactoryGirl.create(:customer, email: 'yama@book.com')
  end

  context "ログインせずに" do
    it "カテゴリー一覧 → 書籍一覧 → 書籍詳細 とページをたぐれる" do
      visit "/" 
      click_link "日本文学"
      click_link "きぬぎぬ川"  
      expect(page.text).to match "1234567890" 
      expect(page.text).to match "白い兎をさずかった令室の行方をさがして..." 
      expect(page.text).to match "￥1,000" 
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

        visit "/" 
        click_on "カート表示"
        expect(page).to have_content "ショッピングカート" 
      end

      it "カートに入れた書籍がカートにある" do
        expect(page.text).to match "ショッピングカート" 
        expect(page.text).to match "きぬぎぬ川" 
      end
      
      it "购入するとありがとうございましたペジーに行く" do
        click_on "購入"
        expect(find("h1")).to have_content "お買い上げありがとうございます" 
      end

      it "数量を2に変更すると金额も2倍になる" do
        click_on "数量変更"
        expect(find("#cart_content")).to have_content "数量変更" 
        fill_in "数量", with: "2" 
        click_on "更新する"
        expect(find("#cart_content")).to have_content "ショッピングカート" 
        expect(find("#cart_content")).to have_content "2,000" 
      end
      # 以降のテストを考えてください

    end
  end
end