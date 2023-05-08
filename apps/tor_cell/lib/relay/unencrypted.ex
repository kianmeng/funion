defmodule TorCell.Relay.Unencrypted do
  defstruct cmd: nil,
            stream_id: nil,
            payload: nil

  defp is_decrypted?(data, our_digest) do
    <<_, remainder::binary>> = data
    <<recognized::16, remainder::binary>> = remainder
    <<_::16, remainder::binary>> = remainder
    <<their_digest::32, _::binary>> = remainder

    # Replace the digest field in data with four zeros
    <<data_prefix::binary-size(5), data_suffix::binary>> = data
    <<_::binary-size(4), data_suffix::binary>> = data_suffix
    data = data_prefix <> <<0::32>> <> data_suffix

    our_digest = TorCrypto.Digest.update(our_digest, data)
    <<our_digest::32>> = TorCrypto.Digest.calculate(our_digest)

    recognized == 0 && their_digest == our_digest
  end

  @doc """
  Decrypts a RELAY TorCell by removing length(keys) onion layers from it.

  Returns a TorCell.Relay.Unencrypted if all onion layers have been removed or
  a TorCell.Relay with as much onion layers removed as possible.

  Returns a tuple containing a {true, %TorCell.Relay.Unencrypted} if all onion
  skins could have been removed successfully or a {false, %TorCell.Relay} if
  it could not be fully decrypted.
  """
  def decrypt(cell, keys, digest) do
    data = TorCrypto.OnionSkin.decrypt(cell.onion_skin, keys)

    if is_decrypted?(data, digest) do
      <<cmd, data::binary>> = data
      <<_::16, data::binary>> = data
      <<stream_id::16, data::binary>> = data
      <<_::32, data::binary>> = data
      <<length::16, data::binary>> = data
      <<payload::binary-size(length), data::binary>> = data

      padding_len = 509 - 11 - length
      <<_::binary-size(padding_len), _::binary>> = data

      {
        true,
        %TorCell.Relay.Unencrypted{
          cmd: cmd,
          stream_id: stream_id,
          payload: payload
        }
      }
    else
      {
        false,
        TorCell.Relay.encode(data)
      }
    end
  end
end