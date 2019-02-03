require "rails_helper"

RSpec.feature "tasks", :type => :feature do

  before(:each) do
    @task = FactoryBot.create(:task)
  end

  scenario "Update a task" do
    visit "/tasks/1/edit"

    fill_in I18n.t("tasks.title"), :with => "My edit task"
    fill_in I18n.t("tasks.content"), :with => "My edit task content"

    click_button I18n.t("helpers.submit.update")

    expect(page).to have_text(I18n.t("tasks.notice.update"))
    expect(page).to have_content('My edit task')
  end

  scenario "Create a new task" do
    visit "/tasks/new"

    fill_in I18n.t("tasks.title"), :with => "My new task"
    fill_in I18n.t("tasks.content"), :with => "My new task content"

    click_button I18n.t("helpers.submit.create")

    expect(page).to have_text(I18n.t("tasks.notice.create"))
    expect(page).to have_content('My new task')
  end

  scenario "Destroy a task" do
    visit "/"

    expect { click_link I18n.t("common.destroy") }.to change(Task, :count).by(-1)
    expect(page).to have_text(I18n.t("tasks.alert.destroy"))
  end

  scenario "See tasks and on the right order" do
    @new_task = FactoryBot.create(:task)
    visit "/"

    expect(find('table tr:nth-child(2)')).to have_content(@new_task.title)
    expect(find('table tr:nth-child(3)')).to have_content(@task.title)
  end

end
