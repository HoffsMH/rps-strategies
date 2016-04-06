require_relative "./favorite"
require_relative "./last"
require_relative "./adaptive_last"
require_relative "./iocaine_powder/iocaine_powder"

Strategies = {
    'default' => Favorite,
    'last' => Last,
    'adaptive-last' => AdaptiveLast,
    'favorite' => Favorite,
    'iocaine-powder' => IocainePowder
}
