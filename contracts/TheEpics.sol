// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import {Base64} from "./libraries/Base64.sol";

/// @notice Extend the ERC721URIStorage contract
contract TheEpics is ERC721URIStorage {
    /// @dev use OZ based magic to track tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    /// @notice Maximum number of tokens allowed.
    uint256 public constant MAX_MINT_COUNT = 1337;

    /// @dev the base svg as a string
    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' />";

    /// @dev Generative Words
    string[] desertFolk = [
        "Bright",
        "Brown",
        "Browne",
        "Brushfire",
        "Camp",
        "Campman",
        "Canyon",
        "Cricketts",
        "Crickets",
        "Dunes",
        "Doons",
        "Doones",
        "Dunne",
        "Dunneman",
        "Flats",
        "Fox",
        "Foxx",
        "Gold",
        "Golden",
        "Grey",
        "Gray",
        "Gulch",
        "Gully",
        "Hardy",
        "Hills",
        "Hill",
        "Hopper",
        "Hunter",
        "Huntsman",
        "March",
        "Marcher",
        "Moon",
        "Redmoon",
        "Palmer",
        "Palms",
        "Peartree",
        "Pearman",
        "Redd",
        "Red",
        "Rider",
        "Ryder",
        "Rock",
        "Rockman",
        "Rock",
        "Rockman",
        "Rocker",
        "Sands",
        "Scales",
        "Redscale",
        "Greyscale",
        "Singer",
        "Small",
        "Smalls",
        "Star",
        "Starr",
        "Stone",
        "Stoneman",
        "Storm",
        "Storms",
        "Strider",
        "Stryder",
        "Sunn",
        "Sunner",
        "Tumbleweed",
        "Walker",
        "Water",
        "Watters"
    ];
    string[] farmFolk = [
        "Appletree",
        "Appler",
        "Applin",
        "Barley",
        "Barleycorn",
        "Barleywine",
        "Barns",
        "Barnes",
        "Barnard",
        "Beans",
        "Beanman",
        "Beanstalk",
        "Berry",
        "Berryland",
        "Bloom",
        "Bloomland",
        "Brown",
        "Brownland",
        "Brownard",
        "Bull",
        "Bullyard",
        "Cabbage",
        "Kabbage",
        "Cotton",
        "Cottonseed",
        "Croppe",
        "Cropman",
        "Dairyman",
        "Darryman",
        "Darry",
        "Derry",
        "Farmer",
        "Farmor",
        "Fields",
        "Fielder",
        "Fieldman",
        "Flats",
        "Redflats",
        "Sandflats",
        "Stoneflats",
        "Flowers",
        "Gardner",
        "Gardener",
        "Gardiner",
        "Green",
        "Greene",
        "Greenland",
        "Greenyard",
        "Grove",
        "Groveland",
        "Hays",
        "Hayes",
        "Hayward",
        "Henkeeper",
        "Hennerman",
        "Herd",
        "Hurd",
        "Herdland",
        "Land",
        "Lander",
        "Mares",
        "Mayr",
        "Mair",
        "Meadows",
        "Milk",
        "Millet",
        "Millett",
        "Mills",
        "Miller",
        "Millard",
        "Neeps",
        "Neepland",
        "Nutt",
        "Nutman",
        "Oates",
        "Oats",
        "Overland",
        "Overfield",
        "Peartree",
        "Pearman",
        "Pease",
        "Peapod",
        "Peabody",
        "Picket",
        "Picketts",
        "Pickens",
        "Pickman",
        "Plant",
        "Planter",
        "Ploughman",
        "Plowman",
        "Plougherman",
        "Pollen",
        "Pollin",
        "Polly",
        "Pollard",
        "Rains",
        "Raines",
        "Rayns",
        "Raynes",
        "Rainard",
        "Root",
        "Roote",
        "Rutland",
        "Shepherd",
        "Shepard",
        "Shepyrd",
        "Shearer",
        "Sheerer",
        "Shears",
        "Sheers",
        "Sower",
        "Soward",
        "Tate",
        "Tater",
        "Thresh",
        "Threshett",
        "Tiller",
        "Tillman",
        "Vines",
        "Vineland",
        "Wheatley",
        "Wheatly",
        "Wheat",
        "Whittaker",
        "Whitard",
        "Winnows",
        "Winnower",
        "Wool",
        "Woolard",
        "Yardly",
        "Yardley",
        "Yards"
    ];
    string[] foodMakers = [
        "Ales",
        "Aleman",
        "Aler",
        "Baker",
        "Bake",
        "Bakeler",
        "Barr",
        "Barre",
        "Barman",
        "Berry",
        "Berryman",
        "Berriman",
        "Boyle",
        "Boiles",
        "Boyles",
        "Brewer",
        "Brewster",
        "Broyles",
        "Broiles",
        "Broyler",
        "Butcher",
        "Butchett",
        "Cook",
        "Dice",
        "Dougherman",
        "Dougher",
        "Fry",
        "Frey",
        "Fryman",
        "Gardner",
        "Gardener",
        "Gardiner",
        "Grills",
        "Grillett",
        "Innes",
        "Innman",
        "Inman",
        "Kettle",
        "Kettleblack",
        "Kettleman",
        "Kneadler",
        "Kneadman",
        "Milk",
        "Miller",
        "Mills",
        "Miller",
        "Palewine",
        "Pan",
        "Pannerman",
        "Panning",
        "Peppers",
        "Pepper",
        "Pickler",
        "Pickleman",
        "Pickles",
        "Pieman",
        "Piemaker",
        "Potts",
        "Pott",
        "Potter",
        "Redwine",
        "Roasterman",
        "Salt",
        "Salter",
        "Simms",
        "Simmerman",
        "Slaughter",
        "Smoke",
        "Smoker",
        "Vines",
        "Vintner",
        "Vinaker Winaker",
        "Wineman"
    ];
    string[] frozenLands = [
        "Biggs",
        "Bigg",
        "Byggs",
        "Camp",
        "Campman",
        "Coates",
        "Frost",
        "Furrs",
        "Furrman",
        "Graysky",
        "Whitesky",
        "Blacksky",
        "Grey",
        "Gray",
        "Hardy",
        "Hardison",
        "Hardland",
        "Harland",
        "Hills",
        "Hill",
        "Hylls",
        "Hunter",
        "Huntsman",
        "Ice",
        "Iceland",
        "Icewind",
        "Icecutter",
        "Yceland",
        "Ycewind",
        "Ycecutter",
        "Longnight",
        "Longdark",
        "Moon",
        "Wintermoon",
        "North",
        "Northman",
        "Norman",
        "Northland",
        "Norland",
        "Pix",
        "Pickman",
        "Pickes",
        "Pyckes",
        "Seales",
        "Seals",
        "Silver",
        "Silvermoon",
        "Sylver",
        "Snow",
        "Snowes",
        "Star",
        "Starr",
        "Northstar",
        "Stone",
        "Stoneman",
        "Strider",
        "Stryder",
        "Walker",
        "White",
        "Whyte",
        "Winter",
        "Winters",
        "Wynters"
    ];
    string[] garmentMakers = [
        "Bobbin",
        "Bolt",
        "Bolte",
        "Bolter",
        "Button",
        "Buttonworth",
        "Capers",
        "Coates",
        "Cotton",
        "Dyer",
        "Dye",
        "Dyeworth",
        "Dyerson",
        "Dyson",
        "Felter",
        "Felterman",
        "Glover",
        "Hatter",
        "Hatty",
        "Hattiman",
        "Hatson",
        "Hemmings",
        "Hemings",
        "Hemson",
        "Hyde",
        "Hides",
        "Hydes",
        "Leathers",
        "Lethers",
        "Mercer",
        "Needleman",
        "Needler",
        "Needleworth",
        "Seams",
        "Seems",
        "Seemworth",
        "Shearer",
        "Sheerer",
        "Shears",
        "Sheers",
        "Shoemaker",
        "Stitches",
        "Stitchworth",
        "Tailor",
        "Taylor",
        "Tanner",
        "Tannerman",
        "Thredd",
        "Threddler",
        "Threddman",
        "Threddaker",
        "Weaver",
        "Weever",
        "Wool",
        "Woolworth",
        "Yardly",
        "Yardley",
        "Yards"
    ];
    string[] islanders = [
        "Bay",
        "Bayes",
        "Bayer",
        "Bayers",
        "Beacher",
        "Beach",
        "Blue",
        "Bowman",
        "Castaway",
        "Crabb",
        "Crab",
        "Crest",
        "Days",
        "Dayes",
        "Dunes",
        "Doons",
        "Doones",
        "Dunne",
        "Dunneman",
        "Eddy",
        "Fisher",
        "Fishman",
        "Flowers",
        "Harper",
        "Hook",
        "Hooke",
        "Iles",
        "Isles",
        "Ailes",
        "Mast",
        "Palmer",
        "Palms",
        "Rafman",
        "Raftman",
        "Reel",
        "Reelings",
        "Salt",
        "Seasalt",
        "Sands",
        "Sandman",
        "Seabreeze",
        "Shell",
        "Shellman",
        "Shellmound",
        "Sheller",
        "Shelley",
        "Shoals",
        "Singer",
        "Star",
        "Starr",
        "Stern",
        "Sterne",
        "Stillwater",
        "Storm",
        "Storms",
        "Summers",
        "Sunn",
        "Sunner",
        "Swimmer",
        "Shwimmer",
        "Swymmer",
        "Tidewater",
        "Waters",
        "Watters",
        "Waterman"
    ];
    string[] crafters = [
        "Arch",
        "Archmaker",
        "Baskett",
        "Basket",
        "Bilder",
        "Builder",
        "Bulder",
        "Bilds",
        "Blow",
        "Brickman",
        "Bricker",
        "Brycks",
        "Bricks",
        "Burgh",
        "Berg",
        "Burg",
        "Burgher",
        "Berger",
        "Burger",
        "Carpenter",
        "Chandler",
        "Candler",
        "Clay",
        "Cooper",
        "Crafter",
        "Glass",
        "Glazier",
        "Glasier",
        "Hammer",
        "Maker",
        "Mason",
        "Masen",
        "Masyn",
        "Potts",
        "Pott",
        "Potter",
        "Quarrier",
        "Quarryman",
        "Rock",
        "Rockman",
        "Rocker",
        "Roof",
        "Roofe",
        "Sawyer",
        "Stone",
        "Stoneman",
        "Townes",
        "Towns",
        "Towny",
        "Wahl",
        "Wall",
        "Wahls",
        "Walls",
        "Waller",
        "Waxman",
        "Wax",
        "Wackes",
        "Wood",
        "Woods"
    ];
    string[] mountainFolk = [
        "Billy",
        "Billie",
        "Bluffe",
        "Bluffclimber",
        "Boulder",
        "Bulder",
        "Camp",
        "Campman",
        "Claymer",
        "Clayms",
        "Claimer",
        "Cole",
        "Coler",
        "Coleman",
        "Coalman",
        "Coaler",
        "Coaldigger",
        "Coledegger",
        "Condor",
        "Condorman",
        "Cragg",
        "Cragman",
        "Diggs",
        "Digger",
        "Diggman",
        "Digger",
        "Diggett",
        "Dragonhoard",
        "Dragonhord",
        "Dragon",
        "Drake",
        "Dredge",
        "Dredger",
        "Hall",
        "Haul",
        "Heights",
        "Hights",
        "Hytes",
        "Hites",
        "Highland",
        "Hills",
        "Hill",
        "Hillclimber",
        "Hylltopper",
        "Hoard",
        "Hord",
        "Hoar",
        "Hoardigger",
        "Hordegger",
        "Kidd",
        "Kipman",
        "Kipper",
        "Kipson",
        "Kopperfield",
        "Miner",
        "Myner",
        "Mynor",
        "Minor",
        "Mole",
        "Moler",
        "Moller",
        "Molson",
        "Molsen",
        "Ores",
        "Orr",
        "Orrs",
        "Oredigger",
        "Orrdegger",
        "Orson",
        "Orrsen",
        "Pan",
        "Pans",
        "Pannerman",
        "Panning",
        "Peaks",
        "Peeks",
        "Pike",
        "Pyke",
        "Pikeclimber",
        "Pyketopper",
        "Pix",
        "Pickman",
        "Pickes",
        "Pyckes",
        "Pickens",
        "Quarrier",
        "Quarryman",
        "Ridge",
        "Ridgeclimber",
        "Ridgetopper",
        "Rock",
        "Rockman",
        "Rocker",
        "Rockridge",
        "Snow",
        "Snowes",
        "Spade",
        "Spader Springs",
        "Springer",
        "Stone",
        "Stoneman",
        "Underhill",
        "Underwood",
        "Underman",
        "Walker"
    ];
    string[] merchants = [
        "Barr",
        "Barre",
        "Cash",
        "Copper",
        "Coppers",
        "Curry",
        "Deals",
        "Deels",
        "Deel",
        "Deelaker",
        "Deelman",
        "Diamond",
        "Glass",
        "Glazier",
        "Glasier",
        "Gold",
        "Golden",
        "Goldsmith",
        "Goldman",
        "Jewels",
        "Jules",
        "Jewls",
        "Lender",
        "Lenderman",
        "Lynder",
        "Mercer",
        "Money",
        "Munny",
        "Monny",
        "Munnee",
        "Monnee",
        "Peppers",
        "Pepper",
        "Rich",
        "Richman",
        "Richett",
        "Riches",
        "Saffron",
        "Sage",
        "Salt",
        "Scales",
        "Shine",
        "Ships",
        "Schipps",
        "Shipps",
        "Shipman",
        "Schippman",
        "Silver",
        "Sylver",
        "Silverman",
        "Small",
        "Smalls",
        "Spicer",
        "Spiceman",
        "Star",
        "Starr",
        "Thyme",
        "Ware",
        "Wool"
    ];
    // string[] scholars = ["Altarside", "Altarworthy", "Beacon", "Beecon", "Beeken", "Bell", "Bolt", "Bolte", "Bolter", "Bones", "Bright", "Burns", "Cast", "Caster", "Kast", "Chaplain", "Chaplin", "Church", "Churchside", "Darko", "Darkstar", "Darker", "Darkbrother", "Deacon", "Deecon", "Deeken", "Drake", "Draco", "Dragon", "Dreamer", "Dreemer", "Dreems", "Goodbrother", "Goodman", "Hecks", "Heckes", "Hex", "Holiday", "Holliday", "Holyday", "Hollier", "Holly", "Holier", "Hollison", "Hood", "Kearse", "Kerse", "Kerser", "Curser", "Monk", "Munk", "Nunn", "Nun", "Powers", "Preacher", "Preecher", "Priest", "Preest", "Sage", "Sageworthy", "Saint", "School", "Skool", "Skolar", "Scholyr", "Shock", "Shocker", "Shaka", "Skelton", "Skeltyn", "Smart", "Spelling", "Speller", "Star", "Starr", "Brightstar", "Teech", "Teeches", "Theery", "Tinker", "Tutor", "Tudor", "Vickers", "Vykar", "Vicker", "Vikars", "Wise", "Overwise", "Worthy", "Zapp", "Zappa"];
    // string[] riverFolk = ["Banks", "Bankes", "Bend", "Benderman", "Blue", "Bridges", "Cray", "Craw", "Eddy", "Ferryman", "Ferrimen", "Ferry", "Fisher", "Fishman", "Flowers", "Garr", "Hook", "Hooke", "Hopper", "Iles", "Isles", "Ailes", "Mills", "Miller", "Oars", "Orrs", "Orr", "Oxbow", "Piers", "Peers", "Poleman", "Polman", "Porter", "Rafman", "Raftman", "Reed", "Reede", "Reedy", "Reel", "Reelings", "River", "Rivers", "Salmon", "Shell", "Shellman", "Sheller", "Shelley", "Silver", "Silvermoon", "Small", "Smalls", "Snails", "Snailman", "Spanner", "Stillwater", "Streams", "Streems", "Swimmer", "Shwimmer", "Swymmer", "Trout", "Waters", "Watters", "Waterman", "Whitewater", "Wurms", "Worms"];
    // string[] seaFolk = ["Anchor", "Ankor", "Anker", "Ballast", "Bay", "Bayes", "Bayer", "Bayers", "Beacon", "Biggs", "Bigg", "Brigg", "Briggs", "Bowman", "Capp", "Capman", "Castaway", "Crabb", "Crab", "Crabber", "Crabman", "Crest", "Darkwater", "Decks", "Decker", "Eddy", "Ferryman", "Ferrimen", "Ferry", "Fisher", "Fishman", "Hardy", "Hardison", "Harper", "Helms", "Helmsman", "Hook", "Hooke", "Iles", "Isles", "Ailes", "Mast", "Oars", "Orrs", "Orr", "Piers", "Peers", "Pitch", "Pytch", "Porter Redtide", "Blacktide", "Riggs", "Riggett", "Sailor", "Saylor", "Sailer", "Sayler", "Salt", "Seasalt", "Saltman", "Seabreeze", "Seaman", "Season", "Seeman", "Ships", "Schipps", "Shipps", "Shipman", "Schippman", "Shore", "Shoreman", "Singer", "Star", "Starr", "Stern", "Sterne", "Storm", "Storms", "Swimmer", "Shwimmer", "Swymmer", "Tar", "Tarr", "Tidewater", "Tuggs", "Tugman", "Waters", "Watters", "Waterman", "Whitewater"];
    // string[] smiths = ["Anvill", "Anvilson", "Bellows", "Black", "Blackiron", "Copper", "Coppers", "Farrier", "Fletcher", "Fletchett", "Forger", "Forgeman", "Goldsmith", "Grey", "Greysteel", "Hammer", "Hammett", "Irons", "Yrons", "Ironsmith", "Ironshoe", "Ironhoof", "Kettle", "Kettleblack", "Kettleman", "Potts", "Pott", "Pottaker", "Pound", "Poundstone", "Shields", "Shieldson", "Slagg", "Slagman", "Smith", "Smyth", "Smitts", "Smittens", "Smitty", "Smythett", "Smoke", "Smoker", "Steel", "Steele", "Steelman", "Swords", "Swordson", "Tinn", "Tinman", "Tynn", "Tyne", "Tine"];
    // string[] swampFolk = ["Banks", "Bankes", "Black", "Blacktide", "Greentide", "Boggs", "Bogg", "Bogs", "Bull", "Buzzfly", "Blackfly", "Shoefly", "Cray", "Craw", "Cricketts", "Crickets", "Darkwater", "Dragonfly", "Dragon", "Eeler", "Ealer", "Eeles", "Eales", "Fisher", "Fishman", "Frogg", "Frogman", "Green", "Greene", "Greenwater", "Blackwater", "Grey", "Gray", "Grove", "Groves", "Hook", "Hooke", "Hopper", "Marsh", "Mayfly", "May", "Moss", "Mosstree", "Greentree", "Poisonweed", "Poisonwood", "Polly", "Pollywog", "Polliwog", "Rafman", "Raftman", "Ratt", "Ratman", "Reed", "Reede", "Reedy", "River", "Rivers", "Rotten", "Rotman", "Scales", "Greenscale", "Blackscale", "Shell", "Shellman", "Sheller", "Shelley", "Skeeter", "Skito", "Small", "Smalls", "Snails", "Snailman", "Stillwater", "Swimmer", "Shwimmer", "Swymmer", "Thick", "Thicke", "Tidewater", "Vines", "Waters", "Watters", "Wurms", "Worms"];

    /// @notice Event for minting the NFT
    event EpicMinted(uint256 indexed id, address from);

    /// @notice Pass name and symbol of our token to the ERC721 constructor
    constructor() ERC721("The Epics", "EPIC") {
        // console.log("EpicNFT constructed!");
    }

    /// @notice Picks a random word from the generative strings
    function pickRandomWord(
        string memory list_name,
        uint256 tokenId,
        string[] memory list
    ) public pure returns (string memory) {
        // Seed the random generator
        uint256 rand = random(
            string(abi.encodePacked(list_name, Strings.toString(tokenId)))
        );

        // Squash the # between 0 and the length of the array to avoid going out of bounds
        rand = rand % list.length;
        return list[rand];
    }

    /// @dev Returns the random number using the hash of the packed abi encoding
    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    /// @notice get the current number of minted tokens
    function currentMintCount() public view returns (uint256) {
        return _tokenIds.current();
    }

    /// @notice get the max allowed number of minted tokens
    function getMaxMintCount() public pure returns (uint256) {
        return MAX_MINT_COUNT;
    }

    // /// @notice gets all tokens for a given user
    // function getUserTokens() public pure returns (uint256[] memory) {
    //     uint256[] memory tokens;
    //     for (uint256 i = 0; i < 1337; i++) {
    //         tokenOfOwnerByIndex(msg.sender, i);
    //     }
    // }

    /// @notice Minting function
    function makeAnEpicNFT() public {
        // Get the current tokenId starting from 0
        uint256 newItemId = _tokenIds.current();
        string memory newItemString = Strings.toString(newItemId);

        // Grab random attributes
        string memory desert = desertFolk[
            random(string(abi.encodePacked("DESERT_FOLK", newItemString))) %
                desertFolk.length
        ];
        string memory farm = farmFolk[
            random(string(abi.encodePacked("FARM_FOLK", newItemString))) %
                farmFolk.length
        ];
        string memory food = foodMakers[
            random(string(abi.encodePacked("FOOD_MAKERS", newItemString))) %
                foodMakers.length
        ];
        string memory frozen = frozenLands[
            random(string(abi.encodePacked("FROZEN_LANDS", newItemString))) %
                frozenLands.length
        ];
        string memory garment = garmentMakers[
            random(string(abi.encodePacked("GARMENT_MAKERS", newItemString))) %
                garmentMakers.length
        ];
        string memory islander = islanders[
            random(string(abi.encodePacked("ISLANDERS", newItemString))) %
                islanders.length
        ];
        string memory crafter = crafters[
            random(string(abi.encodePacked("CRAFTERS", newItemString))) %
                crafters.length
        ];
        string memory mountain = mountainFolk[
            random(string(abi.encodePacked("MOUNTAIN_FOLK", newItemString))) %
                mountainFolk.length
        ];
        // string memory merchant = merchants[random(string(abi.encodePacked("MERCHANTS", newItemString))) % merchants.length];
        // string memory scholar = scholars[random(string(abi.encodePacked("SCHOLARS", newItemString))) % scholars.length];
        // string memory river = riverFolk[random(string(abi.encodePacked("RIVER_FOLK", newItemString))) % riverFolk.length];
        // string memory swamp = swampFolk[random(string(abi.encodePacked("SWAMP_FOLK", newItemString))) % swampFolk.length];

        string memory combinedWords = string(
            abi.encodePacked(
                desert,
                " ",
                farm,
                " ",
                food,
                " ",
                frozen,
                " ",
                garment,
                " ",
                islander,
                " ",
                crafter,
                " ",
                mountain
            )
        );

        // I concatenate it all together, and then close the <text> and <svg> tags.
        string memory finalSvg = string(
            abi.encodePacked(
                baseSvg,
                "<text class='base' margin='2px' x='4%' y='8%'>",
                desert,
                "</text><text class='base' margin='2px' x='4%' y='16%'>",
                farm,
                "</text><text class='base' margin='2px' x='4%' y='24%'>",
                food,
                "</text><text class='base' margin='2px' x='4%' y='32%'>",
                frozen,
                "</text><text class='base' margin='2px' x='4%' y='40%'>",
                garment,
                "</text><text class='base' margin='2px' x='4%' y='48%'>",
                islander,
                "</text><text class='base' margin='2px' x='4%' y='56%'>",
                crafter,
                "</text><text class='base' margin='2px' x='4%' y='64%'>",
                mountain,
                // "</text><text class='base' margin='2px' x='4%' y='72%'>",
                // merchant,
                // "</text><text class='base' margin='2px' x='4%' y='80%'>",
                // scholar,
                // "</text><text class='base' margin='2px' x='4%' y='88%'>",
                // river,
                // "</text><text class='base' margin='2px' x='4%' y='88%'>",
                // swamp,
                "</text></svg>"
            )
        );

        console.log("Final SVG:\n");
        console.log(finalSvg);
        console.log("\n");

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        combinedWords,
                        '", "description": "',
                        combinedWords,
                        ' Edition of Dinosaurs and Caves", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        // Mint the token
        _safeMint(msg.sender, newItemId);

        // Set the token URI to the Base64 Encoded svg
        _setTokenURI(newItemId, finalTokenUri);

        // We can't forget to increment the token ids!
        _tokenIds.increment();

        // Emit an event for sanity
        emit EpicMinted(newItemId, msg.sender);
    }
}
