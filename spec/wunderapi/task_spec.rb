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
      due_date: "2013-08-30",
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
  end

  context "actions" do
    it 'can be saved to Wunderlist' do

    end

    it 'can be updated to Wunderlist' do

    end

    it 'cannot mess with the revision number' do

    end

    it 'can be destroyed' do

    end

    it 'can be completed' do

    end

    it 'can be uncompleted' do

    end

    it 'can have a due date' do

    end

    it 'can be starred' do

    end

  end

end
