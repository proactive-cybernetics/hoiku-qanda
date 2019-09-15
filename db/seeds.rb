# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 初期ユーザーデータ
#1
User.create(name: "管理者さん", email: "admin@example.com",\
            password: "passphrase", admin_auth: 1)

#2
User.create(name: "新米の保育士さん", email: "newbie@example.com",\
            password: "password", admin_auth: 0)

#3
User.create(name: "百戦錬磨の保育士さん", email: "expert@example.com",\
            password: "PASSWORD" , admin_auth: 0)


# 初期質問データ
#1
Question.create(title: "バナナはおやつに入りますか?", \
                user_id: 2, \
                content: \
"今度の遠足で、園児が持参するおやつの上限総額を
500円とすることにしましたが、このおやつの額に
園児の持参するバナナの金額を含めるべきでしょうか。

この話を私の受け持ちの園児たちにしたところ、
園児の一人が「バナナはおやつに入りますか?」と聞いてきました。

私が答えに窮したところ、その子は「じゃあバナナ1000本持ってきて食べる」
と言ってきましたので、ほとほと困っています。", \
                status: 1)

#2
Question.create(title: "遊具の修理について", \
                user_id: 2, \
                content: \
"保育所の園庭にある遊具(ブランコ)が老朽化したため、修理をしてくれる
業者を探しています。
Googleやタウンページを使って調べようとしてはみましたが、どこから
調べ始めていいかわからない状況です。

保育所の場所は横浜市都筑区で、なるべく近くの業者を探しています。", \
                status: 2,
                best_answer: 2)

#3
Question.create(title: "オルガンの学習について", \
                user_id: 3, \
                content: \
"私の職場に今年から入った新人さんが、オルガンの演奏を苦手にしています。

私たちの保育所では、年少以上のクラスでは
昼食の前にオルガンの演奏にあわせてみんなで歌うのですが
新人さんがなかなかオルガンの演奏を覚えてくれないため、
いつも私が演奏しています。

本人は私のことを気にかけてオルガンの練習を頑張っていますし
「子供たちが喜ぶことはなんでもやりたい」と言っています。
情熱はある人なので、この一点がとても歯がゆいです。
", \
                status: 1)

#4
Question.create(title: "お昼寝の間の見回りについて", \
                user_id: 2, \
                content: \
"私たちの保育所では、お昼寝の間に連絡帳や事務作業と
子どもたちの見回りを並行していますが、
人数が足りない時は普段通りの頻度で見回りをやることを
優先していますか? それとも見回りの頻度を減らしたりしていますか?", \
                status: 1)

#5
Question.create(title: "おやつの量について", \
                user_id: 2, \
                content: \
"14:30のお昼寝のあと、おやつの時間を設けていますが
一人一人食べる量に違いがあるので、毎回おやつの量を
決めるのに苦労しています。

少なすぎると子どもたちから不満が出ますが、
あまり食べさせすぎると肥満になるかもしれないので
悩ましいです。", \
                status: 1)

#6
Question.create(title: "お迎えに遅れてくる親御さんの対応", \
                user_id: 1, \
                content: \
"保育所から帰る子どもたちのお迎えに来る
親御さんたちですが、いつもおよそ4〜5人が
約束の時間を1時間以上遅れて来ます。

なるべく角を立てずに改善を促したいと思っています。
皆さんはこのような時にどう対応しましたか?", \
                best_answer: 3, \
                status: 2)


# 初期回答データ
#1
Answer.create(question_id: 2, \
              user_id: 3, \
              already_read: 0, \
              content: \
"ここはどうでしょうか。
【保育園・幼稚園専門】屋外遊具の○×サービス
045-xxx-xxxx
http://www.****-service.co.jp/")

#2
Answer.create(question_id: 2, \
              user_id: 3, \
              already_read: 0, \
              content: \
"ここもなかなか実績がありそうですよ。
【100以上の公園等で実績あり】遊具点検・修理 ★＊事務所 \r\n045-yyy-yyyy\r\nhttp://www.****-office.com/\r\n\r\nあと、今後のために定期点検の契約を結びましょう。\r\n",)

#3
Answer.create(question_id: 6, \
              user_id: 2, \
              already_read: 0, \
              content: \
"保護者会で合意の上、罰金制にしてはいかがでしょうか")


# 初期回答への返信データ
#1
AnswerReply.create(answer_id: 2,
                  already_read: 0, \
                  content:
"ありがとうございました。
定期点検についても、園長と相談して決めようと思います。")

#2
AnswerReply.create(answer_id: 3,
                  already_read: 0, \
                  content:
"罰金の条件や金額については保護者会で検討します。ありがとうございました。")


