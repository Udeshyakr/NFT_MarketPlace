//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;


import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./interfaces/IRoyalty.sol";
import "hardhat/console.sol";

contract myEpicNFT is ERC721URIStorage{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address contractAddress; 
    constructor(address marketPlaceAddress) ERC721("Golgappe", "GOL") {
        contractAddress = marketPlaceAddress;
    }

    struct NFTInfo{
        uint256 royalty;
        address creator;
    }

    mapping(uint256 => NFTInfo) public royalities;

    function makeAnEpicNFT(string memory tokenURI, uint256 royalty) public returns (uint)
    {
        require(royalty > 0, "royality should be between 0 to 10");
        require(royalty < 10, "royality should less that 10");
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        royalities[newItemId] = NFTInfo(
            royalty,
            payable(msg.sender)
        );
        
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        setApprovalForAll(contractAddress, true);
        return newItemId;
    }

    function royaltyInfo(uint256 _tokenId) external view returns (uint256 royalty, address creator) {
        NFTInfo memory royalitiesInfo = royalities[_tokenId];
        return (royalitiesInfo.royalty, royalitiesInfo.creator);
    }
    


}
