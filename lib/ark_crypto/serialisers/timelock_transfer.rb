require 'ark_crypto/serialisers/serialiser'

module ArkEcosystem
  module Crypto
    module Serialisers
      class TimelockTransfer < Serialiser
        def handle(bytes)
          bytes << [@transaction[:amount]].pack('Q<')
          bytes << [@transaction[:timelocktype]].pack('h*')
          bytes << [@transaction[:timelock]].pack('Q<')

          recipient_id = BTC::Base58.data_from_base58check(@transaction[:recipientId])
          recipient_id = BTC::Data.hex_from_data(recipient_id)
          bytes << [recipient_id].pack('H*')

          bytes
        end
      end
    end
  end
end
