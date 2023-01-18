// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "../../contracts/APIConsumer.sol";
import "./mocks/LinkToken.sol";
import "forge-std/Test.sol";
import "./mocks/MockOracle.sol";

contract APIConsumerTest is Test {
    APIConsumer public apiConsumer;
    LinkToken public linkToken;
    MockOracle public mockOracle;

    uint256 fee;
    bytes32 blank_bytes32;

    uint256 constant AMOUNT = 1 * 10**18;
    uint256 constant RESPONSE = 777;

    function setUp() public {
        linkToken = new LinkToken();
        mockOracle = new MockOracle(address(linkToken));
        apiConsumer = new APIConsumer(
            address(mockOracle),
            fee,
            address(linkToken)
        );
        linkToken.transfer(address(apiConsumer), AMOUNT);
    }

    function testCanMakeRequest() public {
        bytes32 requestId = apiConsumer.requestData();
        assertTrue(requestId != blank_bytes32);
    }

    function testCanGetResponse() public {
        bytes32 requestId = apiConsumer.requestData();
        mockOracle.fulfillOracleRequest(requestId, bytes32(RESPONSE));
        assertTrue(apiConsumer.temperature() == RESPONSE);
    }
}
