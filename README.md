# Business House Game

Simple multiplayer business board game

# Design
* Mulitple games could be played parallely

# Usage

* Install the gem
```gem install --local path_to_gem/game.gem```

* Create the <config>.txt or <config>.yml as show in example below.

```
game1:
  players: 3
  cells_position: [E,E,J,H]
  dice_output: [4,5,6,7]
  initial_money: 1000
  hotel_worth: 200
  hotel_rent: 50
  jail_fine: 150
  treasure_value: 200
game2: [optional]
  ...
```
* Run the following command
```
ruby -Ilib ./bin/play -f <path_to_config_file>
```

# Assumptions
* Format of the file is as show in the example below. Supported format: (YAML, TXT)

```
game1:
  players: 3
  cells_position: [E,E,J,H]
  dice_output: [4,5,6,7]
  initial_money: 1000
  hotel_worth: 200
  hotel_rent: 50
  jail_fine: 150
  treasure_value: 200
game2: [optional]
  ...
```

* cells_position and dice_output fields will be an non-empty array

# Future enhancement:
* Dice output and cells position can be randomly generated
* Usage of enum in board for cell type, will make it more scalable to add more cell types
* Increase the support of muliple input file types
