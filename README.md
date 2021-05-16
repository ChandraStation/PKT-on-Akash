# pkt_ann_miner_on_akash
Deploy a PKT Cash announcment miner on the Akash Network 

## Dockerfile
The docker file provided in the repository can be used to build your own image then deploy it to the Akash Network. Just be sure to add your own PKT wallet in the last CMD
```
CMD [ "./target/release/packetcrypt", "ann", "http://pool.pkteer.com", "--paymentaddr", "<your-pkt-wallet>" ] 
```
You can also choose a different pool. Different pools may give you better mining performance. The URL's for the pools were acquired from the [PKT Website](https://docs.pkt.cash/en/latest/mining/)
```
    Pkteer: http://pool.pkteer.com
    PKTPool: http://pool.pktpool.io
    PktWorld: http://pool.pkt.world
    Pktminers: http://dalpool.pktminers.cash
    Srizbi: http://pool.srizbi.com
```
Do not use the image that was pushed to the Chandra Station Docker Hub account as it was built with my wallet address.

## PKT Wallet

Instructions on setting up your own PKT wallet can be found on the [PKT Website](https://docs.pkt.cash/en/latest/pktd/pktwallet/). I used the CLI wallet.

## Deploying to Akash

A detailed guide on deploying to Akash can be found here on the [Akash Docs](https://docs.akash.network/guides/deploy)

## Future Improvments 
Logging in order to see if your miner is efficient and if you are rejecting block rewards.
