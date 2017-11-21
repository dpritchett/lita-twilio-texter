require "spec_helper"

describe Lita::Handlers::TwilioTexter, lita_handler: true do
  let(:robot) { Lita::Robot.new(registry) }

  subject { described_class.new(robot) }
  
  describe ':text' do
    it { is_expected.to route("Lita text 12134441234 hi mom") }
    it { is_expected.to_not route("Lita text hi mom") }

    it 'sends texts' do
      send_message 'Lita text 19016052970 hey daniel'
      expect(replies.last).to eq('Sent message to 19016052970')
    end
  end

  describe ':client' do
    it 'should return a logged-in Twilio client' do
      clt = subject.client
      expect(clt.account_sid.empty?).to be_falsey
      expect(clt.auth_token.empty?).to be_falsey
    end
  end

  # dependent on my area code, naturally
  describe ':send_from_number' do
    it 'should return a Memphis-area phone number' do
      number = subject.send_from_number
      expect(number.start_with?('+1901')).to be_truthy
    end
  end
end


