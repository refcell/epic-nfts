// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

/// @notice Extend the ERC721URIStorage contract
contract MyEpicNFT is ERC721URIStorage {
    /// @dev use OZ based magic to track tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    /// @notice Pass name and symbol of our token to the ERC721 constructor
    constructor() ERC721("FoxNFT", "FOXY") {
        console.log("FoxNFT constructed!");
    }

    /// @notice Initial minting function
    function makeAnEpicNFT() public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data.
        _setTokenURI(newItemId, "[redacted]");

        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }
}
