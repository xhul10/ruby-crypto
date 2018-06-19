require "spec_helper"

require 'ark_crypto/crypto'
require 'ark_crypto/transactions/second_signature_registration'

describe ArkCrypto::Transactions::SecondSignatureRegistration do
  let(:amount) { 133380000000 }
  let(:recipient_id) { 'AXoXnFi4z1Z6aFvjEYkDVCtBGW2PaRiM25' }
  let(:vendor_field) { 'This is a transaction from PHP' }
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { nil }
  let(:dev_network_address) { '1e' }

  shared_examples_for 'a transaction' do
    it 'is valid' do
      expect(ArkCrypto::Crypto.verify(subject)).to be_truthy
    end
  end

  shared_examples_for 'a transaction signed twice' do
    let(:second_public_key_address) { ArkCrypto::Crypto.get_key(second_secret).public_key.unpack('H*').first }

    it 'is valid' do
      expect(ArkCrypto::Crypto.verify(subject)).to be_truthy
      expect(ArkCrypto::Crypto.second_verify(subject, second_public_key_address)).to be_truthy
    end
  end

  describe '#create' do
    let(:second_secret) { 'this is a top secret second passphrase' }
    subject { described_class.new.create(second_secret, secret) }

    it_behaves_like 'a transaction'
  end
end
