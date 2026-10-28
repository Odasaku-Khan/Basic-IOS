import Foundation
struct Account {
    let image: String
    let name: String
    let subscribers: String
    let posts: String
    let following: String
    let about: String
    let aboutDescription: String
}

var accountList: [Account] = [
    Account(
        image: "michael",
        name: "Michael Jackson",
        subscribers: "120M",
        posts: "312",
        following: "48",
        about: "King of Pop",
        aboutDescription: "American singer, songwriter, dancer, and entertainer known worldwide for his music, performances, and influence on popular culture."
    ),

    Account(
        image: "spiderman",
        name: "Spider-Man",
        subscribers: "28M",
        posts: "846",
        following: "214",
        about: "Friendly Neighborhood Hero",
        aboutDescription: "A young superhero from New York who balances everyday life with protecting the city using his agility, intelligence, and web-slinging abilities."
    ),

    Account(
        image: "ironman",
        name: "Iron Man",
        subscribers: "35M",
        posts: "1.2K",
        following: "96",
        about: "Genius Inventor",
        aboutDescription: "Tony Stark is a brilliant inventor who combines engineering, advanced technology, and determination to fight threats using the Iron Man armor."
    ),

    Account(
        image: "batman",
        name: "Batman",
        subscribers: "31M",
        posts: "624",
        following: "52",
        about: "The Dark Knight",
        aboutDescription: "Gotham City's mysterious vigilante uses detective skills, strategy, technology, and intense training to fight crime."
    ),

    Account(
        image: "darthvader",
        name: "Darth Vader",
        subscribers: "42M",
        posts: "404",
        following: "8",
        about: "Dark Lord",
        aboutDescription: "A powerful warrior connected to the Force, known for his intimidating presence and central role in a galaxy divided by conflict."
    )
]
