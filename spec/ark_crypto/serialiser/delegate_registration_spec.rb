require 'spec_helper'
require 'ostruct'

require 'btcruby'
require 'ark_crypto/crypto'
require 'ark_crypto/configuration/network'
require 'ark_crypto/networks/devnet'
require 'ark_crypto/serialisers/delegate_registration'

describe ArkEcosystem::Crypto::Serialisers::DelegateRegistration do
  describe '#serialise' do
    it 'should be ok' do
      transaction = JSON.parse!(File.read('spec/fixtures/transactions/delegate_registration.json'), object_class: OpenStruct)

      ArkEcosystem::Crypto::Configuration::Network.set(ArkEcosystem::Crypto::Networks::Devnet)
      serialiser = ArkEcosystem::Crypto::Serialisers::DelegateRegistration.new(transaction)

      actual = serialiser.serialise

      expect(actual).to eq(transaction[:serialized])
    end
  end
end
