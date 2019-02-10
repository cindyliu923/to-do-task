require "rails_helper"

RSpec.feature "tasks", :type => :feature do

  before(:each) do
    @task = FactoryBot.create(:task)
    log_in_with_task(@task)
  end

  scenario "Update a task" do
    tag = FactoryBot.create(:tag)
    visit "/tasks/#{@task.id}/edit"
    deadline = Timecop.travel('2019-02-10 15:20:00 +0800')

    fill_in I18n.t("tasks.title"), :with => "My edit task"
    fill_in I18n.t("tasks.content"), :with => "My edit task content"
    fill_in "task[deadline]", :with => deadline
    select I18n.t("tasks.priority.medium"), :from => I18n.t("common.priority")
    find("#task_tag_items").select(tag.name)

    click_button I18n.t("helpers.submit.update")

    expect(page).to have_text(I18n.t("tasks.notice.update"))
    expect(page).to have_content('My edit task')
    expect(page).to have_content('My edit task content')
    expect(page).to have_content(tag.name)
    expect(page).to have_content(deadline)
    expect(page).to have_content(I18n.t("tasks.priority.medium"))
  end

  scenario "Create a new task" do
    visit "/tasks/new"
    deadline = Timecop.travel('2019-02-10 15:20:00 +0800')

    fill_in I18n.t("tasks.title"), :with => "My new task"
    fill_in I18n.t("tasks.content"), :with => "My new task content"
    fill_in "task[deadline]", :with => deadline
    select I18n.t("tasks.priority.medium"), :from => I18n.t("common.priority")

    click_button I18n.t("helpers.submit.create")

    expect(page).to have_text(I18n.t("tasks.notice.create"))
    expect(page).to have_content('My new task')
    expect(page).to have_content(deadline)
    expect(page).to have_content(I18n.t("tasks.priority.medium"))
  end

  scenario "Destroy a task" do
    visit "/"

    expect { click_link I18n.t("common.destroy") }.to change(Task, :count).by(-1)
    expect(page).to have_text(I18n.t("tasks.alert.destroy"))
  end

  scenario "See tasks and default order by created at" do
    @new_task = FactoryBot.create(:task, user: @task.user)
    visit "/"

    expect(find('table tr:nth-child(2)')).to have_content(@new_task.title)
    expect(find('table tr:nth-child(3)')).to have_content(@task.title)
  end

  scenario "Change tasks order by deadline" do
    deadline_earlier_task = FactoryBot.create(:task, :deadline_earlier, user: @task.user)
    deadline_later_task = FactoryBot.create(:task, :deadline_later, user: @task.user)
    visit "/"
    click_link I18n.t("tasks.deadline")

    expect(find('table tr:nth-child(2)')).to have_content(deadline_earlier_task.title)
    expect(find('table tr:nth-child(3)')).to have_content(@task.title)
    expect(find('table tr:nth-child(4)')).to have_content(deadline_later_task.title)

    click_link I18n.t("tasks.deadline")

    expect(find('table tr:nth-child(2)')).to have_content(deadline_later_task.title)
    expect(find('table tr:nth-child(3)')).to have_content(@task.title)
    expect(find('table tr:nth-child(4)')).to have_content(deadline_earlier_task.title)
  end

  scenario "Search tasks by title, status, tag and can change task status" do
    @task.tags.create(name: 'Tag1')
    visit "/"

    select 'Tag1', :from => I18n.t("tag.title")
    click_button I18n.t('ransack.search')

    expect(find('table tr:nth-child(2)')).to have_content(@task.title)

    fill_in I18n.t("common.title"), :with => "task"
    select I18n.t("tasks.status.todo"), :from => I18n.t("common.status")

    click_button I18n.t('ransack.search')
    expect(find('table tr:nth-child(2)')).to have_content(@task.title)
    expect(find('table tr:nth-child(2)')).to have_content(I18n.t("tasks.status.todo"))

    click_link I18n.t("tasks.up")
    select I18n.t("tasks.status.doing"), :from => I18n.t("common.status")
    click_button I18n.t('ransack.search')

    expect(find('table tr:nth-child(2)')).to have_content(@task.title)
    expect(find('table tr:nth-child(2)')).to have_content(I18n.t("tasks.status.doing"))
    expect(find('table tr:nth-child(2)')).to have_content(I18n.t("tasks.down"))

    click_link I18n.t("tasks.down")
    select I18n.t("tasks.status.done"), :from => I18n.t("common.status")
    click_button I18n.t('ransack.search')

    expect(find('table tr:nth-child(2)')).to have_content(@task.title)
    expect(find('table tr:nth-child(2)')).to have_content(I18n.t("tasks.status.done"))
    expect(find('table tr:nth-child(2)')).to have_content('')
  end

  scenario "Change tasks order by priority" do
    medium_task = FactoryBot.create(:task, :medium, user: @task.user)
    high_task = FactoryBot.create(:task, :high, user: @task.user)
    visit "/"
    click_link I18n.t("common.priority")

    expect(find('table tr:nth-child(2)')).to have_content(high_task.title)
    expect(find('table tr:nth-child(3)')).to have_content(medium_task.title)
    expect(find('table tr:nth-child(4)')).to have_content(@task.title)

    click_link I18n.t("tasks.deadline")

    expect(find('table tr:nth-child(2)')).to have_content(@task.title)
    expect(find('table tr:nth-child(3)')).to have_content(medium_task.title)
    expect(find('table tr:nth-child(4)')).to have_content(high_task.title)
  end

end
