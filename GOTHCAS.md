section names in multirootca cannot have '-' or quotes ("",'') in them.

e.g. the following are invalid

    [ 'blah' ]

and

    [ my-ca ]




HMAC
cat csr.json | openssl dgst -sha1 -hmac "0123456789ABCDEF0123456789ABCDEF"
