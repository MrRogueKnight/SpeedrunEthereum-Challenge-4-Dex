// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DEX {
    IERC20 token;

    uint256 public totalLiquidity;
    mapping(address => uint256) public liquidity;

    event EthToTokenSwap(address swapper, uint256 tokenOutput, uint256 ethInput);
    event TokenToEthSwap(address swapper, uint256 tokensInput, uint256 ethOutput);
    event LiquidityProvided(address liquidityProvider, uint256 liquidityMinted, uint256 ethInput, uint256 tokensInput);
    event LiquidityRemoved(address liquidityRemover, uint256 liquidityWithdrawn, uint256 tokensOutput, uint256 ethOutput);

    constructor(address tokenAddr) {
        token = IERC20(tokenAddr);
    }

    function init(uint256 tokens) public payable returns (uint256) {
        require(totalLiquidity == 0, "DEX: Already initialized");
        require(msg.value > 0 && tokens > 0, "DEX: Must provide ETH and tokens");

        totalLiquidity = address(this).balance;
        liquidity[msg.sender] = totalLiquidity;

        require(token.transferFrom(msg.sender, address(this), tokens), "DEX: Token transfer failed");

        return totalLiquidity;
    }

    function price(uint256 xInput, uint256 xReserves, uint256 yReserves) public pure returns (uint256 yOutput) {
        require(xReserves > 0 && yReserves > 0, "DEX: Invalid reserves");

        uint256 xInputWithFee = xInput * 997;
        uint256 numerator = xInputWithFee * yReserves;
        uint256 denominator = (xReserves * 1000) + xInputWithFee;

        yOutput = numerator / denominator;
    }

    function getLiquidity(address lp) public view returns (uint256) {
        return liquidity[lp];
    }

    function ethToToken() public payable returns (uint256 tokenOutput) {
        require(msg.value > 0, "DEX: Must send ETH");

        uint256 tokenReserve = token.balanceOf(address(this));
        uint256 ethReserve = address(this).balance - msg.value;

        tokenOutput = price(msg.value, ethReserve, tokenReserve);

        require(token.transfer(msg.sender, tokenOutput), "DEX: Token transfer failed");

        emit EthToTokenSwap(msg.sender, tokenOutput, msg.value);
    }

    function tokenToEth(uint256 tokenInput) public returns (uint256 ethOutput) {
        require(tokenInput > 0, "DEX: Must send tokens");

        uint256 tokenReserve = token.balanceOf(address(this));
        uint256 ethReserve = address(this).balance;

        ethOutput = price(tokenInput, tokenReserve, ethReserve);

        require(token.transferFrom(msg.sender, address(this), tokenInput), "DEX: Token transfer failed");

        (bool success, ) = msg.sender.call{value: ethOutput}("");
        require(success, "DEX: ETH transfer failed");

        emit TokenToEthSwap(msg.sender, tokenInput, ethOutput);
    }

    function deposit() public payable returns (uint256 tokensDeposited) {
        require(msg.value > 0, "DEX: Must send ETH");

        uint256 ethReserve = address(this).balance - msg.value;
        uint256 tokenReserve = token.balanceOf(address(this));
        uint256 tokenAmount = (msg.value * tokenReserve) / ethReserve;

        uint256 liquidityMinted = (msg.value * totalLiquidity) / ethReserve;

        liquidity[msg.sender] += liquidityMinted;
        totalLiquidity += liquidityMinted;

        require(token.transferFrom(msg.sender, address(this), tokenAmount), "DEX: Token transfer failed");

        emit LiquidityProvided(msg.sender, liquidityMinted, msg.value, tokenAmount);

        return tokenAmount;
    }

    function withdraw(uint256 amount) public returns (uint256 ethAmount, uint256 tokenAmount) {
        require(amount > 0, "DEX: Must withdraw non-zero amount");
        require(liquidity[msg.sender] >= amount, "DEX: Insufficient liquidity");

        uint256 ethReserve = address(this).balance;
        uint256 tokenReserve = token.balanceOf(address(this));

        ethAmount = (amount * ethReserve) / totalLiquidity;
        tokenAmount = (amount * tokenReserve) / totalLiquidity;

        liquidity[msg.sender] -= amount;
        totalLiquidity -= amount;

        (bool sent, ) = msg.sender.call{value: ethAmount}("");
        require(sent, "DEX: ETH withdrawal failed");

        require(token.transfer(msg.sender, tokenAmount), "DEX: Token withdrawal failed");

        emit LiquidityRemoved(msg.sender, amount, tokenAmount, ethAmount);
    }
}
