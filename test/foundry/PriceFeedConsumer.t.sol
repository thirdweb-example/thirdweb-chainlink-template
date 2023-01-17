// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../contracts/PriceConsumerV3.sol";
import "./mocks/MockV3Aggregator.sol";
import "forge-std/Test.sol";

contract PriceConsumerTest is Test {
    uint8 public constant DECIMALS = 18;
    int256 public constant INITIAL_ANSWER = 1 * 10**18;
    PriceConsumerV3 public priceConsumer;
    MockV3Aggregator public mockV3Aggregator;

    function setUp() public {
        mockV3Aggregator = new MockV3Aggregator(DECIMALS, INITIAL_ANSWER);
        priceConsumer = new PriceConsumerV3(address(mockV3Aggregator));
    }

    function testConsumerReturnsStartingValue() public {
        int256 price = priceConsumer.getLatestPrice();
        assertTrue(price == INITIAL_ANSWER);
    }
}
