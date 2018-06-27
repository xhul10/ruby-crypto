require 'spec_helper'
require 'ostruct'

require 'ark_crypto/crypto'
require 'ark_crypto/configuration/network'
require 'ark_crypto/networks/devnet'
require 'ark_crypto/builder/delegate_registration'

describe ArkCrypto::Builder::DelegateRegistration do
  let(:secret) { 'this is a top secret passphrase' }
  let(:second_secret) { 'this is a top secret second passphrase' }
  let(:username) { 'polo polo' }

  it 'should be ok with a secret' do
    ArkCrypto::Configuration::Network.set(ArkCrypto::Networks::Devnet)

    transaction = described_class.new
    .username(username)
    .create
    .sign(secret)
    .get_struct

    expect(ArkCrypto::Crypto.verify(transaction)).to be_truthy
  end

  it 'should be ok with a second secret' do
    ArkCrypto::Configuration::Network.set(ArkCrypto::Networks::Devnet)

    transaction = described_class.new
    .username(username)
    .create
    .sign(secret)
    .second_sign(second_secret)
    .get_struct

    second_public_key_address = ArkCrypto::Crypto.get_key(second_secret).public_key.unpack('H*').first

    expect(ArkCrypto::Crypto.verify(transaction)).to be_truthy
    expect(ArkCrypto::Crypto.second_verify(transaction, second_public_key_address)).to be_truthy
  end
end
