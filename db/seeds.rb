# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
    email: "aa@aa",
    password: "123456",
  )

users = {
  "guest"=>"guest",
  "ぴくせるぱいおにあ"=>"PixelPioneer02",
  "コードの達人"=>"CodeMaster03",
  "テクノウィザード"=>"TechWizard04",
  "デジタル夢想家"=>"DigitalDreamer05",
  "バイト詩人"=>"ByteBard06",
  "ウェブの冒険者"=>"WebExplorer07",
  "データの魔法使い"=>"DataSorcerer08",
  "仮想世界の探検家"=>"VirtualVoyager09",
  "ネットの旅人"=>"NetNomad10",
  "カタカナクリエイター"=>"KatakanaCreator11",
  "ひらがなの魔法使い"=>"HiraganaMage12",
  "漢字マスター"=>"KanjiMaster13",
  "サイバーワンダラー"=>"CyberWonderer14",
  "テクノロジーの詩人"=>"TechPoet15",
  "ウェブサーファー"=>"WebSurfer16",
  "デジタル冒険者"=>"DigitalAdventurer17",
  "未来のハッカー"=>"FutureHacker18",
  "仮想現実の冒険者"=>"Virtualrealist19",
  "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほ"=>"01234567890123456789",
  "ああ"=>"aa"
}

users.each do |name, id|
  introduction = "#{name}の自己紹介"
  birthday = "2024-04-01"
  email = "#{id}@aa"
  password = "123456"

  User.create!(
    custom_identifier: id,
    name: name,
    introduction: introduction,
    birthday: birthday,
    email: email,
    password: password,
  )
end

for i in 1..20 do
  Post.create!(
    user_id: i,
    posted_on: "2024-04-01",
    body: "・良かったこと
色々なことを調べて、新しいことを学べた

・見直したいこと
新しいことを調べるのに夢中になりすぎて、課題を進めるのが遅くなった

・次やること
気持ちを切り替えて、課題を進める"
  )
end

for i in 1..20 do
  Post.create!(
    user_id: i,
    posted_on: "2024-04-02",
    body: "・良かったこと
集中して課題に取り組めた、かなり進められたと思う

・見直したいこと
特になし、この調子でガンガン進めたい！

・次やること
引き続き課題！明日終わらせる！"
  )
end

for i in 1..20 do
  Post.create!(
    user_id: i,
    posted_on: "2024-04-03",
    body: "・良かったこと
課題はほぼ完了、かなりスピード感を持って取り組めた

・見直したいこと
課題の終盤で理解不足なところを見つけたので、復習したい

・次やること
課題は一度提出して、理解不足な部分の復習をする"
  )
end

for i in 1..100 do
  user_id = rand(1..20)
  post_id = rand(1..60)

  Comment.create!(
    user_id: user_id,
    post_id: post_id,
    body: "頑張っていてステキです！応援しています！"
  )
end

for i in 1..100 do
  user_id = rand(1..20)
  post_id = rand(1..60)

  begin
    Like.create(
      user_id: user_id,
      post_id: post_id
    )
  rescue ActiveRecord::RecordInvalid => e
    puts "バリデーションエラーが発生しました: #{e.message}"
    next  # エラーが発生したら次のループに進む
  end
end
