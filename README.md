---

PKT on Akash
Learn how to deploy a PKT announcement miner on the Akash Network
PKT is a blockchain enabling anyone to become an ISP. Users allocate bandwidth from their local internet connections and build a global, decentralized edge network, by the people, for the people. - https://pkt.cash

---

This guide will show you how to deploy a PKT announcement miner on the Akash Network. There are 2 steps to a successful deployment.
 
1)Creating a PKT wallet 
3)Create your SDL file and deploy it to Akash

---

Step 1: Creating your wallet
There are 3 options to create a PKT wallet. A Command Line wallet and the GUI wallet are the only wallets that support mining. The GUI wallet is only available on MacOS. This guide will assume you are setting up a wallet via Command Line. If using the GUI wallet don't worry all we need is a wallet address to mine too. 
Microsoft Windows
Download the most recent zip archive suffixed with -windows.zip available from pktd releases page

For example: pktd-v1.3.1-windows.zip
Go to the Downloads directory
Unarchive the content of the zip file
Open the command prompt
Type cd Downloads
Follow the instructions below but
In place of ./bin/pktwallet, type ./bin/pktwallet.exe
In place of ./bin/pktctl, type ./bin/pktctl.exe

MacOS and Linux
Download one of the most recent packages available for linux or macos from pktd releases page

For example, for pktd-v1.3.1 release:
For MacOS, after having downloaded pktd-v1.3.1-macos.pkg,
   install pktwallet and other utilities by clicking on the package icon in the Finder.
For Linux, after having downloaded one of the following packages:
pktd-v1.3.1-linux.deb (Debian or Ubuntu),
pktd-v1.3.1-linux.rpm (Fedora or RedHat) or
pktd AUR package (Arch linux or Manjaro),
 install pktwallet and other utilities by clicking     on the appropriate package icon or running an installation command

Creating a wallet
To create a new PKT wallet, use the pktwallet - create command:
`./bin/pktwallet --create`
You will be prompted to follow a few steps, make sure you write your seed words on paper so that you can recover your funds even if your computer is damaged.
Creating a new PKT address
while pktwallet is running in the background (in another terminal window), use the following command:
`./bin/pktctl --wallet getnewaddress`
You should see a series of numbers and letters beginning with pkt1, this is your address which you can use for receiving coins.
NOTE: Every time you use getnewaddress, the address you receive must be remembered by pktwallet forever so only use it when you actually need an address.
Congrats you now have a PKT wallet address and we can move onto step 2.
Step 2: Create your SDL file and deploy it to Akash
Here is an example SDL file you can use for your deployment. 

```
version: "2.0"
services:
  main:
    image: chandrastation/pkt_on_akash
    env:
      - WALLET_ADDR=<your-address-here>
# Pool order can be changed based off mining efficiency https://docs.pkt.cash/en/latest/mining/#choosing-a-mining-pool
      - POOL1=http://pool.pkteer.com
      - POOL2=http://pool.pktpool.io
      - POOL3=http://pool.pkt.world
      - POOL4=http://pool.srizbi.com
    expose:
      - port: 3000
        as: 80
        to:
          - global: true
profiles:
  compute:
    miner:
      resources:
        cpu:
          units: 10
        memory:
          size: 512Mi
        storage:
          size: 512Mi
  placement:
    any:
      attributes:
        host: akash
      signedBy:
        anyOf:
          - "akash1365yvmc4s7awdyj3n2sav7xfx76adc6dnmlx63"
      pricing:
        miner:
          denom: uakt
          amount: 1000
deployment:
  main:
    any:
      profile: miner
      count: 1
```
Announcement miners depend solely on internet connection and CPU processing power. In order to simplify the process multiple Deployment tools have been created. I highly recommend readers of this guide utilize them. Akashlytics Deploy Tool (Maxime Beauchamp)or Akash Deploy Tool (Tom Beynon) Both are great tools! The Akashlytics deploy tool is a bit simpler to use but is currently not available for MacOS and does not have a logging feature whereas the tool developed by Tom Beynon has both aforementioned features. If you prefer to use CLI continue reading!
---
Copy the contents of the pkt miner SDL file and save it to a new file named miner.yml.
akash tx deployment create miner.yml --from <your_wallet_name> --node http://rpc.akash.forbole.com:80 --chain-id akashnet-2 --fees 5000uakt -y
After that command a string of JSON will appear in your terminal/command prompt.
```
{"height":"1696542","txhash":"AF360662F5EF02E22C2FC7CDD1975164FC04651C8B911144FB9B15F06AEFE90C","codespace":"","code":0,"data":"0A130A116372656174652D6465706C6F796D656E74","raw_log":"[{\"events\":[{\"type\":\"akash.v1\",\"attributes\":[{\"key\":\"module\",\"value\":\"deployment\"},{\"key\":\"action\",\"value\":\"deployment-created\"},{\"key\":\"version\",\"value\":\"629fe5d9f40da5a3882b3e9d0ec3ad50d31bc6491f84807987196eed2f87a549\"},{\"key\":\"owner\",\"value\":\"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we\"},{\"key\":\"dseq\",\"value\":\"1696540\"},{\"key\":\"module\",\"value\":\"market\"},{\"key\":\"action\",\"value\":\"order-created\"},{\"key\":\"owner\",\"value\":\"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we\"},{\"key\":\"dseq\",\"value\":\"1696540\"},{\"key\":\"gseq\",\"value\":\"1\"},{\"key\":\"oseq\",\"value\":\"1\"}]},{\"type\":\"message\",\"attributes\":[{\"key\":\"action\",\"value\":\"create-deployment\"},{\"key\":\"sender\",\"value\":\"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we\"},{\"key\":\"sender\",\"value\":\"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we\"}]},{\"type\":\"transfer\",\"attributes\":[{\"key\":\"recipient\",\"value\":\"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8\"},{\"key\":\"sender\",\"value\":\"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we\"},{\"key\":\"amount\",\"value\":\"5000uakt\"},{\"key\":\"recipient\",\"value\":\"akash14pphss726thpwws3yc458hggufynm9x77l4l2u\"},{\"key\":\"sender\",\"value\":\"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we\"},{\"key\":\"amount\",\"value\":\"5000000uakt\"}]}]}]","logs":[{"msg_index":0,"log":"","events":[{"type":"akash.v1","attributes":[{"key":"module","value":"deployment"},{"key":"action","value":"deployment-created"},{"key":"version","value":"629fe5d9f40da5a3882b3e9d0ec3ad50d31bc6491f84807987196eed2f87a549"},{"key":"owner","value":"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we"},{"key":"dseq","value":"1696540"},{"key":"module","value":"market"},{"key":"action","value":"order-created"},{"key":"owner","value":"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we"},{"key":"dseq","value":"1696540"},{"key":"gseq","value":"1"},{"key":"oseq","value":"1"}]},{"type":"message","attributes":[{"key":"action","value":"create-deployment"},{"key":"sender","value":"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we"},{"key":"sender","value":"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we"}]},{"type":"transfer","attributes":[{"key":"recipient","value":"akash17xpfvakm2amg962yls6f84z3kell8c5lazw8j8"},{"key":"sender","value":"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we"},{"key":"amount","value":"5000uakt"},{"key":"recipient","value":"akash14pphss726thpwws3yc458hggufynm9x77l4l2u"},{"key":"sender","value":"akash10a670qvazh3qa6xdvclc4jtrdjrnwm392x66we"},{"key":"amount","value":"5000000uakt"}]}]}],"info":"","gas_wanted":"200000","gas_used":"94750","tx":null,"timestamp":""}
```
Take not of your DSEQ it will be used in the following commands.
{"key":"dseq","value":"1696540"}

Next, run
`akash query deployment get --owner <your_akash_wallet_address> --node=tcp://135.181.60.250:26657 --dseq <your_dseq>`
Create a market order.
`akash query market order get --node=http://rpc.akash.forbole.com:80 --owner <your_akash_wallet> --dseq <your_dseq> --oseq 1 --gseq 1`
Acquire a list of bids.
`akash query market bid list --owner=<your_wallet_address> --node=http://rpc.akash.forbole.com:80 --dseq <your_dseq>`
Select a bid from a provider.
`akash tx market lease create --chain-id akashnet-2 --node=tcp://135.181.60.250:26657 --owner <your_wallet_address> --dseq <your_dseq> --gseq 1 --oseq 1 --provider <select_a_provider_from_the_list> --from <your_wallet_name> --fees 5000uakt`
Confirm your lease is open.
`akash query market lease list --owner <your_wallet_address> --node=tcp://135.181.60.250:26657 --dseq <your_dseq>`
Send the manifest.
`akash provider send-manifest miner.yml --node=tcp://135.181.60.250:26657 --dseq <your_dseq> --provider <the_provider_you_selected> --home ~/.akash --from <your_wallet_address>`
Ensure the miner is running.
`akash provider lease-logs --node=tcp://135.181.60.250:26657  --dseq <your_dseq> --gseq 1 --oseq 1 --provider <the_provider_you_selected> --from <your_wallet_address>`
Another great way too see how much PKT you are mining is by visiting the block explorer and inputting your PKT wallet address. 
---
That's it! You should now be mining yourself some PKT. If you have any questions or need assistance with your deployment I recommend you join the Chandra Station Discord chat and ping me @Chalabi in the Akash support text channel!
