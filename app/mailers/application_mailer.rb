class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  # サーバーに登録してあるメールアドレスが入る
  layout 'mailer'
end
