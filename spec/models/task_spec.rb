require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it 'should change complete attribute from false to true' do
      task = Task.new(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end

    it 'should change complete attribute from true to false' do
      task = Task.new(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
  end

  describe '#toggle_favorite!' do
    it 'should change favorite attribute from false to true' do
      task = Task.new(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it 'should change favorite attribute from true to false' do
      task = Task.new(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe '#overdue?' do
    it 'should return false if task\'s deadline is past now' do
      task = Task.new(deadline: 1.day.from_now)
      expect(task.overdue?).to eq(false)
    end

    it 'should return true if task\'s deadline is before now' do
      task = Task.new(deadline: 1.day.ago)
      expect(task.overdue?).to eq(true)
    end
  end

  describe '#increment_priority!' do
    it 'should increase the priority attribute by 1' do
      task = Task.new(priority: 5)
      task.increment_priority!
      expect(task.priority).to eq(6)
    end

    it 'should not increment priority beyond 10' do
      task = Task.new(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(8)
    end
  end

  describe '#decrement_priority!' do
    it 'should decrease the priority attribute by 1' do
      task = Task.new(priority: 5)
      task.decrement_priority!
      expect(task.priority).to eq(4)
    end

    it 'should not decrement priority below 1' do
      task = Task.new(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    it 'should push deadline off by an hour' do
      deadline = DateTime.new(2001, 2, 3)
      task = Task.create(deadline: deadline)
      task.snooze_hour!
      expect(task.deadline).to eq(deadline + 1.hour)
    end
  end
end
