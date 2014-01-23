require 'rspec'
require 'date'
require_relative '../ILC_bot'

describe 'ILC_bot' do
  describe '#tweets?' do
    it 'は金曜日の場合、trueと空のメッセージを返す' do
      t, m = tweets?(Date.new(2014, 1, 10))
      expect(t).to be_truthy
      expect(m).to be_empty
    end

    it 'は金曜日が祝日の場合、falseと空のメッセージを返す' do
      t, m = tweets?(Date.new(2014, 3, 21))
      expect(t).to be_falsey
      expect(m).to be_empty
    end

    it 'は金曜日が祝日の場合、前日の木曜日にtrueとメッセージを返す' do
      t, m = tweets?(Date.new(2014, 3, 20))
      expect(t).to be_truthy
      expect(m).to be_present
    end
  end
end
