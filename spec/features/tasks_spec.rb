require "rails_helper"

RSpec.feature "tasks", :type => :feature do

  before(:each) do
    @task = FactoryBot.create(:task)
  end

  scenario "Update a task" do
    visit "/tasks/1/edit"

    fill_in "Title", :with => "My edit task"
    fill_in "Content", :with => "My edit task content"

    click_button "Update Task"

    expect(page).to have_text("task was successfully updated")
    expect(page).to have_content('My edit task')
  end

  scenario "Create a new task" do
    visit "/tasks/new"

    fill_in "Title", :with => "My new task"
    fill_in "Content", :with => "My new task content"

    click_button "Create Task"

    expect(page).to have_text("task was successfully created")
    expect(page).to have_content('My new task')
  end

  scenario "Destroy a task" do
    visit "/"

    expect { click_link 'Destroy' }.to change(Task, :count).by(-1)
    expect(page).to have_text("task was deleted")
  end

  scenario "See tasks" do
    visit "/"

    expect(page).to have_content('task title 4')
  end

end
