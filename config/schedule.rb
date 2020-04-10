# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# 絶対パスから相対パス指定
env :PATH, ENV['PATH']
# ログファイルの出力先
set :output, 'log/cron.log'
# ジョブの実行環境の指定 environmentが環境という意味。development rails内の開発環境。今回はこれを指定してます。
set :environment, :development
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
every 1.days, at: '9:00 am' do
# Rails内のメソッド実行
  runner "DailyMailer.notify_user"
end
# runner Railsに定義されたメソッドを呼び出すために使用します

# Learn more: http://github.com/javan/whenever
