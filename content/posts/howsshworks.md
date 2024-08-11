---
title: How SSH works
date: 2023-02-25T19:36:25+03:00
tags:
  - "ssh"
  - "linux"
---
If you work in the IT industry, you’ve undoubtedly heard of ssh. But how does it work?\
SSH (secure shell) is a network protocol that allows two computers to connect securely over the internet. SSH uses encryption to prevent hackers from reading data sent between two connected devices.\
SSH is divided into three layers:
1. The transport layer
2. The connection layer
3. The authentication layer

During and after authentication, the transport layer establishes safe and secure communication between a client and a server. It is in charge of data encryption, decryption, and integrity assurance. It also provides data compression and caching, which helps to speed up data communication.

The authentication layer informs the client about the available authentication methods. It’s also in charge of the whole user authentication procedure.

After the authentication is successful, the connection layer oversees the communication between the machines. It manages communication channel opening and closure, as well as multiple channels for multiple sessions.
# Session Encryption
The server sends the client a list of supported encryption protocols after receiving a connection request. The public key is used by the server as an authentication technique.

The client compares the protocols to the ones it already knows. If there are two protocols that are compatible, the machines agree to use one of them to establish the connection.

On the first connection attempt, the client compares the server’s public key to the private key saved in its system. If the keys are identical, the client and server agree to communicate using symmetric encryption during the SSH session. They communicate utilizing an asymmetrically encrypted mechanism based on the Diffie-Hellman (DH) key exchange algorithm for this purpose.
There are different ciphers that can be used for SSH depending on the applications being used. Some of them include:
- CHACHA20
- AES-GCM
- Blowfish-CBC
- AES128-CTR
- AES192-CTR
- AES256-CTR
- Arcfour
- Cast128-CBC
# Different Encryption Techniques
SSH uses a variety of data manipulation techniques at various points in the transaction to ensure the security of information transmission. These include symmetrical and asymmetrical encryption, as well as hashing.
# Symmetrical Encryption
Symmetric encryption creates a single key that is exchanged between two machines. The key is then used by the machines for both encryption and decryption. This approach is rapid and resource-light, and it is used by SSH for each session. When the client and server are deciding which algorithm to employ for an SSH session, the first algorithm on the client’s list that the server supports is always used.
# Asymmetrical Encryption
Any party can have access to the public key. Although it is linked to its paired key, the private key cannot be deduced from the public key. The public key and private key have a mathematical relationship that allows the public key to encrypt messages that can only be decrypted by the private key. This is a one-way ability, which means that the public key cannot decode the communications it sends or decrypt anything the private key sends it.

The private key should be kept completely confidential and never shared with anybody else. This is a necessary condition for the public key paradigm to function.The only component that can decrypt communications encrypted with the accompanying public key is the private key. Any entity capable of decrypting these messages has demonstrated control over the private key as a result of this fact.
# Hashing

r key defining characteristics are that they are never supposed to be reversed, that they are nearly hard to predictably alter, and that they are practically unique.

If you use the same hashing function and message, you should get the same hash; if you change any part of the data, you should get a completely different hash. A user should not be able to deduce the actual message from a hash, but they should be able to determine whether a message produced a hash.
# Session Encryption Negotiation
The server sends the client a list of supported encryption protocols after receiving a connection request. The public key is used by the server as an authentication technique.

The client evaluates the protocols in comparison to its own. The machines choose one to create the connection using if there are any compatible protocols.

On the initial connection attempt, the client checks the server's public key to the saved copy of its own private key. The client and server consent to using symmetric encryption to communicate during an SSH session if the keys match. They converse utilizing an asymmetric encryption method that makes use of the Diffie-Hellman (DH) key exchange algorithm.

Using a public network, machines can safely collaborate to build a cryptographic key thanks to the DH algorithm. The machines go through the following processes to create a key:
- The machines agree on two numbers: a modulus and a base number. To prevent brute force key decryption, the chosen modulus is a prime number of at least 600 digits.
- In order to solve the equation involving the two public numbers, the machines independently select one number.
- The calculated values are exchanged between the server and the client.
- Now, utilizing the information obtained from the other machine, each machine computes something.

By carrying out the above processes, both machines determine the identical value, which is their secret key. The server then makes an attempt to verify the user's identity who made the access request.

***If you enjoyed this article consider [supporting me](../../donate)

