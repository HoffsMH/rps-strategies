require_relative "./favorite"
require_relative "./last"
require_relative "./random_move"
require_relative "./adaptive_last"
require_relative "./iocaine_powder/iocaine_powder"

Strategies = {
    'default' => Favorite,
    'last' => Last,
    'favorite' => Favorite,
    'random' => RandomMove,
    'adaptive-last' => AdaptiveLast,
    'iocaine-powder' => IocainePowder
}
