require 'rails_helper'

RSpec.feature "users", :type => :feature do

  let(:user){FactoryBot.create(:user)}

  feature 'Visitor signs up' do
    scenario 'with valid email and password' do
      sign_up_with 'name', 'valid@example.com', 'password'

      expect(page).to have_content(I18n.t("users.login"))
    end

    scenario 'with invalid email' do
      sign_up_with 'name', 'invalid_email', 'password'

      expect(page).to have_content(I18n.t("users.signup"))
    end

    scenario 'with blank password' do
      sign_up_with 'name', 'valid@example.com', ''

      expect(page).to have_content(I18n.t("users.signup"))
    end
  end

  feature 'Visitor login in' do
    scenario 'with valid email and password' do
      visit login_path
      fill_in I18n.t("users.email"), with: user.email
      fill_in I18n.t("users.password"), with: user.password
      click_button I18n.t("users.login")
      expect(page).to have_content(I18n.t("common.title"))
    end

    scenario 'with invalid password' do
      visit login_path
      fill_in I18n.t("users.email"), with: user.email
      fill_in I18n.t("users.password"), with: "password"
      click_button I18n.t("users.login")
      expect(page).to have_content(I18n.t("users.login"))
    end
  end

  feature 'User with tasks' do
    scenario 'can not see tasks without login' do
      visit login_path
      click_link I18n.t("tasks.titles")

      expect(page).to have_content(I18n.t("users.login"))
      expect(page).to_not have_content(I18n.t("common.title"))
    end

    scenario 'can not see other tasks' do
      task = FactoryBot.create(:task)
      task_other = FactoryBot.create(:task, user: user)
      visit login_path
      log_in_with_task(task)

      expect(page).to have_content(task.title)
      expect(page).to_not have_content(task_other.title)
    end
  end
end
