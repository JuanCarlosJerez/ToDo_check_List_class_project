require "rails_helper"

RSpec.describe Task, :type => :model do
  describe "#user" do
    it "returns the user whose id matches its user_id attribute" do
      user = User.create!(email: "some@guy.com", password: "password")

      other_user = User.create!(email: "other@guy.com", password: "password")
      task = Task.create!(description: "Learn Rspec", user_id: user.id)

      expect(task.user).to eq(user)
    end
  end
  describe ".completed" do
    it "returns a collection of tasks that are completed" do
      user = User.create!(email: "some@guy.com", password: "password")

      completed = user.tasks.create!(description: "completed", completed: true)
      incomplete = user.tasks.create!(description: "incomplete", completed: false)

      expect(Task.completed).to eq([completed])
    end
  end
    describe ".incomplete" do
    it "returns a collection of tasks that are incomplete" do
      user = User.create!(email: "some@guy.com", password: "password")

      completed = user.tasks.create!(description: "completed", completed: true)
      incomplete = user.tasks.create!(description: "incomplete", completed: false)

      expect(Task.incomplete).to eq([incomplete])
    end
  end
    describe ".by_due_date" do
    context "when all of the tasks have due dates" do
      it "returns a collection of tasks ordered by their due date, with tasks without due dates last" do
        user = User.create!(email: "some@guy.com", password: "password")

        past_due = user.tasks.create!(description: "past due", due_date: Date.yesterday)
        due_soon = user.tasks.create!(description: "due soon", due_date: 3.days.from_now.to_date)
        due_later = user.tasks.create!(description: "due later", due_date: 4.days.from_now.to_date)

        expect(Task.by_due_date).to eq([past_due, due_soon, due_later])
      end
    end
    context "when some of the tasks don't have due dates" do
      it "returns a collection of tasks, with the ones without due dates last" do
        user = User.create!(email: "some@guy.com", password: "password")

        not_due = user.tasks.create!(description: "not due", due_date: nil)
        past_due = user.tasks.create!(description: "past due", due_date: Date.yesterday)

        expect(Task.by_due_date).to eq([past_due, not_due])
      end
    end
  end
  describe ".past_due" do
    it "returns a collection of tasks due in the past" do
      user = User.create!(email: "some@guy.com", password: "password")

      not_due = user.tasks.create!(description: "not due", due_date: nil)
      past_due = user.tasks.create!(description: "past due", due_date: Date.yesterday)
      due_soon = user.tasks.create!(description: "due soon", due_date: 3.days.from_now.to_date)
      due_later = user.tasks.create!(description: "due later", due_date: 4.days.from_now.to_date)

      expect(Task.past_due).to eq([past_due])
    end
  end
  describe ".not_due" do
    it "returns a collection of tasks not due" do
      user = User.create!(email: "some@guy.com", password: "password")

      not_due = user.tasks.create!(description: "not due", due_date: nil)

      expect(Task.not_due).to eq([not_due])
    end
  end
  describe ".due_soon" do
    it "returns a collection of tasks that are due soon, within 3 days" do
      user = User.create!(email: "some@guy.com", password: "password")

      due_soon = user.tasks.create!(description: "due soon", due_date: 3.days.from_now.to_date)

      expect(Task.due_soon).to eq([due_soon])
    end
  end
  describe ".due_later" do
    it "returns a collection of tasks that are due later, 4 days after" do
      user = User.create!(email: "some@guy.com", password: "password")

      due_later = user.tasks.create!(description: "due later", due_date: 4.days.from_now.to_date)

      expect(Task.due_later).to eq([due_later])
    end
  end
end
