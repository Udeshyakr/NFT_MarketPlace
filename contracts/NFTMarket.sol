//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTMarket {
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
        uint256 itemId;
        address nftContract;
        uint256 tokenId;
        uint256 royality;// adding royality
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    mapping(uint256 => NFTMarketItem) public marketItems;

    event MarketItemCreated(
        uint indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );


    function listNFTs(address nftContract, uint256 tokenId, uint256 price, uint256 royality) public {
        require(price > 0, "Price must be atleast 1 Wei");
        require(royality > 0, "royality should be between 0 to 10");
        require(royality < 10, "royality should less that 10");
        //require(msg.value == listingPrice,"Price must be equal or greater than listing Price");
        _itemsIds.increment();
        uint256 itemId = _itemsIds.current();

        marketItems[itemId] = NFTMarketItem(
            itemId,
            nftContract,
            tokenId,
            royality, // Initializing royality
            payable(msg.sender),
            payable(address(0)),
            price,
            false
        );
        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);
        emit MarketItemCreated(
            itemId, 
            nftContract, 
            tokenId, 
            msg.sender, 
            address(0), 
            price, 
            false
            );
    }



    function buyNFT(uint256 tokenId) public payable{
        uint256 price = marketItems[tokenId].price;
        uint256 royalityFee = marketItems[tokenId].royality / denominator;
        uint256 marketPlaceFee = price * platformFee / denominator;
        
        tokenAddress.transferFrom(msg.sender,address(this), price);// 10 matic
        tokenAddress.transferFrom(msg.sender, address(owner), royalityFee);
        tokenAddress.transferFrom(msg.sender, address(this), marketPlaceFee);
        marketItems[tokenId].owner = payable(msg.sender);

        _nftSold.increment();  
        IERC721(marketItems[tokenId].nftContract).transferFrom(address(this), msg.sender, tokenId);
         
    }
    
} 
