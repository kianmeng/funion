# SPDX-License-Identifier: ISC

defmodule TorCellCertsCertTest do
  use ExUnit.Case
  doctest TorCell.Certs.Cert

  # The certificates in use were generously taken from my own Tor relay. :^)

  test "fetches an X509 cert" do
    raw =
      <<48, 130, 1, 202, 48, 130, 1, 51, 160, 3, 2, 1, 2, 2, 9, 0, 243, 46, 103, 60, 91, 234, 164,
        112, 48, 13, 6, 9, 42, 134, 72, 134, 247, 13, 1, 1, 11, 5, 0, 48, 39, 49, 37, 48, 35, 6,
        3, 85, 4, 3, 12, 28, 119, 119, 119, 46, 109, 111, 99, 54, 97, 50, 122, 97, 101, 117, 55,
        121, 52, 115, 109, 122, 117, 108, 52, 120, 46, 99, 111, 109, 48, 30, 23, 13, 50, 50, 49,
        48, 49, 48, 48, 48, 48, 48, 48, 48, 90, 23, 13, 50, 51, 49, 48, 49, 48, 48, 48, 48, 48,
        48, 48, 90, 48, 39, 49, 37, 48, 35, 6, 3, 85, 4, 3, 12, 28, 119, 119, 119, 46, 109, 111,
        99, 54, 97, 50, 122, 97, 101, 117, 55, 121, 52, 115, 109, 122, 117, 108, 52, 120, 46, 99,
        111, 109, 48, 129, 159, 48, 13, 6, 9, 42, 134, 72, 134, 247, 13, 1, 1, 1, 5, 0, 3, 129,
        141, 0, 48, 129, 137, 2, 129, 129, 0, 230, 102, 44, 188, 121, 66, 198, 200, 101, 194, 237,
        0, 91, 234, 93, 224, 148, 34, 26, 114, 59, 17, 231, 70, 252, 24, 76, 82, 34, 133, 84, 76,
        199, 96, 238, 101, 100, 252, 74, 215, 108, 1, 11, 14, 60, 86, 89, 237, 238, 105, 31, 92,
        76, 252, 164, 124, 47, 121, 212, 182, 182, 114, 67, 210, 94, 124, 106, 43, 101, 138, 196,
        233, 220, 223, 218, 158, 38, 78, 40, 134, 219, 16, 232, 255, 170, 214, 111, 68, 62, 254,
        242, 98, 148, 233, 141, 245, 222, 114, 41, 141, 219, 77, 58, 34, 195, 239, 208, 87, 206,
        142, 249, 175, 22, 35, 73, 50, 9, 16, 208, 2, 49, 247, 220, 67, 230, 95, 7, 233, 2, 3, 1,
        0, 1, 48, 13, 6, 9, 42, 134, 72, 134, 247, 13, 1, 1, 11, 5, 0, 3, 129, 129, 0, 142, 46,
        151, 42, 31, 230, 118, 197, 154, 203, 135, 178, 231, 24, 0, 179, 225, 8, 168, 106, 209,
        144, 204, 238, 60, 172, 70, 131, 195, 11, 65, 18, 177, 224, 24, 79, 36, 17, 15, 2, 217,
        251, 91, 104, 237, 39, 229, 133, 239, 179, 102, 45, 245, 156, 177, 234, 241, 215, 243, 42,
        228, 238, 89, 57, 36, 239, 35, 188, 56, 225, 33, 82, 119, 186, 47, 163, 156, 220, 157,
        188, 75, 63, 189, 183, 126, 185, 103, 171, 66, 209, 47, 215, 60, 170, 93, 93, 78, 178,
        232, 245, 129, 59, 118, 201, 174, 15, 248, 61, 49, 109, 110, 217, 207, 107, 218, 167, 231,
        217, 74, 47, 234, 182, 214, 158, 227, 42, 202, 235>>

    cert = <<2>> <> <<byte_size(raw)::16>> <> raw <> <<42, 69>>

    {cert, payload} = TorCell.Certs.Cert.fetch(cert)
    assert cert.type == :rsa_id
    assert cert.cert == :public_key.pkix_decode_cert(raw, :plain)

    assert payload == <<42, 69>>
  end

  test "fetches an Ed25519 cert" do
    raw =
      <<1, 4, 0, 7, 33, 196, 1, 21, 195, 194, 141, 132, 50, 207, 113, 139, 70, 72, 23, 89, 84,
        174, 235, 255, 176, 47, 135, 165, 114, 166, 20, 243, 149, 223, 81, 221, 149, 34, 121, 1,
        0, 32, 4, 0, 194, 4, 162, 205, 242, 49, 217, 184, 187, 127, 147, 15, 211, 173, 83, 179,
        26, 111, 116, 63, 71, 28, 173, 15, 33, 128, 137, 199, 170, 24, 162, 214, 126, 87, 191,
        221, 228, 211, 40, 51, 76, 218, 59, 44, 246, 69, 128, 88, 202, 119, 149, 210, 218, 90,
        202, 93, 101, 175, 206, 140, 203, 91, 184, 175, 31, 33, 72, 63, 91, 196, 103, 40, 144,
        114, 231, 206, 29, 192, 53, 144, 214, 70, 133, 170, 155, 176, 21, 31, 30, 86, 51, 140,
        142, 132, 60, 4>>

    {raw_decoded, _} = TorCert.Ed25519.fetch(raw)

    cert = <<4>> <> <<byte_size(raw)::16>> <> raw <> <<42, 69>>

    {cert, payload} = TorCell.Certs.Cert.fetch(cert)
    assert cert.type == :ed25519_id_signing
    assert cert.cert == raw_decoded

    assert payload == <<42, 69>>
  end

  test "fetches an RsaEd25519 cert" do
    raw =
      <<194, 4, 162, 205, 242, 49, 217, 184, 187, 127, 147, 15, 211, 173, 83, 179, 26, 111, 116,
        63, 71, 28, 173, 15, 33, 128, 137, 199, 170, 24, 162, 214, 0, 7, 48, 155, 128, 9, 96, 80,
        227, 196, 80, 231, 98, 239, 52, 34, 23, 69, 78, 249, 215, 190, 154, 91, 209, 163, 7, 141,
        180, 49, 228, 10, 248, 97, 67, 10, 38, 88, 48, 83, 214, 35, 166, 199, 224, 160, 235, 115,
        117, 119, 85, 44, 72, 59, 130, 165, 69, 225, 70, 93, 245, 18, 29, 240, 48, 152, 196, 34,
        78, 180, 108, 177, 39, 225, 195, 150, 10, 75, 152, 242, 52, 5, 127, 228, 92, 134, 181,
        183, 201, 37, 142, 92, 34, 11, 253, 76, 48, 242, 47, 107, 206, 183, 4, 54, 169, 126, 161,
        221, 240, 140, 1, 167, 196, 28, 50, 185, 145, 227, 113, 232, 88, 1, 70, 72, 117, 232, 224,
        51, 40, 51, 130, 108, 58>>

    {raw_decoded, _} = TorCert.RsaEd25519.fetch(raw)

    cert = <<7>> <> <<byte_size(raw)::16>> <> raw <> <<42, 69>>

    {cert, payload} = TorCell.Certs.Cert.fetch(cert)
    assert cert.type == :rsa_ed25519_cross_cert
    assert cert.cert == raw_decoded

    assert payload == <<42, 69>>
  end

  test "encodes an X509 cert" do
    cert = %TorCell.Certs.Cert{
      cert:
        {:Certificate,
         {:TBSCertificate, :v3, 6_870_588_164_991_805_121,
          {:AlgorithmIdentifier, {1, 2, 840, 113_549, 1, 1, 11}, <<5, 0>>},
          {:rdnSequence,
           [
             [
               {:AttributeTypeAndValue, {2, 5, 4, 3},
                <<12, 21, 119, 119, 119, 46, 54, 111, 104, 98, 55, 99, 102, 55, 105, 101, 107,
                  112, 104, 46, 99, 111, 109>>}
             ]
           ]}, {:Validity, {:utcTime, '230114000000Z'}, {:utcTime, '240114000000Z'}},
          {:rdnSequence,
           [
             [
               {:AttributeTypeAndValue, {2, 5, 4, 3},
                <<12, 21, 119, 119, 119, 46, 54, 111, 104, 98, 55, 99, 102, 55, 105, 101, 107,
                  112, 104, 46, 99, 111, 109>>}
             ]
           ]},
          {:SubjectPublicKeyInfo, {:AlgorithmIdentifier, {1, 2, 840, 113_549, 1, 1, 1}, <<5, 0>>},
           <<48, 129, 137, 2, 129, 129, 0, 230, 102, 44, 188, 121, 66, 198, 200, 101, 194, 237, 0,
             91, 234, 93, 224, 148, 34, 26, 114, 59, 17, 231, 70, 252, 24, 76, 82, 34, 133, 84,
             76, 199, 96, 238, 101, 100, 252, 74, 215, 108, 1, 11, 14, 60, 86, 89, 237, 238, 105,
             31, 92, 76, 252, 164, 124, 47, 121, 212, 182, 182, 114, 67, 210, 94, 124, 106, 43,
             101, 138, 196, 233, 220, 223, 218, 158, 38, 78, 40, 134, 219, 16, 232, 255, 170, 214,
             111, 68, 62, 254, 242, 98, 148, 233, 141, 245, 222, 114, 41, 141, 219, 77, 58, 34,
             195, 239, 208, 87, 206, 142, 249, 175, 22, 35, 73, 50, 9, 16, 208, 2, 49, 247, 220,
             67, 230, 95, 7, 233, 2, 3, 1, 0, 1>>}, :asn1_NOVALUE, :asn1_NOVALUE, :asn1_NOVALUE},
         {:AlgorithmIdentifier, {1, 2, 840, 113_549, 1, 1, 11}, <<5, 0>>},
         <<53, 239, 199, 39, 107, 23, 239, 188, 199, 162, 170, 18, 98, 58, 9, 237, 237, 185, 24,
           97, 220, 72, 145, 59, 40, 13, 161, 254, 103, 29, 85, 51, 144, 153, 235, 236, 159, 222,
           206, 13, 59, 31, 123, 130, 190, 254, 136, 247, 170, 19, 73, 61, 198, 99, 40, 64, 137,
           237, 72, 126, 139, 116, 25, 154, 220, 91, 13, 118, 249, 38, 68, 136, 142, 178, 226, 99,
           10, 190, 57, 201, 69, 125, 226, 50, 205, 26, 109, 213, 221, 34, 85, 240, 211, 83, 178,
           112, 134, 62, 122, 122, 14, 215, 206, 139, 214, 164, 212, 247, 3, 215, 3, 218, 247,
           125, 13, 253, 116, 24, 78, 139, 246, 202, 178, 247, 247, 53, 70, 86>>},
      type: :rsa_id
    }

    raw =
      <<48, 130, 1, 187, 48, 130, 1, 36, 160, 3, 2, 1, 2, 2, 8, 95, 89, 59, 136, 188, 86, 230,
        193, 48, 13, 6, 9, 42, 134, 72, 134, 247, 13, 1, 1, 11, 5, 0, 48, 32, 49, 30, 48, 28, 6,
        3, 85, 4, 3, 12, 21, 119, 119, 119, 46, 54, 111, 104, 98, 55, 99, 102, 55, 105, 101, 107,
        112, 104, 46, 99, 111, 109, 48, 30, 23, 13, 50, 51, 48, 49, 49, 52, 48, 48, 48, 48, 48,
        48, 90, 23, 13, 50, 52, 48, 49, 49, 52, 48, 48, 48, 48, 48, 48, 90, 48, 32, 49, 30, 48,
        28, 6, 3, 85, 4, 3, 12, 21, 119, 119, 119, 46, 54, 111, 104, 98, 55, 99, 102, 55, 105,
        101, 107, 112, 104, 46, 99, 111, 109, 48, 129, 159, 48, 13, 6, 9, 42, 134, 72, 134, 247,
        13, 1, 1, 1, 5, 0, 3, 129, 141, 0, 48, 129, 137, 2, 129, 129, 0, 230, 102, 44, 188, 121,
        66, 198, 200, 101, 194, 237, 0, 91, 234, 93, 224, 148, 34, 26, 114, 59, 17, 231, 70, 252,
        24, 76, 82, 34, 133, 84, 76, 199, 96, 238, 101, 100, 252, 74, 215, 108, 1, 11, 14, 60, 86,
        89, 237, 238, 105, 31, 92, 76, 252, 164, 124, 47, 121, 212, 182, 182, 114, 67, 210, 94,
        124, 106, 43, 101, 138, 196, 233, 220, 223, 218, 158, 38, 78, 40, 134, 219, 16, 232, 255,
        170, 214, 111, 68, 62, 254, 242, 98, 148, 233, 141, 245, 222, 114, 41, 141, 219, 77, 58,
        34, 195, 239, 208, 87, 206, 142, 249, 175, 22, 35, 73, 50, 9, 16, 208, 2, 49, 247, 220,
        67, 230, 95, 7, 233, 2, 3, 1, 0, 1, 48, 13, 6, 9, 42, 134, 72, 134, 247, 13, 1, 1, 11, 5,
        0, 3, 129, 129, 0, 53, 239, 199, 39, 107, 23, 239, 188, 199, 162, 170, 18, 98, 58, 9, 237,
        237, 185, 24, 97, 220, 72, 145, 59, 40, 13, 161, 254, 103, 29, 85, 51, 144, 153, 235, 236,
        159, 222, 206, 13, 59, 31, 123, 130, 190, 254, 136, 247, 170, 19, 73, 61, 198, 99, 40, 64,
        137, 237, 72, 126, 139, 116, 25, 154, 220, 91, 13, 118, 249, 38, 68, 136, 142, 178, 226,
        99, 10, 190, 57, 201, 69, 125, 226, 50, 205, 26, 109, 213, 221, 34, 85, 240, 211, 83, 178,
        112, 134, 62, 122, 122, 14, 215, 206, 139, 214, 164, 212, 247, 3, 215, 3, 218, 247, 125,
        13, 253, 116, 24, 78, 139, 246, 202, 178, 247, 247, 53, 70, 86>>

    assert TorCell.Certs.Cert.encode(cert) == <<2>> <> <<byte_size(raw)::16>> <> raw
  end

  test "encodes an Ed25519 cert" do
    cert = %TorCell.Certs.Cert{
      cert: %TorCert.Ed25519{
        cert_key_type: :ed25519,
        cert_type: :ed25519_signing_id,
        certified_key:
          <<21, 195, 194, 141, 132, 50, 207, 113, 139, 70, 72, 23, 89, 84, 174, 235, 255, 176, 47,
            135, 165, 114, 166, 20, 243, 149, 223, 81, 221, 149, 34, 121>>,
        expiration_date: ~U[2023-04-27 20:00:00Z],
        extensions: [
          %TorCert.Ed25519.Extension{
            data:
              <<194, 4, 162, 205, 242, 49, 217, 184, 187, 127, 147, 15, 211, 173, 83, 179, 26,
                111, 116, 63, 71, 28, 173, 15, 33, 128, 137, 199, 170, 24, 162, 214>>,
            flags: nil,
            type: :signed_with_ed25519_key
          }
        ],
        signature:
          <<126, 87, 191, 221, 228, 211, 40, 51, 76, 218, 59, 44, 246, 69, 128, 88, 202, 119, 149,
            210, 218, 90, 202, 93, 101, 175, 206, 140, 203, 91, 184, 175, 31, 33, 72, 63, 91, 196,
            103, 40, 144, 114, 231, 206, 29, 192, 53, 144, 214, 70, 133, 170, 155, 176, 21, 31,
            30, 86, 51, 140, 142, 132, 60, 4>>
      },
      type: :ed25519_id_signing
    }

    raw =
      <<1, 4, 0, 7, 33, 196, 1, 21, 195, 194, 141, 132, 50, 207, 113, 139, 70, 72, 23, 89, 84,
        174, 235, 255, 176, 47, 135, 165, 114, 166, 20, 243, 149, 223, 81, 221, 149, 34, 121, 1,
        0, 32, 4, 0, 194, 4, 162, 205, 242, 49, 217, 184, 187, 127, 147, 15, 211, 173, 83, 179,
        26, 111, 116, 63, 71, 28, 173, 15, 33, 128, 137, 199, 170, 24, 162, 214, 126, 87, 191,
        221, 228, 211, 40, 51, 76, 218, 59, 44, 246, 69, 128, 88, 202, 119, 149, 210, 218, 90,
        202, 93, 101, 175, 206, 140, 203, 91, 184, 175, 31, 33, 72, 63, 91, 196, 103, 40, 144,
        114, 231, 206, 29, 192, 53, 144, 214, 70, 133, 170, 155, 176, 21, 31, 30, 86, 51, 140,
        142, 132, 60, 4>>

    assert TorCell.Certs.Cert.encode(cert) == <<4>> <> <<byte_size(raw)::16>> <> raw
  end

  test "encodes an RsaEd25519 cert" do
    cert = %TorCell.Certs.Cert{
      cert: %TorCert.RsaEd25519{
        ed25519_key:
          <<194, 4, 162, 205, 242, 49, 217, 184, 187, 127, 147, 15, 211, 173, 83, 179, 26, 111,
            116, 63, 71, 28, 173, 15, 33, 128, 137, 199, 170, 24, 162, 214>>,
        expiration_date: ~U[2023-10-04 03:00:00Z],
        signature:
          <<190, 24, 76, 117, 205, 199, 248, 156, 99, 115, 25, 119, 244, 227, 156, 74, 75, 175,
            127, 114, 124, 154, 185, 233, 236, 57, 2, 206, 228, 24, 98, 148, 125, 162, 93, 26,
            117, 54, 84, 244, 74, 146, 232, 37, 245, 34, 245, 105, 33, 86, 82, 167, 235, 38, 217,
            231, 128, 1, 250, 197, 50, 203, 131, 62, 251, 46, 33, 95, 151, 243, 52, 137, 55, 60,
            186, 149, 38, 38, 240, 77, 212, 189, 31, 140, 7, 141, 90, 89, 217, 196, 104, 100, 34,
            18, 105, 223, 96, 146, 100, 158, 105, 166, 201, 205, 171, 162, 65, 239, 147, 163, 206,
            142, 36, 145, 176, 227, 90, 225, 41, 156, 193, 33, 126, 21, 94, 131, 152, 8>>
      },
      type: :rsa_ed25519_cross_cert
    }

    raw =
      <<194, 4, 162, 205, 242, 49, 217, 184, 187, 127, 147, 15, 211, 173, 83, 179, 26, 111, 116,
        63, 71, 28, 173, 15, 33, 128, 137, 199, 170, 24, 162, 214, 0, 7, 48, 179, 128, 190, 24,
        76, 117, 205, 199, 248, 156, 99, 115, 25, 119, 244, 227, 156, 74, 75, 175, 127, 114, 124,
        154, 185, 233, 236, 57, 2, 206, 228, 24, 98, 148, 125, 162, 93, 26, 117, 54, 84, 244, 74,
        146, 232, 37, 245, 34, 245, 105, 33, 86, 82, 167, 235, 38, 217, 231, 128, 1, 250, 197, 50,
        203, 131, 62, 251, 46, 33, 95, 151, 243, 52, 137, 55, 60, 186, 149, 38, 38, 240, 77, 212,
        189, 31, 140, 7, 141, 90, 89, 217, 196, 104, 100, 34, 18, 105, 223, 96, 146, 100, 158,
        105, 166, 201, 205, 171, 162, 65, 239, 147, 163, 206, 142, 36, 145, 176, 227, 90, 225, 41,
        156, 193, 33, 126, 21, 94, 131, 152, 8>>

    assert TorCell.Certs.Cert.encode(cert) == <<7>> <> <<byte_size(raw)::16>> <> raw
  end
end
