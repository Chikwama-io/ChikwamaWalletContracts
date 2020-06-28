pragma solidity >=0.5.0 <0.7.0;

contract CashPoints {
uint public Count;

struct CashPoint {
    string _name; //short Name
    int _latitude;
    int _longitude;
    uint _phoneNumber;
    uint rate; //local currency to usd rate
    uint endtime; //when time as cashpoint will expire
    bool isCashPoint;
}

mapping (address=>CashPoint) cashpoints;
event CreatedCashPoint(address cashpoint, string name, int lat, int long, uint rate, uint endtime);

function addCashPoint(string memory name, int mylat, int mylong, uint phone, uint rate, uint duration) public{
    if(block.timestamp >= cashpoints[msg.sender].endtime)
    {
        delete cashpoints[msg.sender];
        Count--;
    }
    require(!cashpoints[msg.sender].isCashPoint);
    uint endtime = block.timestamp + duration * 1 days;
    bool isCashPoint = true;

    cashpoints[msg.sender] = CashPoint(name, mylat, mylong, phone, rate, endtime, isCashPoint);
    Count++;
    emit CreatedCashPoint(msg.sender, name, mylat, mylong, rate, endtime);
}


}

