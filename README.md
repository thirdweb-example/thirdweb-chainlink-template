# thirdweb Chainlink Template

This template provides four contracts with implementations of the 4 Chainlink features: [Any API - Request & Recieve Data](#request-and-recieve-data), [Automation](#automation), [VRF - Getting Random Numbers](#get-a-random-number) & [Price Feeds](#price-feeds) using either Foundry OR Hardhat depending on your preferences. It shows developers how to build and test contracts and deploy using thirdweb.
This template is set up to deploy to Goerli. It has been adapted from the Chainlink starter kits, produced by Patrick Collins, and reworked by Ciara Nightingale to combine Foundry & Hardhat and use thirdweb for deployment!

-   [thirdweb Chainlink Template](#thirdweb-chainlink-template)
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

-   Install either Foundry or Hardhat, depending on your preferences.

-   Run

```sh
npx thirdweb create --template thirdweb-chainlink-template
cd thirdweb-chainlink-template
```

To install the projects dependencies, run

```sh
foundryup && forge clean && forge install
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

Choose a framework & contract(s) to deploy. The Dashboard will pop up in a browser window to fill out the required contract parameters and deploy the contract(s). View your contract address, the read and write functions, the public variables, events, source code, and more directly from the thirdweb Dashboard. Here, you will be able to interact with your contract.

# Interacting with Contracts

## Using the Dashboard

To interact with contracts, we will use the thirdweb [Dashboard](https://thirdweb.com/dashboard). Here, you will be able to see all of your deployed contracts and be able to see all of the external & public functions on the contracts. We will also be able to call the functions from the UI.

## [Request and Recieve Data](/contracts/APIConsumer.sol)

This specific Any API example uses a weather API to request the current temperature for a given longitude & latitude. To make a request, [set up an account](https://openweathermap.org/api) to get an API key from the API provider's website.

To request and receive data using Any API, deploy the `APIConsumer` contract using thirdweb Deploy. When the Dashboard prompts you to input the contract parameters, input the following values for Goerli - for more information, read [this Chainlink Doc](https://docs.chain.link/any-api/testnet-oracles/):

-   \_oracle: 0xCC79157eb46F5624204f47AB42b3906cAA40eaB7
-   \_fee: 100000000000000000
-   \_link: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB

After deploying, the contract will need to be funded with some LINK token. In this case, Goerli LINK, can be obtained from [this faucet](https://faucets.chain.link/). In MetaMask, you will need to add the token into the Assets tab, click "Send", paste in the contract address, and send some LINK. Approximately 1 LINK will be enough as each API request will cost 0.1 LINK.

The following function calls can be done from the thirdweb Dashboard, which will pop up after deployment.

After doing so, use the API key to call the `createRequest` function, filling in the API key and the requested longitude & latitude for the required location temperature request.

Next, call `requestData` to request the oracle network to perform the API call.

After waiting a few seconds, call the `temperature` read function to view the current temperature in the requested location!

## [Automation](/contracts/AutomationCounter.sol)

This example uses Automation to increment a counter after a given interval automatically.

Deploy the `AutomationCounter` contract using thirdweb with the instructions above and provide the following contract parameter:

-   updateInterval: 10

The interval is how many **seconds** between automatic incrementations of the counter. Here we are specifying 10 seconds but feel free to choose a different interval.

From the contract dashboard, copy the contract address to register it for Upkeep.

To allow the contract to be monitored for automation, it needs to registered as a new upkeep. Follow [this link](https://automation.chain.link/) and click `Register new Upkeep`.

Select `Custom Logic` for the trigger & paste the contract address. Fill in the required fields to register the contract and click `Register Upkeep`.

Fund the Upkeep with some testnet LINK, and from the thirdweb Dashboard, click `counter` from the list of read functions and click `Run`. The counter should increment every time the time interval elapses!

## [Price Feeds](/contracts/PriceConsumerV3.sol)

To request a specific price feed, find the specific network the contract is being deployed to from [this list](https://docs.chain.link/data-feeds/price-feeds/addresses/) and find the price feed for th contract to read and copy the address. On Goerli, the ETH/USD price feed address is:

0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e

Follow the deployment steps above to deploy the `PriceFeedConsumerV3` contract and paste the above address as the contract parameter.

On the contract dashboard, run the `getLatestPrice` function to read the current price of the requested price feed.

## [Get a Random Number](/contracts/RandomNumberConsumerV2.sol)

When deploying the `RandomNumberConsumerV2` contract, three constructor parameters are required:

-   `keyHash`
-   `VRFCoodinator` address [can be found here](https://docs.chain.link/docs/vrf-contracts/#configurations)
-   `subscriptionID`: a subscription will need to be created on the Subscription Manager to obtain this value, and the Subscription will need to be funded with some test LINK

After deploying the contract, add the contract address as a consumer on the Subscription ID in order to request random numbers.

To request Random Numbers, click the write function `requestRandomWords` and click `Execute`. As long as the subscription is sufficiently funded, the request will be fulfilled, the status of the request can be viewed on the Subscription ID.

To view the returned random values, select `s_randomWords` under the read functions, input either 0 or 1 for the `key` parameter (as we have requested two random words), and click `Run`.

# Thank You!

A massive thank you to Patrick Collins & the Chainlink team for providing so many educational resources in the docs, YouTube channel & more to enable developers like me to create these projects!

## Discord

If you have any questions on how to integrate Chainlink into your projects, jump into the thirdweb Discord, and we will be happy to answer your questions:)

## Resources

-   [thirdweb YouTube](https://www.youtube.com/@thirdweb_)
-   [thirdweb Docs](https://portal.thirdweb.com/)
-   [Chainlink Docs](https://docs.chain.link/)
-   [Chainlink YouTube](chainlink)
-   [Foundry Chainlink Starter Kit](https://github.com/smartcontractkit/foundry-starter-kit)
-   [HardHat Chainlink Starter Kit](https://github.com/smartcontractkit/hardhat-starter-kit)
