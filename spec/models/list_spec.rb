require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all tasks in the list as complete' do
      list = List.create(name: "Chores")
      Task.create(complete: false, list_id: list.id, name: "Take out the garbage and the trash")
      Task.create(complete: false, list_id: list.id, name: "Mow the lawn and the grass")
      Task.create(complete: true, list_id: list.id, name: "Brush your teeth and clean your feet")
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end
end
