// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8;


interface ASCToken {
    function transfer(address dst, uint wad) external returns (bool);
}


contract ASCAirdrop {
    uint a_val;
    ASCToken ascToken;
    mapping(address => bool) public recv_ad;
    address owner;   

    constructor(address asc_token_addr) {        
        //dev only
        //ascToken=ASCToken(0x19801617211f09a2Ef9C5E34eA8B2d7aAd8E79e2);

        //prod
        ascToken=ASCToken(asc_token_addr);
        a_val=1;
        owner = msg.sender;
    }

    modifier owner_only() {
        require(msg.sender == owner, "owner only juira!");
        _;
    }

    function receive_airdrop() public {    
        require(!recv_ad[msg.sender], "ya tuviste tu airdrop");        
        recv_ad[msg.sender] = true;     
        ascToken.transfer(msg.sender,a_val);   
    }
    
    function update_airdrop_amount(uint value) public owner_only {        
        a_val=value;
    }
    function unstake_tokens(uint _amount) public owner_only{       
       ascToken.transfer(msg.sender, _amount);
    }
    
}