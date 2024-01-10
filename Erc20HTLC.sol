// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20, Ownable, ERC20Permit {
    bytes32 public secretHash;
    address public recipient;
    uint256 public timelock;
    // uint256 public mintAmount;
    uint256 public amountAllowedToMint;

    event TokensClaimed(string secret);
    event RecipientChanged(address newRecipient);
    event TokensBurned(address indexed burner, uint256 amount);
    event secertHashChanged (bool newSecertHash);

    constructor(
        // address _initialOwner
        // bytes32 _secretHash,
        // address _recipient
    ) ERC20("MyToken", "MTK") Ownable() ERC20Permit("MyToken") {
        timelock = block.timestamp + 7 days;
        // secretHash = _secretHash;
        // recipient = _recipient;
    }

    function mint(string memory _secret, uint256 _amount ) public {
        require(msg.sender == recipient, "Only the recipient can mint tokens.");
        require(block.timestamp <= timelock, "The timelock has expired.");
        require(sha256(abi.encodePacked(_secret)) == secretHash,
            "Invalid secret.");
        require(_amount <= amountAllowedToMint, "Amount bigger than balance allowed to mint .");

        _mint(recipient, _amount);

        emit TokensClaimed(_secret);
        secretHash = 0x0; // Reset the secret hash to prevent further minting
    }

    function burn(uint256 _amount, address _burnFromAddress) public onlyOwner{
        _burn(_burnFromAddress, _amount);
        emit TokensBurned(msg.sender, _amount);
    }

    function setNewRecipient(address _recipient) public onlyOwner {
        recipient = _recipient;
        emit RecipientChanged(_recipient);
    }

     function prepareSwap(bytes32 _newSecertHash, address _recipient , uint256 _approveMintAmount ) public onlyOwner {

        secretHash = _newSecertHash;
        recipient = _recipient;
        amountAllowedToMint = _approveMintAmount;

        emit RecipientChanged(_recipient);
        emit secertHashChanged(true);
    }

    // rest of erc 20 functions
}
