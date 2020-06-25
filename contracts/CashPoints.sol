pragma solidity >=0.5.0 <0.6.0;

contract CashPoints {
uint public Count;

struct Coordinate {
    int _degrees;
    uint _minutes;
    uint _seconds;
}


struct CashPoint {
    string _name; //short Name
    Coordinate _latitude;
    Coordinate _longitude;
    uint _phoneNumber;
    uint rate; //local currency to usd rate
    uint endtime; //when time as cashpoint will expire
    bool isCashPoint;
    
}

mapping (address=>CashPoint) cashpoints;
event CreatedCashPoint(address cashpoint, string name, int latdeg, uint latmin, uint latsec,int longdeg, uint longmin, uint longsec, uint rate, uint endtime);

function addCashPoint(string memory name, int latdeg, uint latmin, uint latsec, int longdeg, uint longmin, uint longsec, uint phone, uint rate, uint duration) public{
   
    if(block.timestamp >= cashpoints[msg.sender].endtime)
    {
        delete cashpoints[msg.sender];
        Count--;
    }
    
    require(!cashpoints[msg.sender].isCashPoint);
    Coordinate memory myLat = Coordinate(latdeg, latmin, latsec);
    Coordinate memory myLong = Coordinate(longdeg, longmin, longsec);
    uint endtime = block.timestamp + duration * 1 days;
    bool isCashPoint = true;

    cashpoints[msg.sender] = CashPoint(name, myLat, myLong, phone, rate, endtime, isCashPoint);
    Count++;
    emit CreatedCashPoint(msg.sender, name, latdeg, latmin, latsec, longdeg, longmin, longsec, rate, endtime);
}


}

