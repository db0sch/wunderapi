require "spec_helper"

describe Wunderapi::Api do
  subject {
    described_class.new(
      access_token: ENV['ACCESS_TOKEN'],
      client_id: ENV['CLIENT_ID']
    )
  }

  it "has a access token" do
    expect(subject.access_token).not_to be nil
  end

  it "has a client id" do
    expect(subject.client_id).not_to be nil
  end

  it "should raise an error is access_token is nil" do
    expect { described_class.new(client_id: ENV['CLIENT_ID']) }.to raise_error("access_token cannot be nil")
  end

  it "should raise an error is client_id is nil" do
    expect { described_class.new(access_token: ENV['ACCESS_TOKEN']) }.to raise_error("client_id cannot be nil")
  end


  it 'can return all the lists' do
    expect(subject.lists).to be_an Array
    expect(subject.lists.first).to be_an_instance_of(Wunderapi::List)
  end

  it 'can return a list by the id' do
    id = subject.lists.first.id
    list = subject.list_with_id(id)
    expect(list).to be_an_instance_of(Wunderapi::List)
  end

  it 'can create a new list' do
    list = subject.new_list("this is a list title")
    expect(list).to be_an_instance_of Wunderapi::List
    expect(list.title).to be_an_instance_of String
  end

end
