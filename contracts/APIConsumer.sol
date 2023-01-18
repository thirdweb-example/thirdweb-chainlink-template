// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

/**
 * @title The APIConsumer contract
 * @notice An API Consumer contract that makes GET requests to obtain 24h trading volume of ETH in USD
 */
contract APIConsumer is ChainlinkClient {
    using Chainlink for Chainlink.Request;

    uint256 public temperature;
    address private immutable oracle;
    bytes32 private immutable jobId;
    uint256 private immutable fee;
    string private requestUrl;
    address private immutable owner;

    event DataFullfilled(uint256 temperature);

    /**
     * @notice Executes once when a contract is created to initialize state variables
     *
     * @param _oracle - address of the specific Chainlink node that a contract makes an API call from
     * @param _fee - node operator price per API call / data request
     * @param _link - LINK token address on the corresponding network
     *
     * Network: Goerli
     * Oracle: 0xCC79157eb46F5624204f47AB42b3906cAA40eaB7
     * Job ID: 7d80a6386ef543a3abb52817f6707e3b
     * Fee: 0.1 LINK
     * Link: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB
     */
    constructor(
        address _oracle,
        uint256 _fee,
        address _link
    ) {
        if (_link == address(0)) {
            setPublicChainlinkToken();
        } else {
            setChainlinkToken(_link);
        }
        oracle = _oracle;
        jobId = "ca98366cc7314957b8c012c72f05aeeb";
        fee = _fee;
        owner = msg.sender;
    }

    /**
     * @notice Creates a url for the Chainlink request
     *
     * @param apiKey - your API key: sign up here https://openweathermap.org/api/one-call-3
     * @param lat - latitude you'd like to retrieve current weather for
     * @param long - longitude
     *
     */
    function createRequest(
        string calldata apiKey,
        string calldata lat,
        string calldata long
    ) public {
        requestUrl = string.concat(
            "http://api.openweathermap.org/data/3.0/onecall/timemachine?",
            "lat=",
            lat,
            "&lon=",
            long,
            "&dt=",
            Strings.toString(block.timestamp),
            "&exclude=minutely,hourly,daily,alerts",
            "&appid=",
            apiKey
        );
    }

    /**
     * @notice Creates a Chainlink request to retrieve API response
     *
     * @return requestId - id of the request
     */
    function requestData() public returns (bytes32 requestId) {
        Chainlink.Request memory request = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfill.selector
        );

        // Make sure that the url has been created
        require(
            keccak256(abi.encode(requestUrl)) != bytes32(0),
            "please create a request by calling createRequest"
        );
        // Set the URL to perform the GET request on
        request.add("get", requestUrl);

        // Set the path to find the desired data in the API response, where the response format is:
        // {"data":
        //   {
        //    "temp": xxx.xx:
        //    }
        //  }
        // request.add("path", "data,temp"); // Chainlink nodes prior to 1.0.0 support this format
        request.add("path", "data,0,temp"); // Chainlink nodes 1.0.0 and later support this format

        int256 timesAmount = 10**2;
        request.addInt("times", timesAmount);

        // Sends the request
        return sendChainlinkRequestTo(oracle, request, fee);
    }

    /**
     * @notice Receives the response in the form of uint256
     *
     * @param _requestId - id of the request
     * @param _temperature - response; requested temperature for a given longitude & latitude
     */
    function fulfill(bytes32 _requestId, uint256 _temperature)
        public
        recordChainlinkFulfillment(_requestId)
    {
        temperature = (_temperature - 27315) / 100;
        emit DataFullfilled(temperature);
    }

    /**
     * @notice Witdraws LINK from the contract
     * @dev Implement a withdraw function to avoid locking your LINK in the contract
     */
    function withdrawLink() external {
        LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
        require(
            link.transfer(msg.sender, link.balanceOf(address(this))),
            "Unable to transfer"
        );
    }
}
