require 'arkecosystem/crypto/serialisers/serialiser'

module ArkEcosystem
  module Crypto
    module Serialisers
      # The serialiser for multi signature registrations transactions.
      class MultiSignatureRegistration < Serialiser
        def handle(bytes)
          keysgroup = []

          if @transaction[:version] == 1 || @transaction[:version].empty?
            @transaction[:asset][:multisignature][:keysgroup].each do |item|
              if item.start_with?('+')
                keysgroup.push(item[1..-1])
              else
                keysgroup.push(item)
              end
            end
          else
            keysgroup = @transaction[:asset][:multisignature][:keysgroup]
          end

          bytes << [@transaction[:asset][:multisignature][:min]].pack('C')
          bytes << [@transaction[:asset][:multisignature][:keysgroup].count].pack('C')
          bytes << [@transaction[:asset][:multisignature][:lifetime]].pack('C')
          bytes << BTC::Data.data_from_hex(keysgroup.join(''))

          bytes
        end
      end
    end
  end
end
