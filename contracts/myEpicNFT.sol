//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;


import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract myEpicNFT is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address contractAddress; 
    constructor(address marketPlaceAddress) ERC721("Golgappe", "GOL") {
        contractAddress = marketPlaceAddress;
    }

    function makeAnEpicNFT(string memory tokenURI) public returns (uint)
    {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        setApprovalForAll(contractAddress, true);
        return newItemId;
    }
    


}
