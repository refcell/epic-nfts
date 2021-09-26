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
    constructor() ERC721("EpicContract", "EPIC") {
        console.log("EpicContract constructed!");
    }

    /// @notice Initial minting function
    function makeAnEpicNFT() public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data.
        _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiRXBpY1NoYWRvd0NvbnRyYWN0IiwKICAgICJkZXNjcmlwdGlvbiI6ICJBIHJlcHJlc2VudGF0aW9uIG9mIHRoZSBlbmlnbWF0aWMgc2hhZG93eSBzbWFydCBjb250cmFjdC4iLAogICAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjNhV1IwYUQwaU1UQXdJaUJvWldsbmFIUTlJakV3TUNJZ2RtbGxkMEp2ZUQwaU1DQXdJREV3TUNBeE1EQWlJR1pwYkd3OUltNXZibVVpSUhodGJHNXpQU0pvZEhSd09pOHZkM2QzTG5jekxtOXlaeTh5TURBd0wzTjJaeUlnYzNSNWJHVTlJbmRwWkhSb09pQXlNREJ3ZURzZ2FHVnBaMmgwT2lBeU1EQndlRHNpUGp4emRIbHNaVDRLSUNBZ0lDQXViR2x1WlMxbWFXeGxNUzFoSUh0aGJtbHRZWFJwYjI0NmJHbHVaUzFtYVd4bE1TMWtjbUYzSUROeklHbHVabWx1YVhSbE95QnpkSEp2YTJVdFpHRnphR0Z5Y21GNU9pQXhNVEE3ZlFvZ0lDQWdJQzVzYVc1bExXWnBiR1V4TFdJZ2UyRnVhVzFoZEdsdmJqcHNhVzVsTFdacGJHVXhMV1J5WVhjZ00zTWdNekF3YlhNZ2FXNW1hVzVwZEdVN0lITjBjbTlyWlMxa1lYTm9ZWEp5WVhrNklERXhNRHNnYzNSeWIydGxMV1JoYzJodlptWnpaWFE2SURFeU1EdDlDaUFnSUNBZ0xteHBibVV0Wm1sc1pURXRZeUI3WVc1cGJXRjBhVzl1T214cGJtVXRabWxzWlRFdFpISmhkeUF6Y3lBMk1EQnRjeUJwYm1acGJtbDBaVHNnYzNSeWIydGxMV1JoYzJoaGNuSmhlVG9nTVRFd095QnpkSEp2YTJVdFpHRnphRzltWm5ObGREb2dNVEl3TzMwS0lDQWdJQ0JBYTJWNVpuSmhiV1Z6SUd4cGJtVXRabWxzWlRFdFpISmhkeUI3Q2lBZ0lDQWdJQ0FnSURBbGUzTjBjbTlyWlMxa1lYTm9iMlptYzJWME9pQXhNakE3ZlFvZ0lDQWdJQ0FnSUNBeU1DVjdjM1J5YjJ0bExXUmhjMmh2Wm1aelpYUTZJREV5TUR0OUNpQWdJQ0FnSUNBZ0lEZ3dKWHR6ZEhKdmEyVXRaR0Z6YUc5bVpuTmxkRG9nTUR0OUNpQWdJQ0FnSUNBZ0lERXdNQ1Y3YzNSeWIydGxMV1JoYzJodlptWnpaWFE2SUMweE1UQTdmUW9nSUNBZ0lIMEtJQ0FnSUNCQWJXVmthV0VnS0hCeVpXWmxjbk10Y21Wa2RXTmxaQzF0YjNScGIyNDZJSEpsWkhWalpTa2dld29nSUNBZ0lDQWdJQ0F1YkdsdVpTMW1hV3hsTVMxaExDQXViR2x1WlMxbWFXeGxNUzFpTENBdWJHbHVaUzFtYVd4bE1TMWpJSHNLSUNBZ0lDQWdJQ0FnSUNBZ0lHRnVhVzFoZEdsdmJqb2dibTl1WlRzS0lDQWdJQ0FnSUNBZ2ZRb2dJQ0FnSUgwS0lDQWdJRHd2YzNSNWJHVStQSEJoZEdnZ1kyeGhjM005SW1acGJHd3hJaUJrUFNKTk1UUWdObFk1TkVnNE5sWXpNQzQxU0RZeExqVldOa2d4TkZvaUlHWnBiR3c5SW5KblltRW9NalUxTERJME9Td3lNelVzTVNraUlITjBjbTlyWlMxM2FXUjBhRDBpTWk0d2NIZ2lQand2Y0dGMGFENDhjR0YwYUNCamJHRnpjejBpWm1sc2JERWlJR1E5SWswNE5pQXpNQzQxVERZeExqVWdObFl6TUM0MVNEZzJXaUlnWm1sc2JEMGljbWRpWVNneU5UVXNNalE1TERJek5Td3hLU0lnYzNSeWIydGxMWGRwWkhSb1BTSXlMakJ3ZUNJK1BDOXdZWFJvUGp4d1lYUm9JR05zWVhOelBTSnpkSEp2YTJVeElpQmtQU0pOT0RZZ016QXVOVlk1TkVneE5GWTJTRFl4TGpWTk9EWWdNekF1TlV3Mk1TNDFJRFpOT0RZZ016QXVOVWcyTVM0MVZqWWlJSE4wY205clpUMGljbWRpWVNnd0xEQXNNQ3d4S1NJZ2MzUnliMnRsTFhkcFpIUm9QU0l5TGpCd2VDSStQQzl3WVhSb1BqeHNhVzVsSUdOc1lYTnpQU0pzYVc1bExXWnBiR1V4TFdFZ2MzUnliMnRsTWlJZ2VERTlJakkzTGpVaUlIa3hQU0l6TXlJZ2VESTlJalE0TGpVaUlIa3lQU0l6TXlJZ2MzUnliMnRsUFNKeVoySmhLREFzTVRRekxERTNNeXd4S1NJZ2MzUnliMnRsTFhkcFpIUm9QU0l5TGpCd2VDSStQQzlzYVc1bFBqeHNhVzVsSUdOc1lYTnpQU0pzYVc1bExXWnBiR1V4TFdJZ2MzUnliMnRsTWlJZ2VERTlJakkzTGpVaUlIa3hQU0kxTXlJZ2VESTlJamN4TGpVaUlIa3lQU0kxTXlJZ2MzUnliMnRsUFNKeVoySmhLREFzTVRRekxERTNNeXd4S1NJZ2MzUnliMnRsTFhkcFpIUm9QU0l5TGpCd2VDSStQQzlzYVc1bFBqeHNhVzVsSUdOc1lYTnpQU0pzYVc1bExXWnBiR1V4TFdNZ2MzUnliMnRsTWlJZ2VERTlJakkzTGpVaUlIa3hQU0kzTXlJZ2VESTlJamN4TGpVaUlIa3lQU0kzTXlJZ2MzUnliMnRsUFNKeVoySmhLREFzTVRRekxERTNNeXd4S1NJZ2MzUnliMnRsTFhkcFpIUm9QU0l5TGpCd2VDSStQQzlzYVc1bFBqd3ZjM1puUGc9PSIKfQ==");

        // Log when the NFT is minted.
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }
}
