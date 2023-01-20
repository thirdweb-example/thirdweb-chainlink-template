# thirdweb Chainlink Starter Kit

This template provides implementations of the 4 Chainlink features using either Foundry OR Hardhat depending on your preferences. It show developers how to build and test contracts and deploy using thirdweb.
This template currently is currently set up to deploy to Goerli. It has been adapted from the Chainlink starter kits, produced by Patrick Collins and reworked by Ciara Nightingale to combine Foundry & Hardhat and use thirdweb for deployment!

-   [thirdweb Chainlink Starter Kit](#thirdweb-chainlink-starter-kit)
-   [Getting Started](#getting-started)
-   [Testing](#testing)
    -   [Testing with Foundry](#testing-with-foundry)
    -   [Testing with Hardhat](#testing-with-hardhat)
-   [Deploying](#deploying)
    -   [Deploying with thirdweb](#deploying-with-thirdweb)
-   [Interacting with Contracts](#interacting-with-contracts)
    -   [Using the Dashboard](#using-the-dashboard)
    -   [Request and Recieve Data](#request-and-recieve-data)
    -   [Automation](#automation)
    -   [Price Feeds](#price-feeds)
    -   [Get a Random Number](#get-a-random-number)
-   [Thank You!](#thank-you)
    -   [Discord](#discord)
    -   [Resources](#resources)

# Getting Started

-   Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

-   Install either Foundry or Hardhat depending on yourb preferences.

-   Clone this repo

```sh
git clone https://github.com/smartcontractkit/foundry-starter-kit
cd foundry-starter-kit
```

To install the projects dependences, run

```sh
forge install
```

or

```sh
npm install
```

# Testing

## Testing with Foundry

To run the tests with Foundry, run:

```sh
forge test
```

## Testing with Hardhat

To run the tests with Hardhat, run

```sh
npx hardhat test
```

# Deploying

## Deploying with thirdweb

To deploy your contracts, run

```sh
npx thirdweb deploy
```

You will be prompted to choose a framework & then which of the contracts you would like to deploy. This will initiate your Dashboard to pop up in a browser window for you to fill out the required contract parameters. You will then be able to view your contract address, the read and write functions, the public variables, events, source code and more directly from the thirdweb Dashboard. Here, you will be able to interact with your contract.

# Interacting with Contracts

## Using the Dashboard

To interact with contracts, we will use the thirdweb [Dashboard](https://thirdweb.com/dashboard). Here, you will be able to see all of your deployed contracts and be able to see all of the external & public functions on the contracts. We will also be able to call the functions from the UI.

## Request and Recieve Data

This specific Any API example uses a weather API to request the current temperature for a given logitude & latitude. To make a request, you will need to [set up an account](https://openweathermap.org/api) on the API provider website so that you can get your own API key.

To request and recieve data using Any API, deploy the `APIConsumer` contract using thirdweb Deploy. When the Dashboard prompts you to input the contract parameters, input the following values for Goerli - for more information, read [this Chainlink Doc](https://docs.chain.link/any-api/testnet-oracles/):

-   \_oracle: 0xCC79157eb46F5624204f47AB42b3906cAA40eaB7
-   \_fee: 100000000000000000
-   \_link: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB

After deploying, you will need to fund your contract with some LINK token. In this case, Goerli LINK which you can obtain from [this faucet](https://faucets.chain.link/). In metamask, you will need to add the token into the Assets tab and then click "Send", paste in your contract address and send some LINK. Approximately 1 LINK will be enough as each API request will cost 0.1 LINK.

The following function calls can be done from your thirdweb Dashboard which will pop up after you have deployed.

After doing so, use your API key to call the `createRequest` function, filling in the API key and your requested longitude & latitude for the location you'd like to know the current temperature of.

Next, call `requestData` to make a request to the oracle network to perform the API call.

After waiting a few seconds, call the `temperature` read function to view the current temperature in your requested location!

## Automation

This example uses Automation to automatically increment a counter after a given interval.

Deploy the `AutomationCounter` contract using thirdweb with the instructions above and provide the following contract parameter:

-   updateInterval: 10

The interval is how many **seconds** between automatic incrementations of the counter. Here we are specifying 10 seconds but feel free to choose a different interval.

From the contract dashboard, copy the contract address to register it for Upkeep.

To allow your contract to be monitored for automation, it needs to registered as a new upkeep. Follow [this link](https://automation.chain.link/) and click `Register new Upkeep`

Select `Custom Logic` for the trigger & paste in your contract address. Fill in the required feeds to register your contract and click `Register Upkeep`

Fund your Upkeep with some testnet LINK and from the thirdweb Dashboard

From the contract dashboard, click counter from the list of read functions and click `Run`. The counter should increment every time your time-interval elapses!

## Price Feeds

To request a specific price feed, find the specific network you are deploying to from [this list](https://docs.chain.link/data-feeds/price-feeds/addresses/) and then find the price feed you would like to read and copy the address. On Goerli, the ETH/USD price feed address is:

0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e

Follow the deployment steps above to deploy the `PriceFeedConsumerV3` contract and paste the above address as the contract parameter.

On the contract dashboard, run the `getLatestPrice` function to read the current price of your requested price feed.

## Get a Random Number

When deploying your `RandomNumberConsumerV2` contract, you will be required to input three contract parameters:

-   keyHash
-   VRFCoodinator address
-   subscriptionID: for this you will need to create a subscription on the Subscription Manager and fund your Subscription with some test LINK

After deploying your contract, you will need to add your contract address as a consumer on your Subscription ID in order to request random numbers.

To request Random Numbers, click the write function `requestRandomWords` and click **Execute**. As long as your subscription is sufficiently funded, your request should be fulfilled, you will be able to view the status of your request on your Subscription ID.

To view the returned random values, select s*randomWords under the read functions, input either 0 or 1 for the \_key* parameter (as we have requested 2 random words) and click **run**.

# Thank You!

A massive thank you to Patrick Collins & the Chainlink team for providing so many educational resources in the docs, YouTube channel & more to enable developers like me to create these projects!

## Discord

If you have any questions on how to integrate Chainlink into your own projects, jump into the thirdweb Discord and we will be happy to answer your questions:)

## Resources

-   [thirdweb YouTube](https://www.youtube.com/@thirdweb_)
-   [thirdweb Docs](https://portal.thirdweb.com/)
-   [Chainlink Docs](https://docs.chain.link/)
-   [Chainlink YouTube](chainlink)
-   [Foundry Chainlink Starter Kit](https://github.com/smartcontractkit/foundry-starter-kit)
-   [HardHat Chainlink Starter Kit](https://github.com/smartcontractkit/hardhat-starter-kit)
