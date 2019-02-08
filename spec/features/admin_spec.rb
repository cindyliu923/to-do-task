require "rails_helper"

RSpec.feature "admin", :type => :feature do

  before(:each) do
    log_in_with_admin
  end

  scenario "Update a user" do
    visit "/admin/users/#{@user.id}/edit"

    fill_in I18n.t("users.name"), with: "name"
    fill_in I18n.t("users.email"), with: 'valid@example.com'
    fill_in I18n.t("users.password"), with: "password"
    fill_in I18n.t("users.password_confirmation"), with: "password"
    click_button I18n.t("helpers.submit.update")

    expect(page).to have_text(I18n.t("users.notice.update"))
  end

  scenario "Create a new user" do
    visit "/admin/users/new"

    fill_in I18n.t("users.name"), with: "name"
    fill_in I18n.t("users.email"), with: 'valid@example.com'
    fill_in I18n.t("users.password"), with: "password"
    fill_in I18n.t("users.password_confirmation"), with: "password"

    click_button I18n.t("helpers.submit.create")

    expect(page).to have_text(I18n.t("users.notice.create"))
  end

  scenario "Destroy a user" do
    user = FactoryBot.create(:user)
    visit "/admin/users"

    expect { find('table tr:nth-child(3)').click_link I18n.t("common.destroy") }.to change(User, :count).by(-1)
    expect(page).to have_text(I18n.t("users.alert.destroy"))
  end

  scenario "See users list and user tasks count" do
    user = FactoryBot.create(:user)
    visit "/admin/users"

    expect(find('table tr:nth-child(2)')).to have_content(@user.name)
    expect(find('table tr:nth-child(2)')).to have_content(@user.email)
    expect(find('table tr:nth-child(2)')).to have_content(@user.tasks_count)
    expect(find('table tr:nth-child(3)')).to have_content(user.name)
    expect(find('table tr:nth-child(3)')).to have_content(user.email)
    expect(find('table tr:nth-child(3)')).to have_content(user.tasks_count)
  end

  scenario "See user and tasks" do
    user = FactoryBot.create(:user)
    task = FactoryBot.create(:task, user: user)
    visit "/admin/users/#{user.id}"

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.tasks_count)
    expect(page).to have_content(task.title)
  end

end
