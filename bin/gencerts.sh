#!/bin/bash
TRUST_ANCHOR='rootCA'
CERTS=('server')
CSR_CONFIG='server.cnf'
CERT_DIR='./certs'

mkdir -p "$CERT_DIR"

cat > ${CERT_DIR}/rootCA.cnf <<EOF
[ req ]
default_bits       = 2048
prompt             = no
default_md         = sha256
distinguished_name = req_distinguished_name
x509_extensions    = v3_ca

[ req_distinguished_name ]
C  = US
ST = North Carolina
L  = Raleigh
O  = Red Hat Inc.
CN = Root CA

[ v3_ca ]
basicConstraints = CA:TRUE
keyUsage = digitalSignature, keyCertSign
EOF

cat > ${CERT_DIR}/${CSR_CONFIG} <<EOF
[ req ]
default_bits       = 2048
prompt             = no
default_md         = sha256
distinguished_name = req_distinguished_name
req_extensions     = req_ext

[ req_distinguished_name ]
C  = US
ST = North Carolina
L  = Raleigh
O  = Red Hat Inc.
CN = 192.168.56.0  # Replace with your IP address

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
IP.1 = 192.168.56.0  # Replace with your IP address
EOF


# Root Cert - Trust Anchor
openssl genpkey -algorithm RSA -out "${CERT_DIR}/${TRUST_ANCHOR}-key.pem" -pkeyopt rsa_keygen_bits:2048
openssl req -x509 -new -nodes -key "${CERT_DIR}/${TRUST_ANCHOR}-key.pem" -sha256 -days 3650 -out "${CERT_DIR}/${TRUST_ANCHOR}-cert.pem" -config ${CERT_DIR}/rootCA.cnf

for certname in "${CERTS[@]}"; do
    rm -f "${CERT_DIR}/${certname}-key.pem" "${CERT_DIR}/${certname}-cert.pem"

    # Create the private key    
    openssl genpkey -algorithm RSA -out "${CERT_DIR}/${certname}-key.pem" -pkeyopt rsa_keygen_bits:2048

    # Create the CSR
    openssl req -new -key "${CERT_DIR}/${certname}-key.pem" -out "${CERT_DIR}/${certname}.csr" -config ${CERT_DIR}/${CSR_CONFIG}

    # # Sign the CSR with the CA
    openssl x509 -req -in "${CERT_DIR}/${certname}.csr" -CA "${CERT_DIR}/${TRUST_ANCHOR}-cert.pem" -CAkey "${CERT_DIR}/${TRUST_ANCHOR}-key.pem" -CAcreateserial \
    -out "${CERT_DIR}/${certname}-cert.pem" -days 365 -extfile ${CERT_DIR}/${CSR_CONFIG} -extensions req_ext

    # Remove the CSR file
    rm "${CERT_DIR}/${certname}.csr"
done

