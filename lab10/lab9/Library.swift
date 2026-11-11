import Foundation

struct FavoriteLibrary {

    static let items: [FavoriteItem] = [

        FavoriteItem(
            title: "Call of Duty: Black Ops II",
            subtitle: "First-Person Shooter",
            imageName: "game01",
            rating: 5,
            description: """
            Black Ops II is a first-person shooter set across two different time periods.
            Its campaign explores futuristic warfare and the consequences of player decisions.
            The game is especially remembered for its multiplayer and Zombies modes.
            """
        ),

        FavoriteItem(
            title: "Assassin's Creed II",
            subtitle: "Action Adventure",
            imageName: "game02",
            rating: 5,
            description: """
            Assassin's Creed II follows Ezio Auditore during the Italian Renaissance.
            Players explore cities such as Florence and Venice while uncovering a conspiracy.
            The game combines parkour, stealth, historical settings, and an emotional story.
            """
        ),

        FavoriteItem(
            title: "Grand Theft Auto IV",
            subtitle: "Open-World Action",
            imageName: "game03",
            rating: 5,
            description: """
            GTA IV tells the story of Niko Bellic, an immigrant seeking a new life in Liberty City.
            Its story explores friendship, betrayal, and the darker side of the American Dream.
            The game features an open world with realistic physics and memorable characters.
            """
        ),

        FavoriteItem(
            title: "Mafia II",
            subtitle: "Action Adventure",
            imageName: "game04",
            rating: 5,
            description: """
            Mafia II follows Vito Scaletta as he becomes involved in organized crime.
            The story takes place in a fictional American city during the 1940s and 1950s.
            Its atmosphere, soundtrack, and character development make it a memorable narrative experience.
            """
        ),

        FavoriteItem(
            title: "Helldivers 2",
            subtitle: "Cooperative Shooter",
            imageName: "game05",
            rating: 4,
            description: """
            Helldivers 2 is a cooperative science-fiction action game.
            Players work together to complete missions on hostile alien planets.
            Teamwork, unpredictable situations, and its satirical presentation make every mission different.
            """
        ),

        FavoriteItem(
            title: "Call of Duty: Modern Warfare 2",
            subtitle: "First-Person Shooter · 2009",
            imageName: "game06",
            rating: 5,
            description: """
            Modern Warfare 2 continues the story of the original Modern Warfare.
            Its campaign follows multiple characters during an international military crisis.
            The game became widely known for its cinematic missions and competitive multiplayer.
            """
        ),

        FavoriteItem(
            title: "Need for Speed: Most Wanted",
            subtitle: "Racing · 2005",
            imageName: "game07",
            rating: 5,
            description: """
            Need for Speed: Most Wanted is a street-racing game set in Rockport.
            Players compete against rival racers while building and customizing their cars.
            Police pursuits and an open city are central parts of the experience.
            """
        ),

        FavoriteItem(
            title: "The Witcher 3: Wild Hunt",
            subtitle: "Open-World RPG",
            imageName: "game08",
            rating: 5,
            description: """
            The Witcher 3 follows Geralt of Rivia as he searches for Ciri.
            Players explore a large fantasy world filled with quests and complex characters.
            Its storytelling emphasizes difficult choices and their consequences.
            """
        ),

        FavoriteItem(
            title: "Grand Theft Auto: San Andreas",
            subtitle: "Open-World Action",
            imageName: "game09",
            rating: 5,
            description: """
            San Andreas follows Carl Johnson as he returns to Los Santos.
            The game explores family, loyalty, and rivalries across a fictional American state.
            Players can explore three major cities and participate in many different activities.
            """
        ),

        FavoriteItem(
            title: "Minecraft",
            subtitle: "Sandbox Survival",
            imageName: "game10",
            rating: 5,
            description: """
            Minecraft is a sandbox game built around creativity, exploration, and survival.
            Players can construct buildings, gather resources, and explore randomly generated worlds.
            Its freedom and multiplayer possibilities encourage experimentation and imagination.
            """
        ),

        FavoriteItem(
            title: "Red Dead Redemption 2",
            subtitle: "Open-World Adventure",
            imageName: "game11",
            rating: 5,
            description: """
            Red Dead Redemption 2 follows Arthur Morgan and the Van der Linde gang.
            Its story takes place during the decline of the American frontier.
            The game is known for its detailed world, memorable characters, and emotional storytelling.
            """
        ),

        FavoriteItem(
            title: "Portal 2",
            subtitle: "Puzzle Platformer",
            imageName: "game12",
            rating: 5,
            description: """
            Portal 2 is a puzzle game set inside the Aperture Science facility.
            Players use a portal device to solve increasingly complex environmental puzzles.
            The game combines creative mechanics, clever writing, and dark humor.
            """
        ),

        FavoriteItem(
            title: "Half-Life 2",
            subtitle: "Science Fiction Shooter",
            imageName: "game13",
            rating: 5,
            description: """
            Half-Life 2 follows scientist Gordon Freeman in a world controlled by the Combine.
            Players travel through City 17 and surrounding environments while supporting a resistance movement.
            The game became influential for its physics, environmental storytelling, and immersive design.
            """
        ),

        FavoriteItem(
            title: "Cyberpunk 2077",
            subtitle: "Action RPG",
            imageName: "game14",
            rating: 4,
            description: """
            Cyberpunk 2077 is an open-world role-playing game set in Night City.
            Players control V, a mercenary navigating a world dominated by technology and corporations.
            The game explores identity, ambition, and the relationship between humanity and machines.
            """
        ),

        FavoriteItem(
            title: "Ghost of Tsushima",
            subtitle: "Action Adventure",
            imageName: "game15",
            rating: 5,
            description: """
            Ghost of Tsushima follows samurai Jin Sakai during the Mongol invasion of Tsushima.
            Players explore a beautiful open world inspired by feudal Japan.
            Its story focuses on honor, sacrifice, and the conflict between tradition and necessity.
            """
        ),

        FavoriteItem(
            title: "God of War",
            subtitle: "Action Adventure · 2018",
            imageName: "game16",
            rating: 5,
            description: """
            God of War follows Kratos and his son Atreus through a world inspired by Norse mythology.
            Their journey explores family, responsibility, and personal growth.
            The game combines cinematic storytelling, exploration, and challenging combat.
            """
        ),

        FavoriteItem(
            title: "DOOM Eternal",
            subtitle: "First-Person Shooter",
            imageName: "game17",
            rating: 4,
            description: """
            DOOM Eternal is a fast-paced science-fiction action game.
            Players navigate challenging arenas that reward movement and quick decision-making.
            Its distinctive soundtrack and energetic gameplay create an intense arcade-style experience.
            """
        ),

        FavoriteItem(
            title: "Hollow Knight",
            subtitle: "Metroidvania",
            imageName: "game18",
            rating: 5,
            description: """
            Hollow Knight is an atmospheric exploration game set in the underground kingdom of Hallownest.
            Players discover interconnected locations, hidden secrets, and unusual characters.
            Its hand-drawn art, music, and challenging gameplay create a mysterious experience.
            """
        ),

        FavoriteItem(
            title: "Hades",
            subtitle: "Roguelike Action",
            imageName: "game19",
            rating: 4,
            description: """
            Hades follows Zagreus as he attempts to escape the Greek underworld.
            Each attempt introduces different abilities, encounters, and opportunities to develop relationships.
            The game combines fast action with storytelling that progresses across repeated runs.
            """
        ),

        FavoriteItem(
            title: "Elden Ring",
            subtitle: "Open-World Action RPG",
            imageName: "game20",
            rating: 5,
            description: """
            Elden Ring takes place in the mysterious fantasy world of the Lands Between.
            Players explore a vast landscape filled with hidden locations and challenging encounters.
            Its open-ended progression encourages discovery, experimentation, and different character builds.
            """
        )
    ]
}
