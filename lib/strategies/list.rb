require_relative "./favorite"
require_relative "./last"
require_relative "./adaptive_last"

Strategies = {
    'default' => Favorite,
    'last' => Last,
    'adaptive-last' => AdaptiveLast,
    'favorite' => Favorite
}
