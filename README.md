# thirdweb Chainlink Starter Kit

This template provides implementations of the 4 Chainlink features using either Foundry OR Hardhat depending on your preferences. It show developers how to build and test contracts and deploy using thirdweb.
This template currently is currently set up to deploy to Goerli. It has been adapted from the Chainlink starter kits, produced by Patrick Collins and reworked by Ciara Nightingale to combine Foundry & Hardhat and use thirdweb for deployment!

- [thirdweb Chainlink Starter Kit](#thirdweb-chainlink-starter-kit)
- [Getting Started](#getting-started)
- [Testing](#testing)
  - [Testing with Foundry](#testing-with-foundry)
  - [Testing with Hardhat](#testing-with-hardhat)
- [Deploying](#deploying)
  - [Deploying with thirdweb](#deploying-with-thirdweb)
- [Interacting with Contracts](#interacting-with-contracts)
  - [Using the Dashboard](#using-the-dashboard)
  - [Request and Recieve Data](#request-and-recieve-data)
  - [Automation](#automation)
  - [Price Feeds](#price-feeds)
  - [Get a Random Number](#get-a-random-number)
- [Thank You!](#thank-you)
  - [Discord](#discord)
  - [Resources](#resources)

# Getting Started 

- Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

- Install either Foundry or Hardhat depending on yourb preferences. 

- Clone this repo

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
npx thirdweb@latest deploy
```

You will be prompted to choose a framework & then which of the contracts you would like to deploy. This will initiate your Dashboard to pop up in a browser window for you to fill out the required contract parameters. You will then be able to view your contract address, the read and write functions, the public variables, events, source code and more directly from the thirdweb Dashboard. Here, you will be able to interact with your contract.

# Interacting with Contracts

## Using the Dashboard

To interact with contracts, we will use the thirdweb Dashboard. 

## Request and Recieve Data

To request and recieve data using Any API, deploy the `APICOnsumer` contract using thirdweb Deploy. When the Dashboard prompts you to input the contract parameters, input the following values for Goerli:

- _oracle: 0xCC79157eb46F5624204f47AB42b3906cAA40eaB7
- _jobid: ca98366cc7314957b8c012c72f05aeeb
- _fee:
- _link: 

## Automation

## Price Feeds

## Get a Random Number

When deploying your `RandomNumberConsumerV2` contract, you will be required to input three contract parameters:

- keyHash 
- VRFCoodinator address
- subscriptionID: for this you will need to create a subscription on the Subscription Manager and fund your Subscription with some test LINK

After deploying your contract, you will need to add your contract address as a consumer on your Subscription ID in order to request random numbers. 

To request Random Numbers, click the write function `requestRandomWords` and click **Execute**. As long as your subscription is sufficiently funded, your request should be fulfilled, you will be able to view the status of your request on your Subscription ID.

To view the returned random values, select s_randomWords under the read functions, input either 0 or 1 for the *key* parameter (as we have requested 2 random words) and click **run**.

# Thank You!

## Discord

## Resources