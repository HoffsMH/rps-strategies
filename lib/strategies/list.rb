require_relative "./favorite"
require_relative "./last"

Strategies = {
    'default' => Favorite,
    'last' => Last,
    'favorite' => Favorite
}
