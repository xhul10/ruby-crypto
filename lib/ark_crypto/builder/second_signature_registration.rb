require 'ark_crypto/crypto'
require 'ark_crypto/enums/fees'
require 'ark_crypto/enums/types'
require 'ark_crypto/builder/transaction'
require 'ark_crypto/builder/utils/signing'

module ArkEcosystem
  module Crypto
    module Builder
      class SecondSignatureRegistration
        include Utils::Signing

        def initialize
          @type = ArkEcosystem::Crypto::Enums::Types::SECOND_SIGNATURE_REGISTRATION
          @fee = ArkEcosystem::Crypto::Enums::Fees::SECOND_SIGNATURE_REGISTRATION
        end

        def set_second_secret(second_secret)
          second_key = ArkEcosystem::Crypto::Crypto.get_key(second_secret)

          asset = {
            :signature => {
              :public_key => second_key.public_key.unpack('H*').first
            }
          }

          @transaction.set_asset(asset)
          self
        end

        def create
          @transaction = Transaction.new(
            :type => @type,
            :fee => @fee,
            :amount => 0
          )

          self
        end
      end
    end
  end
end
