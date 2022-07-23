//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./interfaces/IRoyalty.sol";

contract NFTMarket is ReentrancyGuard, ERC721Holder{
    using Counters for Counters.Counter;
    Counters.Counter private _itemsIds;
    Counters.Counter private _nftSold;
    IERC20 public tokenAddress; 
    uint256 public platformFee = 25;
    uint256 public denominator = 1000;

    address payable owner; 
    
    constructor(address _tokenAddress) {
        owner = payable(msg.sender);
        tokenAddress = IERC20(_tokenAddress);
    }

    struct NFTMarketItem{
        uint256 tokenId;
        uint256 price;
        address nftContract;
        address payable seller;
        address payable owner;
        bool sold;
    }

    mapping(uint256 => NFTMarketItem) public marketItems;

    event MarketItemCreated(
        uint256 indexed tokenId,
        address indexed nftContract,
        uint256 price,
        uint256 royalty,
        address creator,
        address owner,
        address seller, 
        bool sold  
    );


    function listNFTs(address nftContract, uint256 tokenId, uint256 price, uint256 royality) public payable {
        require(price > 0, "Price must be atleast 1 Wei");
        _itemsIds.increment();
        uint256 itemId = _itemsIds.current();

        marketItems[itemId] = NFTMarketItem(
            tokenId,
            price,
            nftContract,
            payable(msg.sender),
            payable(address(0)),
            false
        );
        NFTMarketItem memory nftMarketItem = marketItems[tokenId];
        (uint256 royaltyFee, address creator) = getRoyalty(nftMarketItem.nftContract, tokenId);
        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);
        
    }



    function buyNFT(uint256 tokenId) external payable nonReentrant{
        NFTMarketItem memory nftMarketItem = marketItems[tokenId];

        (uint256 royalty, address creator) = getRoyalty(nftMarketItem.nftContract, tokenId);
        require(nftMarketItem.sold == false, "NFT is not up for sale");
        require(msg.sender.balance >= nftMarketItem.price, "Account balance is less then the price of the NFT");
        uint256 price = nftMarketItem.price;
        uint256 royalityFee = (price * royalty )/ denominator;
        uint256 marketPlaceFee = price * platformFee / denominator;
        
        tokenAddress.transferFrom(msg.sender,address(nftMarketItem.seller), price);// 10 matic
        tokenAddress.transferFrom(msg.sender, address(creator), royalityFee);
        tokenAddress.transferFrom(msg.sender, address(this), marketPlaceFee);
        marketItems[tokenId].owner = payable(msg.sender);
        marketItems[tokenId].sold = true;
        
        IERC721(marketItems[tokenId].nftContract).transferFrom(address(this), msg.sender, tokenId);
         
    }


    function getRoyalty(address nftContractAddress, uint256 _tokenId) internal view returns (uint256 _royalty, address _creator) {
            return IGetRoyalty(nftContractAddress).royaltyInfo(_tokenId);     
    }
    
} 