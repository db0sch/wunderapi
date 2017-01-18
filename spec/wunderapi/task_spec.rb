require "spec_helper"

describe Wunderapi::Task do
  let(:api) {
    Wunderapi::Api.new({
      access_token: ENV['ACCESS_TOKEN'],
      client_id: ENV['CLIENT_ID']
      })
  }

  let(:list) {
    list = api.lists.first
  }

  subject {
    described_class.new(
      {
        list_id: list.id,
        title: "Hello",
        api: api
      }
    )
  }

  context "validation" do
    it 'has a title' do
      expect(subject.title).to be_an_instance_of String
    end

    it 'has a list id' do
      expect(subject.list_id).to be_an_instance_of Fixnum
    end

    it 'raise an error if no list_id' do
      expect { described_class.new(title: "one task") }.to raise_error("list_id cannot be nil")
    end

    it 'raise an error if no title' do
      expect { described_class.new(list_id: list.id) }.to raise_error("title cannot be nil")
    end
  end

  context "actions" do

      subject {
        task = described_class.new(
          {
            list_id: list.id,
            title: "Hello",
            api: api
          }
        )
        task.save
        task
      }

    it 'can be saved to Wunderlist' do
      expect(subject.id).to_not be nil
    end

    it 'can be updated to Wunderlist' do
      before_revision = subject.revision
      new_title = "Goodbye"
      subject.title = new_title
      subject.save
      expect(subject.title).to eq(new_title)
      expect(subject.revision).to be > before_revision
    end

    it 'cannot mess with the revision number' do
      subject.revision = subject.revision + 42
      expect {subject.save}.to raise_error("There is a conflict with the given data.: revision_conflict")
    end

    it 'can be destroyed' do
      id = subject.id
      subject.destroy
      expect(subject.id).to be nil
      # try to get the task with the id and check something like this.
      # result = api.list_with_id(id)
      # expect(result).to be nil
    end

    it 'can be completed' do
      # subject.completed_at # find the right time format
      # subject.save
      # get the task by id
      # check if completed
    end

    it 'can be uncompleted' do
      # subject.completed_at
      # subject.save
      # subject.completed_at = nil
      
    end

    it 'can have a due date' do

    end

    it 'can be starred' do

    end

  end

end
