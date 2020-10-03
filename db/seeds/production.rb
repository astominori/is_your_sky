# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# coding: utf-8


  #本番環境用のテストユーザの作成
  sample1 = User.create!(username: "testuser",
                         email: "example-1@email.com",
                         password: "password",
                         avatar: File.open("#{Rails.root}/seed/sample-1.png"),
                         bio: "テストユーザです。")

  sample2 = User.create!(username: "山田一郎",
                         email: "example-2@email.com",
                         password: "password",
                         avatar: File.open("#{Rails.root}/seed/sample-2.jpg"),
                         bio: "テストユーザです。山田です。")

  sample3 = User.create!(username: "ふくらP",
                         email: "example-3@email.com",
                         password: "password",
                         bio: "ふくらPです。空が好きです。")
  sample1.confirm
  sample2.confirm
  sample3.confirm

  #テストポストの作成
  Post.create!(user_id: sample1.id,
               title: "綺麗な空",
               text: "まるで映画の世界かのような美しさ",
               image: File.open("#{Rails.root}/seed/image-1.jpg"),
               created_at: 1.week.ago.beginning_of_day)
  Post.create!(user_id: sample1.id,
               title: "天国へ向かう桟橋",
               text: "沈んでいく太陽と美しい茜色",
               image: File.open("#{Rails.root}/seed/image-2.jpg"),
               created_at: 1.day.ago.beginning_of_day)
  Post.create!(user_id: sample1.id,
               title: "海と空の融合",
               text: "あまりにも綺麗な色合いで混ざり合う世界",
               image: File.open("#{Rails.root}/seed/image-3.jpg"),
               created_at: Time.zone.now.beginning_of_day)

  10.times do |i|
    post = Post.create!(user_id: sample2.id,
                        title: "テストその#{i}",
                        text: "テストポストです。#{i}",
                        image: File.open("#{Rails.root}/seed/image-#{i+4}.jpg"),
                        created_at: 1.day.ago.beginning_of_day)
    tag_list = ["空","綺麗な景色"]
    post.save_tags(tag_list)
  end

  post1 = Post.create!(user_id: sample3.id,
                       title: "きれい〜",
                       text: "オレンジの建物がアクセントになりますね",
                       image: File.open("#{Rails.root}/seed/image-15.jpg"),
                       created_at: 1.week.ago.beginning_of_day)
  post1.save_tags(["青空","建物"])

  post2 = Post.create!(user_id: sample3.id,
                       title: "こんな空見たい",
                       text: "どんな星も見えてしまいそう。",
                       image: File.open("#{Rails.root}/seed/image-16.jpg"),
                       created_at: 1.day.ago.beginning_of_day)
  post2.save_tags(["星空"])

  post3 = Post.create!(user_id: sample3.id,
                       title: "夏だねぇ",
                       text: "どんな夏になるかなぁ",
                       image: File.open("#{Rails.root}/seed/image-17.jpg"),
                       created_at: Time.zone.now.beginning_of_day)
  post3.save_tags(["夏","入道雲"])
