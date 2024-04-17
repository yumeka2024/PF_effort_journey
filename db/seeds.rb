# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 3.times do |n|
#   custom_identifier  = "customID#{n+1}"
#   name  = "name#{n+1}"
#   introduction = "#{name}の自己紹介"
#   birthday = "2024-04-01"
#   email = "#{name}@example.com"
#   password = "password"

#   User.create!(
#     custom_identifier: custom_identifier,
#     name: name+n,
#     introduction: introduction,
#     birthday: birthday,
#     email: email,
#     password: password,
#   )
# end

users = {
  "ベータブレイバー"=>"BetaBrave1",
  "サイバーシンカー"=>"CyberThinker2",
  "デルタドリーマー"=>"DeltaDreamer3",
  "ガンマガーディアン"=>"GammaGuardian4",
  "ホライズンハッカー"=>"HorizonHacker5",
  "キロキング"=>"KiloKing6",
  "メガマスター"=>"MegaMaster7",
  "ベータブレイズ"=>"BetaBlaze8",
  "エコーブリンガー"=>"EchoBringer9",
  "ハーモニーハーツ"=>"HarmonyHearts10",
  "ラムダレジェンド"=>"LambdaLegend11",
  "ナイトネオン"=>"NightNeon12",
  "オメガオラクル"=>"OmegaOracle13",
  "ピクセルパイロット"=>"PixelPilot14",
  "クイーンクエリー"=>"QueenQuery15",
  "レーザーロード"=>"LaserRoad16",
  "シグマセンチネル"=>"SigmaSentinel17",
  "テクノタイタン"=>"TechnoTitan18",
  "ユニバースヒーロー"=>"UniverseHero19",
  "ヴィジョンボルト"=>"VisionBolt20",
  "サイバーニンジャ"=>"CyberNinja21",
  "ぴくせるぱいおにあ"=>"PixelPioneer22",
  "コードの達人"=>"CodeMaster23",
  "テクノウィザード"=>"TechWizard24",
  "デジタル夢想家"=>"DigitalDreamer25",
  "バイト詩人"=>"ByteBard26",
  "ウェブの冒険者"=>"WebExplorer27",
  "データの魔法使い"=>"DataSorcerer28",
  "仮想世界の探検家"=>"VirtualVoyager29",
  "ネットの旅人"=>"NetNomad30",
  "カタカナクリエイター"=>"KatakanaCreator31",
  "ひらがなの魔法使い"=>"HiraganaMage32",
  "漢字マスター"=>"KanjiMaster33",
  "サイバーワンダラー"=>"CyberWonderer34",
  "テクノロジーの詩人"=>"TechPoet35",
  "ウェブサーファー"=>"WebSurfer36",
  "デジタル冒険者"=>"DigitalAdventurer37",
  "未来のハッカー"=>"FutureHacker38",
  "仮想現実の冒険者"=>"Virtualrealist39",
  "データエクスプローラー"=>"DataExplorer40"
}

users.each do |name, id|
  introduction = "#{name}の自己紹介"
  birthday = "2024-04-01"
  email = "#{id}@example.com"
  password = "password"

  User.create!(
    custom_identifier: id,
    name: name,
    introduction: introduction,
    birthday: birthday,
    email: email,
    password: password,
  )
end

