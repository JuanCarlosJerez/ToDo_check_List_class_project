require "rails_helper"

RSpec.describe "task archiving", type: :system, js: true do
  it "displays a success message" do
    user = User.create(email: "some@guy.com", password: "password")
    user.tasks.create(description: "Learn Rspec", due_date: Date.tomorrow)

    sign_in(user)
    visit tasks_path
    click_button "Archive"

    expect(page).to have_text("Task was successfully updated")
  end
end
