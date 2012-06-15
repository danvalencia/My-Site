lottery_map = {}
teams = ["Portugal", "Spain", "England", "Germany", "Netherlands", "Sweden", "Russia", "France"]
teams.sort(() -> Math.round(Math.random())-0.5)
lottery_map[player] = teams.shift() for player in ["Bryce", "Scott", "Drew", "Marouan", "Sergey", "Josh", "Tom", "Daniel"]

# lottery_map = {}
# lottery_map[player] = ["Portugal", "Spain", "England", "Germany", "Netherlands", "Sweden", "Russia", "France"].sort(() -> Math.round(Math.random())-0.5).shift() for player in ["Bryce", "Scott", "Drew", "Marouan", "Sergey", "Josh", "Tom", "Daniel"]