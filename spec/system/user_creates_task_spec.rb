require "rails_helper"

RSpec.describe "task creation", type: :system, js: true do
  let(:user) do
    User.create(email: "some@guy.com", password: "password")
  end
  before do
    sign_in(user)
    visit tasks_path
  end
  context "when the task name and due date is present" do
    it "displays a success message" do
      fill_in "task_description", with: "Learn Rspec"
      fill_in "task_due_date", with: Date.tomorrow.strftime('%m/%d/%Y')
      click_button "Create Task"

      expect(page).to have_text("Task was successfully created")
    end
  end
  context "when just the task name is present" do
    it "displays a success message" do
      fill_in "task_description", with: "Learn Rspec"
      click_button "Create Task"

      expect(page).to have_text("Task was successfully created")
    end
  end
  context "when the task name is not present" do
    it "displays an error message" do
      fill_in "task_description", with: "\n"

      expect(page).to have_text("description can't be blank")
    end
  end
end
