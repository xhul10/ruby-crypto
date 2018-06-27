require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/serialisers/delegate_resignation'

describe ArkCrypto::Serialisers::DelegateResignation do
  describe '#serialise' do
    skip it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/delegate_resignation.json'), object_class: OpenStruct)

      serialiser = ArkCrypto::Serialisers::DelegateResignation.new(transaction)

      actual = serialiser.serialise

      expect(actual).to eq(transaction[:serialized])
    end
  end
end
