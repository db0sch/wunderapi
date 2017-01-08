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

  it "has a title" do
    expect(subject.title).to be_a String
  end

  it "has an id" do
    expect(subject.uid).to be_an Integer
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
