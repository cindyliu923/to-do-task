module Features
  module DateTimeSelectHelpers

    def select_date_and_time(date, options = {})
      field = options[:from]
      select I18n.l(date, format: '%Y'),  :from => "#{field}_1i" #year
      select I18n.l(date, format: '%B'),  :from => "#{field}_2i" #month
      select I18n.l(date, format: '%-d'), :from => "#{field}_3i" #day
      select I18n.l(date, format: '%H'),  :from => "#{field}_4i" #hour
      select I18n.l(date, format: '%M'),  :from => "#{field}_5i" #minute
    end

  end

  module SessionHelpers
    def sign_up_with(name, email, password)
      visit signup_path
      fill_in I18n.t("users.name"), with: name
      fill_in I18n.t("users.email"), with: email
      fill_in I18n.t("users.password"), with: password
      fill_in I18n.t("users.password_confirmation"), with: password
      click_button I18n.t("users.signup")
    end

    def log_in_with_task(task)
      @user = task.user
      visit login_path
      fill_in I18n.t("users.email"), with: @user.email
      fill_in I18n.t("users.password"), with: @user.password
      click_button I18n.t("users.login")
    end

    def log_in
      @user = FactoryBot.create(:user)
      visit login_path
      fill_in I18n.t("users.email"), with: @user.email
      fill_in I18n.t("users.password"), with: @user.password
      click_button I18n.t("users.login")
    end
  end
end
