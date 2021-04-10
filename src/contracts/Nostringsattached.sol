pragma solidity ^0.5.0;
string public name = "Nostringsattached";
mapping(uint => Song) public songs;
uint public songCount = 0;
 event SongCreated(
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author
  );
struct Song{
    uint id;
    string hash;
    string description;
    uint tipAmount; 
    address payable author;
}
  function uploadSong(string memory _songHash, string memory _description) public {
    require(bytes(_description).length>0);
    require(bytes(_songHash).length>0);
    require(msg.sender!=address(0x0));
    songCount++; 
    songs[songCount] = Song(songCount,_songHash,_description,0,msg.sender);
    emit SongCreated(songCount,_songHash,_description,0,msg.sender);
  }
  function tipImageOwner(uint _id) public payable {
    require(_id > 0 && _id <= songCount);  
    Song memory _song = songs[_id];
    address payable _author = _song.author;
    address(_author).transfer(msg.value);
  }