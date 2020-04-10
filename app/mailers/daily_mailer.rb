class DailyMailer < ApplicationMailer
	def notify_user
        default to: -> { User.pluck(:email) }
        # 宛先を指定します。pluckでUserのemailを全て取得する
        mail(subject: "everyday Bookers!yay!")
        end
end
