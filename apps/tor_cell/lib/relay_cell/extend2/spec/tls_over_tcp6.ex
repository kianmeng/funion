# SPDX-License-Identifier: ISC

defmodule TorCell.RelayCell.Extend2.Spec.TlsOverTcp6 do
  defstruct ip: nil,
            port: nil

  # TODO: Document this
  def decode(spec) do
    <<ip::binary-size(16), spec::binary>> = spec
    <<port::16, payload::binary>> = spec
    true = byte_size(payload) == 0

    %TorCell.RelayCell.Extend2.Spec.TlsOverTcp6{
      ip: List.to_tuple(:binary.bin_to_list(ip)),
      port: port
    }
  end

  # TODO: Document this
  def encode(spec) do
    true = tuple_size(spec.ip) == 16
    :binary.list_to_bin(Tuple.to_list(spec.ip)) <> <<spec.port::16>>
  end
end
