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

  it 'can return all the lists' do
    expect(subject.lists).to be_an Array
    expect(subject.lists.first).to be_an_instance_of(Wunderapi::List)
  end
end
