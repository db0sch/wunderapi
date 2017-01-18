require "spec_helper"

describe Wunderapi::List do
  let(:api) {
    Wunderapi::Api.new({
      access_token: ENV['ACCESS_TOKEN'],
      client_id: ENV['CLIENT_ID']
      })
  }

  subject {
    described_class.new(
      {
        title: "Shopping",
        id: 189898,
        owner_type: "user",
        owner_id: "4023989887",
        list_type: "list",
        public: false,
        revision: 1,
        created_at: "2017-01-08T07:58:26.556Z",
        type: "list",
        api: api
      }
    )
  }

  context "attributes" do

    it "has a title" do
      expect(subject.title).to be_a String
    end

    it "raise an error if no title" do
      expect { described_class.new(title:nil) }.to raise_error("title cannot be nil")
    end

    it "has an id" do
      expect(subject.id).to be_an Integer
    end

    it 'has a owner type' do
      expect(subject.owner_type).to be_an_instance_of(String)
    end

    it 'has a owner id' do
      expect(subject.owner_id).to be_an Integer
    end

    it 'has a list_type' do
      expect(subject.list_type).to be_a String
    end

    it 'has a public attributes' do
      boolean = true if (subject.public == true) || (subject.public == false)
      expect(boolean).to be true
    end

    it 'has a revision number' do
      expect(subject.revision).to be_a Integer
    end

    it 'has a creation date' do
      expect(subject.created_at).to be_a String
    end

    it 'has a type' do
      expect(subject.type).to eq('list')
    end

    it 'has an api instance' do
      expect(subject.api).to be_an_instance_of(Wunderapi::Api)
    end
  end

  context "action" do
    subject {
      list = api.new_list("this is my new list title")
      list.save
      list
    }

    it 'can be saved to wunderlist' do
      expect(subject.id).to_not be nil
    end

    it 'can be updated to wunderlist' do
      previous_revision = subject.revision
      new_title = "The great new title"
      subject.title = new_title
      subject.save
      expect(subject.revision).to be > previous_revision
      expect(subject.title).to eq(new_title)
    end

    it 'cannot update anything to wunderlist' do
      subject.type = "task"
      subject.owner_type = "donald"
      subject.save
      expect(subject.type).to eq("list")
      expect(subject.owner_type).to eq("user")
    end

    it 'cannont update the revision number' do
      previous_revision = subject.revision
      subject.revision = 42
      expect {subject.save}.to raise_error("There is a conflict with the given data.: revision_conflict")
    end

    it 'can be destroyed on Wunderlist' do
      id = subject.id
      subject.destroy
      expect(subject.id).to be nil
      result = api.list_with_id(id)
      expect(result).to be nil
    end

    it 'can get all its tasks from Wunderlist' do
      task = subject.new_task(title: "This is a test task")
      task.save
      tasks = subject.tasks
      expect(tasks.first).to be_an_instance_of Wunderapi::Task
    end

    it "can create a new task" do
      title = "This is my new task"
      task = subject.new_task(title: title)
      task.save
      tasks = subject.tasks
      result = tasks.any? { |t| t.id == task.id }
      expect(result).to be true
    end

    it 'can get different arrays of tasks' do
      task1 = subject.new_task(title: "task #1")
      task1.save
      task2 = subject.new_task(title: "task #2")
      task2.completed!
      task2.save
      result_tasks = subject.tasks.none?(&:completed?)
      result_completed_tasks = subject.completed_tasks.all?(&:completed?)
      expect(result_tasks).to be true
      expect(result_completed_tasks).to be true
    end
  end
end
