require 'arkecosystem/crypto/deserialisers/deserialiser'

module ArkEcosystem
  module Crypto
    module Deserialisers
      class DelegateRegistration < Deserialiser
        def handle(asset_offset, transaction)
          transaction[:asset] = {
            delegate: {}
          }

          username_length = @binary.unpack("C#{asset_offset / 2}Q<").last & 0xff

          username = @serialized[asset_offset + 2, username_length * 2]

          transaction[:asset][:delegate][:username] = BTC::Data.data_from_hex(username)

          ArkEcosystem::Crypto::Crypto.parse_signatures(@serialized, transaction, asset_offset + (username_length + 1) * 2)
        end
      end
    end
  end
end
