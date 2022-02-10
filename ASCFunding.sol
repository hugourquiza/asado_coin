pragma solidity 0.5.16;


interface DaiToken {
    function transfer(address dst, uint wad) external returns (bool);
    function transferFrom(address src, address dst, uint wad) external returns (bool);
    function balanceOf(address guy) external view returns (uint);
}


interface ASCToken {
    function transfer(address dst, uint wad) external returns (bool);
}

contract ASCFunding {
    DaiToken public daiToken;
    ASCToken public ascToken;
    address owner;    

    constructor() public {
        daiToken = DaiToken(0x1AF3F329e8BE154074D8769D1FFa4eE058B1DBc3);
        ascToken=ASCToken(0x167DFB2f0ef926122ec0de9726602c504c46dF64);
        owner = msg.sender;
    }

    function stakeTokens(uint _amount) public {
        require(_amount > 0, "amount should be > 0");
        daiToken.transferFrom(msg.sender, address(this), _amount);        
        //1 DAI=1 ASC
        ascToken.transfer(msg.sender,_amount/1000000000000000000);
    }

    function unstakeTokens(uint _amount) public {
       require(msg.sender == owner, "This can only be called by the contract owner!");
       daiToken.transfer(msg.sender, _amount);
    }

    function unstakeASCTokens(uint _amount) public {
       require(msg.sender == owner, "This can only be called by the contract owner!");
       ascToken.transfer(msg.sender, _amount);
    }
    
}